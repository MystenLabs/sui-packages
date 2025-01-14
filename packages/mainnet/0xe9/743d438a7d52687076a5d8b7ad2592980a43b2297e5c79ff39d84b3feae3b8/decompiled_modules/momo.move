module 0xe9743d438a7d52687076a5d8b7ad2592980a43b2297e5c79ff39d84b3feae3b8::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMO>(arg0, 6, b"Momo", b"momo", x"6d6f6d6f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736861566307.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

