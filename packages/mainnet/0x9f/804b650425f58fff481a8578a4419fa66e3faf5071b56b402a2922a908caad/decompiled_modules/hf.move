module 0x9f804b650425f58fff481a8578a4419fa66e3faf5071b56b402a2922a908caad::hf {
    struct HF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HF>(arg0, 9, b"HF", b"HyperFi", b"HyperFi for real MEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HF>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HF>>(v1);
    }

    // decompiled from Move bytecode v6
}

