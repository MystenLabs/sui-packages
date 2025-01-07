module 0xb68dbd1329560a3dc89142d812473a5ca9bd1e0ccedecd401e0bbf2a28278c65::coral {
    struct CORAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORAL>(arg0, 6, b"Coral", b"Coral Reef", x"436f72616c204d656d6520436f696e20697320616c6c2061626f7574206f6365616e20766962657320616e6420756e6974696e672063727970746f2066616e73207769746820612073706c617368206f662066756e2e20497473206c696b652061206469676974616c20726565663a207374726f6e672c2067726f77696e672c20616e642066756c6c206f66206c6966652e20526964652074686520776176652c207370726561642074686520687970652c20616e64207669626520746f676574686572210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/file_7_BF_Mq9_T_Lqk_C75var9ccv_F8_1_55a16f104a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

