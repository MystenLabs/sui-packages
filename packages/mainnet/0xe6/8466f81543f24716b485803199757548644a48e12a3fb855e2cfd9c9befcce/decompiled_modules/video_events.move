module 0xe68466f81543f24716b485803199757548644a48e12a3fb855e2cfd9c9befcce::video_events {
    struct VideoLoadEvent has copy, drop {
        video_id: vector<u8>,
        creator: address,
        size_bytes: 0x1::option::Option<u64>,
        title: vector<u8>,
        description: 0x1::option::Option<vector<u8>>,
    }

    struct VideoBoostEvent has copy, drop {
        booster_account: address,
        video_id: vector<u8>,
        boost_count: u64,
    }

    public entry fun video_boost(arg0: vector<u8>, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 1000000000 * arg1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x59b380ff7830988edac81dd695891adc44878ebd575bb170db4750e253b98268);
        let v0 = VideoBoostEvent{
            booster_account : 0x2::tx_context::sender(arg3),
            video_id        : arg0,
            boost_count     : arg1,
        };
        0x2::event::emit<VideoBoostEvent>(v0);
    }

    public entry fun video_load(arg0: vector<u8>, arg1: 0x1::option::Option<u64>, arg2: vector<u8>, arg3: 0x1::option::Option<vector<u8>>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == 2000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, @0x59b380ff7830988edac81dd695891adc44878ebd575bb170db4750e253b98268);
        let v0 = VideoLoadEvent{
            video_id    : arg0,
            creator     : 0x2::tx_context::sender(arg5),
            size_bytes  : arg1,
            title       : arg2,
            description : arg3,
        };
        0x2::event::emit<VideoLoadEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

