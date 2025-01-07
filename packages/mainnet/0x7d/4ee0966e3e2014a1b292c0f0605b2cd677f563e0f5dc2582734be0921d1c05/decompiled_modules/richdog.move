module 0x7d4ee0966e3e2014a1b292c0f0605b2cd677f563e0f5dc2582734be0921d1c05::richdog {
    struct RICHDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICHDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICHDOG>(arg0, 6, b"RichDOG", b"RichDOG ON SUI", b"Congratulations on discovering us. This will be your second chance to create wealth. Careful people will always gain a lot of things, including wealth! Repost Dog breaks Mr Beast's forwarding record Soon we will reach 1B MCAP Rich Dog is the most interesting part of Repost Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xq7_Jh_W_Lbs_GZ_Wz_K8_Y1_GZVURN_9cyyur_TB_Dyu_A1_ZTUW_Tzne_29246465de.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICHDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

