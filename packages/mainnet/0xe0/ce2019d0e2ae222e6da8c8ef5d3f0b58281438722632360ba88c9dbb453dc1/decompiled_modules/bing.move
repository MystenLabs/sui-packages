module 0xe0ce2019d0e2ae222e6da8c8ef5d3f0b58281438722632360ba88c9dbb453dc1::bing {
    struct BING has drop {
        dummy_field: bool,
    }

    fun init(arg0: BING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BING>(arg0, 6, b"Bing", b"domgbing", b"tets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973801989.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

