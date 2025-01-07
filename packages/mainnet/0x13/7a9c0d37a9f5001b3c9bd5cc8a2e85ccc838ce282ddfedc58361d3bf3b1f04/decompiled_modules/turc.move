module 0x137a9c0d37a9f5001b3c9bd5cc8a2e85ccc838ce282ddfedc58361d3bf3b1f04::turc {
    struct TURC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURC>(arg0, 6, b"TURC", b"sadasads", x"49204c564f4520594f55204655434bc4b0494e4747", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731132189953.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

