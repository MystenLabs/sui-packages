module 0x156d6459b10c67a7cf98cfcb64b6aa1c25fed6f6a6489a85735f0b8e152add37::inuki {
    struct INUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INUKI>(arg0, 6, b"INUKI", b"Inuki", b"Inuki ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Inuki_7221764012.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

