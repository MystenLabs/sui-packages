module 0x1d0022089419a724797af7dbf92ac3e5c1be18a01ce6aeebaa602e8670cf0073::rofx {
    struct ROFX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROFX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROFX>(arg0, 6, b"Rofx", b"roflox", b"see you soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730986657445.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROFX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROFX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

