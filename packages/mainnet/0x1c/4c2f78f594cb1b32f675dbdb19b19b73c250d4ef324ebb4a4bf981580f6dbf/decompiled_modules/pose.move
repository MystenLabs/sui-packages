module 0x1c4c2f78f594cb1b32f675dbdb19b19b73c250d4ef324ebb4a4bf981580f6dbf::pose {
    struct POSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSE>(arg0, 6, b"POSE", b"POSUIDON", x"4d616a657374696320677561726469616e206f66207468652024535549206f6365616e2e2050726f74656374696e672074686520636f6d6d756e6974792066726f6d207363616d7320616e64207275672070756c6c73efbc81", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737046975717.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

