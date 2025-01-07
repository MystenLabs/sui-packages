module 0xa2506cd60596e8dde4cdb940d4dd1f794e2257a8b0173b23e9818d955116f392::savage {
    struct SAVAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVAGE>(arg0, 6, b"SAVAGE", b"Savage", b"This is a coin based on Alex Becker's funny jokes. Let the savage degens begin. This token is in no way affiliated with Alex Becker.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_E81_AE_0_F_A31_F_4_C8_C_A06_B_8800150_A58_C9_fda5aa9025.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAVAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

