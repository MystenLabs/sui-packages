module 0x1441bea8917d40336b7729ec5e17cbfd9e27c26a3a0da82a6633419a476423c0::suiyan {
    struct SUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYAN>(arg0, 6, b"SUIYAN", b"SUPER SUIYAN", b"It's the Super Suiyan cycle!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730987623888.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIYAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

