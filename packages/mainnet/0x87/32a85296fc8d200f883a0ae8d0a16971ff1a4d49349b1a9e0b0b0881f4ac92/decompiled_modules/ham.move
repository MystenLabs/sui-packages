module 0x8732a85296fc8d200f883a0ae8d0a16971ff1a4d49349b1a9e0b0b0881f4ac92::ham {
    struct HAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAM>(arg0, 6, b"HAM", b"smokeingdrunkham", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://koi.family/api/images/8ad82adeddd0ff2d14b035e0067683769aa862ffe12234fa0ed8bb3e600b1950.png")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAM>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAM>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

