module 0x3aab95ca988515505ebe1542f3ab6e9d065cb65c7bb4fc81d95d66a3934f2e2e::roastface {
    struct Hall has key {
        id: 0x2::object::UID,
        total_fees: u64,
    }

    struct RoastNFT has key {
        id: 0x2::object::UID,
        victim: address,
        insult: 0x1::string::String,
        animated_video_blob_id: 0x1::string::String,
        original_image_blob_id: 0x1::string::String,
        rarity: u8,
        tier_name: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hall{
            id         : 0x2::object::new(arg0),
            total_fees : 0,
        };
        0x2::transfer::share_object<Hall>(v0);
    }

    public fun roast_and_mint(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::random::Random, arg5: &mut Hall, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 2000000000, 0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v2 = v1 * 95 / 100;
        arg5.total_fees = arg5.total_fees + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v1 - v2, arg6), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
        let v3 = 0x2::random::new_generator(arg4, arg6);
        let v4 = 0x2::random::generate_u8_in_range(&mut v3, 0, 99);
        let (v5, v6) = if (v4 < 90) {
            (0, 0x1::string::utf8(b"Common"))
        } else if (v4 < 99) {
            (1, 0x1::string::utf8(b"Silver"))
        } else if (v4 == 99) {
            (2, 0x1::string::utf8(b"Gold"))
        } else {
            (3, 0x1::string::utf8(b"DIAMOND"))
        };
        let v7 = RoastNFT{
            id                     : 0x2::object::new(arg6),
            victim                 : v0,
            insult                 : arg1,
            animated_video_blob_id : arg2,
            original_image_blob_id : arg3,
            rarity                 : v5,
            tier_name              : v6,
        };
        0x2::transfer::transfer<RoastNFT>(v7, v0);
    }

    // decompiled from Move bytecode v6
}

