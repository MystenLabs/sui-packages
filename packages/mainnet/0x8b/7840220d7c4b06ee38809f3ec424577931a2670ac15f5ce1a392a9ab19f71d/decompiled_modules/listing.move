module 0x9e278ca160510dc1556d04eaa0b5bb5ef41e10111f74e685159eb98ce4bd2351::listing {
    entry fun list_coin<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: 0x2::coin::Coin<0x9e278ca160510dc1556d04eaa0b5bb5ef41e10111f74e685159eb98ce4bd2351::create_token_workshop::CREATE_TOKEN_WORKSHOP>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T0, 0x9e278ca160510dc1556d04eaa0b5bb5ef41e10111f74e685159eb98ce4bd2351::create_token_workshop::CREATE_TOKEN_WORKSHOP>(arg0, arg1, 60, 583313028212173400000, 0x1::string::utf8(b"https://res.cloudinary.com/georgegoldman/image/upload/v1775824438/github_profile_compressed_tstbqw.jpg"), 4294523716, 443580, arg3, arg2, true, arg4, arg5);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9e278ca160510dc1556d04eaa0b5bb5ef41e10111f74e685159eb98ce4bd2351::create_token_workshop::CREATE_TOKEN_WORKSHOP>>(v2, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v7
}

