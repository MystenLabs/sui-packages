module 0xd170991047d9ab15670528f98504cd9ad6d1e1b1dfdf49189094f99f852cbcb3::yumi {
    struct YUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUMI>(arg0, 6, b"YUMI", b"YUMI dog", b"Yumi is deecayz's dog OWNER OF FWOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1171728832139_pic_664b1d34fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

