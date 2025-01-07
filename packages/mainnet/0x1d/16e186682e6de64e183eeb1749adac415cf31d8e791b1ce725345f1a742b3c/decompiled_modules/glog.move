module 0x1d16e186682e6de64e183eeb1749adac415cf31d8e791b1ce725345f1a742b3c::glog {
    struct GLOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOG>(arg0, 6, b"GLOG", b"Glowing Dog", b"shiny blue glowing dog, Glog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_psd_1_02906afca2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

