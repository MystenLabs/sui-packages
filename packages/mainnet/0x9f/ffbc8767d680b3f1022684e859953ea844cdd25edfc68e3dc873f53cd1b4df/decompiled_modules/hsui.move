module 0x9fffbc8767d680b3f1022684e859953ea844cdd25edfc68e3dc873f53cd1b4df::hsui {
    struct HSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSUI>(arg0, 9, b"HSUI", b"Homer Suimpson", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"x")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HSUI>(&mut v2, 66666666000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

