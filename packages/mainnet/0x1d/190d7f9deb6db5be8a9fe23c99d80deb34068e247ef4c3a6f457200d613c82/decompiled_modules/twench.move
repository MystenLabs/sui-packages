module 0x1d190d7f9deb6db5be8a9fe23c99d80deb34068e247ef4c3a6f457200d613c82::twench {
    struct TWENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWENCH>(arg0, 6, b"TWENCH", b"TWENCHSUI", b"Welcome To The Twench Army! A Community For People Who Grind Day & Night, Driven By The Goal Of Financial Freedom! Today Is Our Day To Rise Up & Break Free From The Trenches! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vrxozggr5tb_K3eg3isj_EX_Zb_Nv_Mi_Yp_G6a_Egkbbby_Ue_H_Db_9ffd9c82c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWENCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWENCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

