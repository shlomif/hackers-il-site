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
    'value' => "The Hackers-IL Homepage",
    'title' => "Hackers-IL: Israeli Software Enthusiasts",
    'expand_re' => "",
    'subs' =>
    [
        {
            'value' => "Home",
            'url' => "",
        },
        {
            'value' => "Wiki",
            'url' => "wiki/",
        },
        {
            'value' => "Mailing Lists",
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
