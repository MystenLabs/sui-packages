module 0x8340a7cf76aac2dd27fbab13b654f70b2de6de5361e08889191badb7ccd4aa28::suido {
    struct SUIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIDO>(arg0, 6, b"SUIDO", b"Suido", b"He came. He sat. He conquered. Suido.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suido_3_4ba481be2f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

