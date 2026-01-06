module 0x4967179badb313427b6383edab68eadf553b8c2795cd2ac69a68dbd569a8a336::create_pool {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: address,
        sui_amount: u64,
        meme_amount: u64,
        sender: address,
    }

    public fun init_cetus_pool(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x4967179badb313427b6383edab68eadf553b8c2795cd2ac69a68dbd569a8a336::meme_token::MEME_TOKEN>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<0x4967179badb313427b6383edab68eadf553b8c2795cd2ac69a68dbd569a8a336::meme_token::MEME_TOKEN>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 200;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 1000000000, 2);
        assert!(0x2::coin::value<0x4967179badb313427b6383edab68eadf553b8c2795cd2ac69a68dbd569a8a336::meme_token::MEME_TOKEN>(&arg2) >= 40000000000000, 2);
        let v1 = if (v0 == 100) {
            true
        } else if (v0 == 200) {
            true
        } else if (v0 == 500) {
            true
        } else {
            v0 == 3000
        };
        assert!(v1, 5);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<0x4967179badb313427b6383edab68eadf553b8c2795cd2ac69a68dbd569a8a336::meme_token::MEME_TOKEN, 0x2::sui::SUI>(arg4, arg3, v0, 92233720368547760, 0x1::string::utf8(b""), 4294523696, 443600, 0x2::coin::split<0x4967179badb313427b6383edab68eadf553b8c2795cd2ac69a68dbd569a8a336::meme_token::MEME_TOKEN>(&mut arg2, 40000000000000, arg8), 0x2::coin::split<0x2::sui::SUI>(&mut arg1, 1000000000, arg8), arg6, arg5, true, arg7, arg8);
        let v5 = v4;
        let v6 = v3;
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v2, arg0);
        let v7 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        let v8 = 0x2::coin::value<0x4967179badb313427b6383edab68eadf553b8c2795cd2ac69a68dbd569a8a336::meme_token::MEME_TOKEN>(&v6);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, arg0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v5);
        };
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4967179badb313427b6383edab68eadf553b8c2795cd2ac69a68dbd569a8a336::meme_token::MEME_TOKEN>>(v6, arg0);
        } else {
            0x2::coin::destroy_zero<0x4967179badb313427b6383edab68eadf553b8c2795cd2ac69a68dbd569a8a336::meme_token::MEME_TOKEN>(v6);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        if (0x2::coin::value<0x4967179badb313427b6383edab68eadf553b8c2795cd2ac69a68dbd569a8a336::meme_token::MEME_TOKEN>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4967179badb313427b6383edab68eadf553b8c2795cd2ac69a68dbd569a8a336::meme_token::MEME_TOKEN>>(arg2, arg0);
        } else {
            0x2::coin::destroy_zero<0x4967179badb313427b6383edab68eadf553b8c2795cd2ac69a68dbd569a8a336::meme_token::MEME_TOKEN>(arg2);
        };
        let v9 = PoolCreatedEvent{
            pool_id     : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools>(arg3),
            sui_amount  : 1000000000 - v7,
            meme_amount : 40000000000000 - v8,
            sender      : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<PoolCreatedEvent>(v9);
        true
    }

    // decompiled from Move bytecode v6
}

