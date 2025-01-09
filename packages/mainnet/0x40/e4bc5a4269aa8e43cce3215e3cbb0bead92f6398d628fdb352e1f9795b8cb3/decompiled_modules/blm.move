module 0x40e4bc5a4269aa8e43cce3215e3cbb0bead92f6398d628fdb352e1f9795b8cb3::blm {
    struct BLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLM>(arg0, 9, b"BLM", b"BLM", b"Biggest Language Model", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1877177748994609152/g4MMFyrO_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLM>(&mut v2, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLM>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

