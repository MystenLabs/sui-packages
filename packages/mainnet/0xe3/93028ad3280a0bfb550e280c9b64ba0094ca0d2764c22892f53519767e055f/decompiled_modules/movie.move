module 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::movie {
    struct Movie has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        release_year: u16,
        image_url: 0x1::string::String,
        create_date: u64,
        watch_count: u64,
        comments_count: u64,
        genres: vector<0x1::string::String>,
    }

    struct MovieAdded has copy, drop {
        movie_id: 0x2::object::ID,
        title: 0x1::string::String,
        create_date: u64,
        release_year: u16,
        genres: vector<0x1::string::String>,
    }

    public fun create(arg0: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u16, arg4: 0x1::string::String, arg5: u64, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg0, 0x2::tx_context::sender(arg7));
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg0);
        assert!(arg3 >= 1878, 0);
        let v0 = 0x2::object::new(arg7);
        let v1 = MovieAdded{
            movie_id     : 0x2::object::uid_to_inner(&v0),
            title        : arg1,
            create_date  : arg5,
            release_year : arg3,
            genres       : arg6,
        };
        let v2 = Movie{
            id             : v0,
            title          : arg1,
            description    : arg2,
            release_year   : arg3,
            image_url      : arg4,
            create_date    : arg5,
            watch_count    : 0,
            comments_count : 0,
            genres         : arg6,
        };
        0x2::event::emit<MovieAdded>(v1);
        0x2::transfer::share_object<Movie>(v2);
    }

    public fun create_date(arg0: &Movie) : u64 {
        arg0.create_date
    }

    public fun description(arg0: &Movie) : 0x1::string::String {
        arg0.description
    }

    public fun genres(arg0: &Movie) : vector<0x1::string::String> {
        arg0.genres
    }

    public fun image_url(arg0: &Movie) : 0x1::string::String {
        arg0.image_url
    }

    public(friend) fun increment_watch_count(arg0: &mut Movie) {
        arg0.watch_count = arg0.watch_count + 1;
    }

    public fun release_year(arg0: &Movie) : u16 {
        arg0.release_year
    }

    public fun set_comments_count(arg0: &mut Movie, arg1: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg1, 0x2::tx_context::sender(arg3));
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg1);
        arg0.comments_count = arg2;
    }

    public fun set_description(arg0: &mut Movie, arg1: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg1, 0x2::tx_context::sender(arg3));
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg1);
        arg0.description = arg2;
    }

    public fun set_genres(arg0: &mut Movie, arg1: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg2: vector<0x1::string::String>, arg3: &0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg1, 0x2::tx_context::sender(arg3));
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg1);
        arg0.genres = arg2;
    }

    public fun set_image_url(arg0: &mut Movie, arg1: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg1, 0x2::tx_context::sender(arg3));
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg1);
        arg0.image_url = arg2;
    }

    public fun set_release_year(arg0: &mut Movie, arg1: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg1, 0x2::tx_context::sender(arg3));
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg1);
        assert!(arg2 >= 1878, 0);
        arg0.release_year = arg2;
    }

    public fun set_title(arg0: &mut Movie, arg1: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg1, 0x2::tx_context::sender(arg3));
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg1);
        arg0.title = arg2;
    }

    public fun title(arg0: &Movie) : 0x1::string::String {
        arg0.title
    }

    public fun watch_count(arg0: &Movie) : u64 {
        arg0.watch_count
    }

    // decompiled from Move bytecode v6
}

