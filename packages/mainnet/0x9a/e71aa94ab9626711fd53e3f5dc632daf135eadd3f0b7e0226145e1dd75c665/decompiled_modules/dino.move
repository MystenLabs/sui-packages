module 0x9ae71aa94ab9626711fd53e3f5dc632daf135eadd3f0b7e0226145e1dd75c665::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"DINO", b"DinoSui", x"2444696e6f20697320612070657266656374206578616d706c65206f6620686f772061206d656d652062617365642070726f6a6563742063616e2065766f6c766520696e746f206120636f6d706c657820616e6420686967686c792076616c7561626c652065636f73797374656d2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_b3a54da8a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

