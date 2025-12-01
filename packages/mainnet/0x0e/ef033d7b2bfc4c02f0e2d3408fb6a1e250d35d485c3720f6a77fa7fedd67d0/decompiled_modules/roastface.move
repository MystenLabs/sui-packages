module 0xeef033d7b2bfc4c02f0e2d3408fb6a1e250d35d485c3720f6a77fa7fedd67d0::roastface {
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
        let v1 = if (v0 == @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8) {
            10000000000
        } else {
            let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
            assert!(v2 >= 10000000000, 0);
            v2
        };
        let v3 = v1 * 60 / 100;
        arg5.total_fees = arg5.total_fees + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v1 - v3, arg6), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
        let v4 = 0x2::random::new_generator(arg4, arg6);
        let v5 = 0x2::random::generate_u8_in_range(&mut v4, 0, 99);
        let (v6, v7) = if (v5 < 90) {
            (0, 0x1::string::utf8(b"Common"))
        } else if (v5 < 99) {
            (1, 0x1::string::utf8(b"Silver"))
        } else if (v5 == 99) {
            (2, 0x1::string::utf8(b"Gold"))
        } else {
            (3, 0x1::string::utf8(b"DIAMOND"))
        };
        let v8 = RoastNFT{
            id                     : 0x2::object::new(arg6),
            victim                 : v0,
            insult                 : arg1,
            animated_video_blob_id : arg2,
            original_image_blob_id : arg3,
            rarity                 : v6,
            tier_name              : v7,
        };
        0x2::transfer::transfer<RoastNFT>(v8, v0);
    }

    // decompiled from Move bytecode v6
}

