module 0x1e74d8cdd51bb63b61983dd8ef958ce33a4401ec5e700b8eff386bc9dacd3a9d::giga {
    struct GIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGA>(arg0, 9, b"GIGA", b"GigaChad", b"GigaChad is going higher!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1644048234250403840/uSY95Hvk.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GIGA>(&mut v2, 1200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

