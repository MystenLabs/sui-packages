module 0xa215c6480de1fed024a0d6466721d0c71e24bcd33e62d9a7b816317347ff6fc5::skicat {
    struct SKICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKICAT>(arg0, 6, b"SKICAT", b"SKI MASK CAT", b"$SKICAT - The masked cat on Sui. THE MASK STAYS ON.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_PQ_2_Lf_Qw9q_W_Di0_Ge_6e688cf88c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

