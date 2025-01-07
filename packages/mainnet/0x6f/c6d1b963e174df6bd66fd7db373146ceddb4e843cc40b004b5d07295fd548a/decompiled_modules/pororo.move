module 0x6fc6d1b963e174df6bd66fd7db373146ceddb4e843cc40b004b5d07295fd548a::pororo {
    struct PORORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORORO>(arg0, 6, b"PORORO", b"PORORO CAT", b"The most viral cat on TikTok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L_4_c24acfce3f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

