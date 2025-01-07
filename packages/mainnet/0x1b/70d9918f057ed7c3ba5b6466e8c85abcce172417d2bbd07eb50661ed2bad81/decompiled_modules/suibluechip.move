module 0x1b70d9918f057ed7c3ba5b6466e8c85abcce172417d2bbd07eb50661ed2bad81::suibluechip {
    struct SUIBLUECHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBLUECHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBLUECHIP>(arg0, 6, b"SUIBLUECHIP", b"SuiChip", b"Blue SUI chip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_10_14_035554156_87f4f619be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBLUECHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBLUECHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

