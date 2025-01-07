module 0xa6634ef6d81c7ecb8eb8b8497a9fc336a3458bf1f48057613f94cf573b4f04a4::cc {
    struct CC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CC>(arg0, 6, b"CC", b"CLOUDCASH", x"40656967656e7269636b0a204c657427732064657369676e2061206e65772063757272656e637920616e642063616c6c20697420436c6f7564436173682e204920646f6e2774206b6e6f77207768617420697420646f6573207965742c206275742077652063616e206d616b6520697420776f72746879206f6620746865206e616d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pae_UF_2de_D4_C_Mj_E_Ta_Qr44n_Uz_Lu_ZJ_3wkng_Yf_Kqv2_Jeki2_Y_f7f611e401.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CC>>(v1);
    }

    // decompiled from Move bytecode v6
}

