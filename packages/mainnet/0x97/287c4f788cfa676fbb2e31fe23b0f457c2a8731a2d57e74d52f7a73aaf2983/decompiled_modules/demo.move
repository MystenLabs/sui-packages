module 0x97287c4f788cfa676fbb2e31fe23b0f457c2a8731a2d57e74d52f7a73aaf2983::demo {
    struct DEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMO>(arg0, 6, b"DEMO", b"demo", b"full demo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748461131179.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

