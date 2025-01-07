module 0xbd24a486f0939d51ceac6beb21bae95cc4a7cbf1c3a59ce73e701b75c9be60b::hopeless {
    struct HOPELESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPELESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPELESS>(arg0, 6, b"HOPELESS", b"hopfun localhost", b"indian dev from hop fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730972894297.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPELESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPELESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

