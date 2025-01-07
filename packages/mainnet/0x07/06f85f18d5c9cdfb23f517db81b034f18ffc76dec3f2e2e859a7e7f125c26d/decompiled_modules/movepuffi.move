module 0x706f85f18d5c9cdfb23f517db81b034f18ffc76dec3f2e2e859a7e7f125c26d::movepuffi {
    struct MOVEPUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEPUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEPUFFI>(arg0, 6, b"MOVEPUFFI", b"MOVE PUFFI", x"4f6666696369616c2074672068747470733a2f2f742e6d652f50554646494f4e535549490a54686973206973206f6666696369616c0a426577617265207363616d6d6572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/261_B2_EC_1_F53_F_462_D_BA_80_37_F17_AB_59_A32_5f0f7f7494.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEPUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEPUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

