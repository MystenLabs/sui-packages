module 0x507cb236b14cc228ab1b2c844c187afeda2ce6ff780d26c1b03c3ccb002724ba::hui {
    struct HUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUI>(arg0, 6, b"HUI", b"Haram Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ytimg.com/vi/M5ePB8zBbtY/maxresdefault.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HUI>(&mut v2, 66666666000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

