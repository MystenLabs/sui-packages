module 0x46a20c44f98c26314db4ea82e1e71a54a5c6e38b8a16ec2d07d2a0498518d12a::saurus {
    struct SAURUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAURUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAURUS>(arg0, 6, b"SAURUS", b"SUISAURUS", b"Official Mascot of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006475_11f107b2e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAURUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAURUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

