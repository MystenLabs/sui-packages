module 0xb9d8fcdf234f91385960136336c9a3d790b88f46172d4fb391f419df42d140a5::tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUI>(arg0, 6, b"TSUI", b"Test SUI", b"Just a test. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737283702528.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

