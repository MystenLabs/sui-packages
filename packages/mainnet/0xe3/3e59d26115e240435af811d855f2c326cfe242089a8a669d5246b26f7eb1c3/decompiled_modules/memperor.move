module 0xe33e59d26115e240435af811d855f2c326cfe242089a8a669d5246b26f7eb1c3::memperor {
    struct MEMPEROR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMPEROR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMPEROR>(arg0, 6, b"MEMPEROR", b"The Emperor", x"54686520456d7065726f72206f66204d656d65732057656c636f6d6520746f204d454d5045524f522c207468652066697273742065766572206d656d65636f696e2064657369676e656420746f20726569676e2073757072656d65206f766572207468652064796e616d69632c206368616f7469632c20616e6420776f6e64657266756c6c7920656e676167696e6720756e697665727365206f66206d656d65732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_09_26_04_56_34_e8941b2f9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMPEROR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMPEROR>>(v1);
    }

    // decompiled from Move bytecode v6
}

