module 0x42027673edc91ffd29bc1d34aa06230a6c59cf64f99bf7ef397d2abf3abd8633::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOS>(arg0, 6, b"BoS", b"Brett on Sui", x"54686520636f6d6d756e6974792064726976656e206d6173636f7420244252455454206f6e200a405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BRET_16e62025b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

