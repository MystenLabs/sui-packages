module 0x16b63b2acbbf27e4f94e2e417c29458004e36aa2e5f22124256f93f21a601f6e::sumke {
    struct SUMKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMKE>(arg0, 6, b"SUMKE", b"SUMKE SUI", b"Low iq monkey roaming around the streets of sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yjlz_Tb_XIAA_8_OV_6_5bcf3f0749.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

