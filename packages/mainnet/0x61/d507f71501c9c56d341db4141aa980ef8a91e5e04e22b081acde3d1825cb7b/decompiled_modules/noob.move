module 0x61d507f71501c9c56d341db4141aa980ef8a91e5e04e22b081acde3d1825cb7b::noob {
    struct NOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOB>(arg0, 9, b"NOOB", b"Noobsui", b"Explore the world of sui together!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wallpapers.com/images/featured-full/roblox-noob-tvbx5seocj9b6t7r.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<NOOB>(&mut v2, 200000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOB>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

