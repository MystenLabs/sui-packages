module 0xe5d7a779e3733661728412aac84d6dbe1d460da75b38ffeb886ef3e5e5abdfd2::deez {
    struct DEEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEZ>(arg0, 6, b"DEEZ", b"Deez Nuts", b"Sui Nuts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730981663494.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

