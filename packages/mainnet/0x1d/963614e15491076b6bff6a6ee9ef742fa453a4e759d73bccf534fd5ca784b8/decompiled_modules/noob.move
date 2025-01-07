module 0x1d963614e15491076b6bff6a6ee9ef742fa453a4e759d73bccf534fd5ca784b8::noob {
    struct NOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOB>(arg0, 9, b"NOOB", b"Noobsui", b"Explore the Creative world of Sui together ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wallpapers.com/images/featured-full/roblox-noob-tvbx5seocj9b6t7r.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOOB>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

