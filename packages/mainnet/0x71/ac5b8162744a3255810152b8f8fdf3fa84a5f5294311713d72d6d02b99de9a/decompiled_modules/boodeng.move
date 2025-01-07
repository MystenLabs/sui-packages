module 0x71ac5b8162744a3255810152b8f8fdf3fa84a5f5294311713d72d6d02b99de9a::boodeng {
    struct BOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOODENG>(arg0, 6, b"BOODENG", b"BOO DENG", b"BOODENG is a Halloween twist on Moo Deng, the famous hippo from Khao Kheow Zoo. In this spooky version, BOODENG dons playful yet eerie Halloween costumes turning the lovable hippo into a spooky yet charming character that adds a dash of frightful delight to the festive season. BOOOOOO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_YBT_Xy_G8_BA_9_HVQW_5x_BT_72_Qsuapwda1_B_Snid_Rw9_Je_MM_Ad8_48844674b2.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

