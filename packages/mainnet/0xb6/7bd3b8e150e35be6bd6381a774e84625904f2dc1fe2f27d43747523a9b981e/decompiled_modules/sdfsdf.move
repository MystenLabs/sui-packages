module 0xb67bd3b8e150e35be6bd6381a774e84625904f2dc1fe2f27d43747523a9b981e::sdfsdf {
    struct SDFSDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFSDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFSDF>(arg0, 9, b"SDFSDF", b"JKBNSD", b"JKADSHUISDHF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SDFSDF>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFSDF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDFSDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

