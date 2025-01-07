module 0xa23a642d1dba61673f8a5638789bf9f3f3e5c19bee3229be283b10fef2cde9fa::suider {
    struct SUIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDER>(arg0, 6, b"SUIDER", b"Suidermun", b"The amazing Suidermun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suider_123fe49e2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

