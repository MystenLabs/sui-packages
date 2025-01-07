module 0xba0ee65508abf774d098bc25905d6b547426c434576390f1d0e6a7bae53e27d8::ProudShamansAcorn {
    struct PROUDSHAMANSACORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROUDSHAMANSACORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROUDSHAMANSACORN>(arg0, 0, b"COS", b"Proud Shaman's Acorn", b"Your SacredChant... light aglow in the leaves and the trees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Proud_Shaman's_Acorn.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROUDSHAMANSACORN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROUDSHAMANSACORN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

