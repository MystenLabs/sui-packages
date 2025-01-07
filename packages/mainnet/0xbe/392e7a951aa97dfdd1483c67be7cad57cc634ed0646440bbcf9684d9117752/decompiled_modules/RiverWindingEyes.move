module 0xbe392e7a951aa97dfdd1483c67be7cad57cc634ed0646440bbcf9684d9117752::RiverWindingEyes {
    struct RIVERWINDINGEYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIVERWINDINGEYES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIVERWINDINGEYES>(arg0, 0, b"COS", b"River-Winding Eyes", b"Look the current in the eye. It is within you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_River-Winding_Eyes.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIVERWINDINGEYES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIVERWINDINGEYES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

