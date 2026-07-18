module 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::feeds {
    struct FeedRegistry has key {
        id: 0x2::object::UID,
        feeds: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<u8>>,
    }

    struct FeedSet has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        feed: vector<u8>,
    }

    public fun feed_of<T0>(arg0: &FeedRegistry) : vector<u8> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.feeds, &v0), 0);
        *0x2::vec_map::get<0x1::type_name::TypeName, vector<u8>>(&arg0.feeds, &v0)
    }

    public fun has_feed<T0>(arg0: &FeedRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.feeds, &v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeedRegistry{
            id    : 0x2::object::new(arg0),
            feeds : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<u8>>(),
        };
        0x2::transfer::share_object<FeedRegistry>(v0);
    }

    public fun set_feed<T0>(arg0: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::admin::AdminCap, arg1: &mut FeedRegistry, arg2: vector<u8>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg1.feeds, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, vector<u8>>(&mut arg1.feeds, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, vector<u8>>(&mut arg1.feeds, v0, arg2);
        };
        let v1 = FeedSet{
            coin_type : v0,
            feed      : arg2,
        };
        0x2::event::emit<FeedSet>(v1);
    }

    // decompiled from Move bytecode v7
}

