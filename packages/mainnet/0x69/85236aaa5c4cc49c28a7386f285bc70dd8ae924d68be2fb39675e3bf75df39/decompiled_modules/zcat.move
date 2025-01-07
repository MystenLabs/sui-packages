module 0x6985236aaa5c4cc49c28a7386f285bc70dd8ae924d68be2fb39675e3bf75df39::zcat {
    struct ZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZCAT>(arg0, 6, b"ZCAT", b"ZOOMCAT", b"Meet ZoomCat: Your Purr-fect Virtual Meeting Companion! In a world where virtual meetings have become the new norm, it's time to add a whisker of fun to your daily video calls! Introducing ZoomCat  the adorable digital feline ready to leap into your next online gathering.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcv_N5_T_Ds_Y8_Pd_L9kxu_X_Rb_G_Ghg_FZ_Zv_Kb_XX_Yf_Na_ZTXHHH_Upc_0282b6aabe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

