module 0xad66e48148c4c14ac877ce15da7df428712416ef4db5e2f290e8b30e6714e831::simple_token {
    struct SIMPLE_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPLE_TOKEN>(arg0, 9, b"SIMPLE", b"Simple Token", b"A simple token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPLE_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMPLE_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

