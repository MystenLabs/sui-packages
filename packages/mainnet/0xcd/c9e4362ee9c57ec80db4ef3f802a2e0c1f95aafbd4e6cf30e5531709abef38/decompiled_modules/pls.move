module 0xcdc9e4362ee9c57ec80db4ef3f802a2e0c1f95aafbd4e6cf30e5531709abef38::pls {
    struct PLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLS>(arg0, 6, b"PLS", b"Can you ?", x"446f6e277420627579203a28200a0a427579203a29", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731061955834.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

