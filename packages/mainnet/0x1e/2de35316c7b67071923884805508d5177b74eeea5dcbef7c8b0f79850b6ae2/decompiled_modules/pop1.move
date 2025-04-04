module 0x1e2de35316c7b67071923884805508d5177b74eeea5dcbef7c8b0f79850b6ae2::pop1 {
    struct POP1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POP1>(arg0, 9, b"POP1", b"pop", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8c05739952dc2451d9f488c90d859e75blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POP1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

