module 0x62b9bf724947dc71dafdd8b3a03f1d5ced8553f4c91a1039775e1c79a6c75c4c::sec {
    struct SEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEC>(arg0, 6, b"SEC", b"SideEyeCat", b"https://x.com/SuiNSdapp/status/1846234583593111946", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_8e_U_Rz_XEAMIQI_1_4f6d4b8ac8.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

