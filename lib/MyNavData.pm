package MyNavData;

my $hosts =
{
    'hackers' => 
    {
        'base_url' => "http://www.hackers.org.il/",
    },
};

my $tree_contents =
{
    'host' => "hackers",
    'text' => "The Hackers-IL Homepage",
    'title' => "Hackers-IL: Israeli Software Enthusiasts",
    'expand_re' => "",
    'subs' =>
    [
        {
            'text' => "Home",
            'url' => "",
        },
        {
            'text' => "Wiki",
            'url' => "wiki/",
        },
        {
            'text' => "Mailing Lists",
            'url' => "mailing-lists/",
        },
    ],
};

sub get_params
{
    return 
        (
            'hosts' => $hosts,
            'tree_contents' => $tree_contents,
        );
}

1;
