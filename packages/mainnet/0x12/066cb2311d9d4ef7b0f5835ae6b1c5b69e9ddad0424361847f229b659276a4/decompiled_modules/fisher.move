module 0x12066cb2311d9d4ef7b0f5835ae6b1c5b69e9ddad0424361847f229b659276a4::fisher {
    struct FISHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHER>(arg0, 6, b"FISHER", b"the fisher", b"i hunt fish on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AFAD_3_FB_6_A205_47_FD_8_F12_3_D52_D412_B8_E5_1cf7f78044.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

