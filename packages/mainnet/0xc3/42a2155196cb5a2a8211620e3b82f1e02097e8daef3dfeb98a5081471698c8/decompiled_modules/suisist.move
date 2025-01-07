module 0xc342a2155196cb5a2a8211620e3b82f1e02097e8daef3dfeb98a5081471698c8::suisist {
    struct SUISIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISIST>(arg0, 6, b"SUISIST", b"Susist Girls", b"SUISIST is a white-haired woman, but she likes a lot of naughty men, until now she is in a hurry to sleep together ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048511_3f6d341529.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISIST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISIST>>(v1);
    }

    // decompiled from Move bytecode v6
}

