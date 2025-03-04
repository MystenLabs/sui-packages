module 0xa0c469e5c57740bd6f1e3a1f061eb94b4265e91fd601c2c2adc8b0e8314a54eb::video_events {
    struct Costs has store, key {
        id: 0x2::object::UID,
        video_load_cost: u64,
        boost_cost: u64,
    }

    struct VideoLoadEvent has copy, drop {
        video_id: vector<u8>,
        creator: vector<u8>,
        size_in_bytes: 0x1::option::Option<u64>,
        title: vector<u8>,
        description: 0x1::option::Option<vector<u8>>,
    }

    struct VideoBoostEvent has copy, drop {
        booster_account: address,
        video_id: vector<u8>,
        boost_count: u64,
    }

    public entry fun admin_only_function(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x59b380ff7830988edac81dd695891adc44878ebd575bb170db4750e253b98268, 2);
    }

    public fun get_boost_cost(arg0: &Costs) : u64 {
        arg0.boost_cost
    }

    public fun get_video_load_cost(arg0: &Costs) : u64 {
        arg0.video_load_cost
    }

    public fun init_module(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Costs{
            id              : 0x2::object::new(arg0),
            video_load_cost : 100000000,
            boost_cost      : 100000000,
        };
        0x2::transfer::share_object<Costs>(v0);
    }

    public entry fun set_boost_cost(arg0: &mut Costs, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x59b380ff7830988edac81dd695891adc44878ebd575bb170db4750e253b98268, 2);
        arg0.boost_cost = arg1;
    }

    public entry fun set_video_load_cost(arg0: &mut Costs, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x59b380ff7830988edac81dd695891adc44878ebd575bb170db4750e253b98268, 2);
        arg0.video_load_cost = arg1;
    }

    public entry fun video_boost(arg0: vector<u8>, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &Costs, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * arg3.boost_cost;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        let v1 = VideoBoostEvent{
            booster_account : 0x2::tx_context::sender(arg4),
            video_id        : arg0,
            boost_count     : arg1,
        };
        0x2::event::emit<VideoBoostEvent>(v1);
    }

    public entry fun video_load(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x1::option::Option<u64>, arg3: vector<u8>, arg4: 0x1::option::Option<vector<u8>>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &Costs, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= arg6.video_load_cost, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, arg6.video_load_cost, arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, 0x2::tx_context::sender(arg7));
        let v0 = VideoLoadEvent{
            video_id      : arg0,
            creator       : arg1,
            size_in_bytes : arg2,
            title         : arg3,
            description   : arg4,
        };
        0x2::event::emit<VideoLoadEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

