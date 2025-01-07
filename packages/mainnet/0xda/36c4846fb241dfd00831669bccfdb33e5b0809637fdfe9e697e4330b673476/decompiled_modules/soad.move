module 0xda36c4846fb241dfd00831669bccfdb33e5b0809637fdfe9e697e4330b673476::soad {
    struct SOAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOAD>(arg0, 6, b"SOAD", b"ChopSui", b"You wanted to.. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019834_fba2084e5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

