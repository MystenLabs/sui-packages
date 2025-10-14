module 0x512d8ff6431770eed9d2bd7bba16bc39c55e079094852b553032fb01b3ef5fa0::platform_token {
    struct PLATFORM_TOKEN has drop {
        dummy_field: bool,
    }

    struct LaunchRegistry has key {
        id: 0x2::object::UID,
        launches: 0x2::table::Table<0x2::object::ID, LaunchInfo>,
        launch_count: u64,
    }

    struct LaunchInfo has store {
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        created_at: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_launch<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut LaunchRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x512d8ff6431770eed9d2bd7bba16bc39c55e079094852b553032fb01b3ef5fa0::bonding_curve::LaunchConfig, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x512d8ff6431770eed9d2bd7bba16bc39c55e079094852b553032fb01b3ef5fa0::bonding_curve::create_token<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        if (0x2::coin::value<0x2::sui::SUI>(&arg8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x512d8ff6431770eed9d2bd7bba16bc39c55e079094852b553032fb01b3ef5fa0::bonding_curve::buy<T0>(&mut v0, arg8, 0, arg9, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg8);
        };
        let v1 = LaunchInfo{
            creator    : 0x2::tx_context::sender(arg10),
            name       : arg2,
            symbol     : arg3,
            created_at : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::table::add<0x2::object::ID, LaunchInfo>(&mut arg1.launches, 0x2::object::id<0x512d8ff6431770eed9d2bd7bba16bc39c55e079094852b553032fb01b3ef5fa0::bonding_curve::TokenLaunch<T0>>(&v0), v1);
        arg1.launch_count = arg1.launch_count + 1;
        0x512d8ff6431770eed9d2bd7bba16bc39c55e079094852b553032fb01b3ef5fa0::bonding_curve::share_launch<T0>(v0);
    }

    public fun get_launch_count(arg0: &LaunchRegistry) : u64 {
        arg0.launch_count
    }

    fun init(arg0: PLATFORM_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLATFORM_TOKEN>(arg0, 9, b"SWU", b"SWU Platform Token", b"Platform token for SWU launchpad", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLATFORM_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLATFORM_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = LaunchRegistry{
            id           : 0x2::object::new(arg1),
            launches     : 0x2::table::new<0x2::object::ID, LaunchInfo>(arg1),
            launch_count : 0,
        };
        0x2::transfer::share_object<LaunchRegistry>(v3);
    }

    // decompiled from Move bytecode v6
}

