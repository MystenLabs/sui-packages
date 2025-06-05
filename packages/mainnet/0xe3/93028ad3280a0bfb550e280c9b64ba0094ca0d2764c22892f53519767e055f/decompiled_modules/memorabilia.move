module 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::memorabilia {
    struct MemorabiliaNFT has key {
        id: 0x2::object::UID,
        movie_title: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        theater: 0x1::string::String,
        mint_date: u64,
    }

    struct MemorabiliaMinted has copy, drop {
        memorabilia_id: 0x2::object::ID,
        movie_title: 0x1::string::String,
        theater: 0x1::string::String,
        mint_date: u64,
        recipient: address,
    }

    public fun description(arg0: &MemorabiliaNFT) : 0x1::string::String {
        arg0.description
    }

    public fun image_url(arg0: &MemorabiliaNFT) : 0x1::string::String {
        arg0.image_url
    }

    public fun mint(arg0: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg1: &mut 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::movie::Movie, arg2: &mut 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::profile::Profile, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg0, 0x2::tx_context::sender(arg6));
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg0);
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::profile::has_user_access(arg2, arg5);
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::movie::increment_watch_count(arg1);
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::profile::increment_movies_watched_count(arg2);
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::movie::title(arg1);
        let v3 = MemorabiliaMinted{
            memorabilia_id : 0x2::object::uid_to_inner(&v0),
            movie_title    : v2,
            theater        : arg3,
            mint_date      : v1,
            recipient      : arg5,
        };
        0x2::event::emit<MemorabiliaMinted>(v3);
        let v4 = MemorabiliaNFT{
            id          : v0,
            movie_title : v2,
            description : 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::movie::description(arg1),
            image_url   : 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::movie::image_url(arg1),
            theater     : arg3,
            mint_date   : v1,
        };
        0x2::transfer::transfer<MemorabiliaNFT>(v4, arg5);
    }

    public fun mint_date(arg0: &MemorabiliaNFT) : u64 {
        arg0.mint_date
    }

    public fun movie_title(arg0: &MemorabiliaNFT) : 0x1::string::String {
        arg0.movie_title
    }

    public fun theater(arg0: &MemorabiliaNFT) : 0x1::string::String {
        arg0.theater
    }

    // decompiled from Move bytecode v6
}

