module 0xb04f9fb791792c8f6998ca553471e9b4ea280effb275293107461eccaf94205d::onlychill {
    struct ONLYCHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONLYCHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONLYCHILL>(arg0, 6, b"OnlyChill", b"OnlyChillGirl", b"ONLYCHILLSSUI GIRL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004308_cde63dd127.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONLYCHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONLYCHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

