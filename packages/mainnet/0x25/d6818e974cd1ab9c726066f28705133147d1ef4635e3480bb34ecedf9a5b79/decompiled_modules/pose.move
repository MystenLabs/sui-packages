module 0x25d6818e974cd1ab9c726066f28705133147d1ef4635e3480bb34ecedf9a5b79::pose {
    struct POSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSE>(arg0, 6, b"POSE", b"POSUIDON", x"4d616a657374696320677561726469616e206f66207468652024535549206f6365616e2e0a50726f74656374696e672074686520636f6d6d756e6974792066726f6d207363616d7320616e64207275672070756c6c732e0a42656c6965766520696e2024504f53452e2054727573742074686520f09f94b1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737146047346.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

