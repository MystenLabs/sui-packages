module 0xd7e042dc29df402777b91a85e02b9b63a0679c8338b6ddaa8a6e4248a3f4557b::bpug {
    struct BPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUG>(arg0, 6, b"BPUG", b"BABY PUG", x"4865726520776520676f0a4d7920646164647920697320406675647468657075670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731393629632.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

