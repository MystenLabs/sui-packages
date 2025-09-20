module 0x1152a7395f512be6527f8e24d12bf6c3f5744f5cf72ea2247a84c5c89967ad11::Sandler {
    struct SANDLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANDLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANDLER>(arg0, 9, b"SANDLER", b"Sandler", b"gay actor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G1LbBcuWwAAE6Ie?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANDLER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANDLER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

