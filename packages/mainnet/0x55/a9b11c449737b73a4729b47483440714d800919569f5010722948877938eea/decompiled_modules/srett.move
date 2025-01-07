module 0x55a9b11c449737b73a4729b47483440714d800919569f5010722948877938eea::srett {
    struct SRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRETT>(arg0, 6, b"Srett", b"Brett on Sui", x"4272657474206f6e205375690a415448", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3604_2500ec49a5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

