module 0xab33304cf6c1648e8768183f49c78858a826252c22622b86ecb9b275d907e7e6::noobsui {
    struct NOOBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOBSUI>(arg0, 9, b"NOOBSUI", b"Noobsui", b"Explore the Creative world of Sui together ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wallpapers.com/images/featured-full/roblox-noob-tvbx5seocj9b6t7r.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOOBSUI>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOBSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOOBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

