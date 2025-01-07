module 0x12ce6499fd8dd66a9ee19d8fc41e5ad442fddd1a060d3ea3ee8bed0adabf973e::sms {
    struct SMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMS>(arg0, 6, b"SMS", b"somsom", b"Co-founder of Bunnydog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731012670154.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

