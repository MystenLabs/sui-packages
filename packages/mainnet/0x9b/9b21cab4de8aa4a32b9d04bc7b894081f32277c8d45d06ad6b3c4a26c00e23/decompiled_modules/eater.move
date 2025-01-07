module 0x9b9b21cab4de8aa4a32b9d04bc7b894081f32277c8d45d06ad6b3c4a26c00e23::eater {
    struct EATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: EATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EATER>(arg0, 6, b"EATER", b"PURPLE PEOPLE EATER", b"He's adorable, he's ferocious and he's HUNGRY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731336720600.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EATER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EATER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

