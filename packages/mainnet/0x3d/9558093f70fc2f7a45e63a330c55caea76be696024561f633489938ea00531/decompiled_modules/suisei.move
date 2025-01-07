module 0x3d9558093f70fc2f7a45e63a330c55caea76be696024561f633489938ea00531::suisei {
    struct SUISEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEI>(arg0, 6, b"Suisei", b"Suisei Hoshi Machi", b"Famous japanese Vtuber coming to sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730976173236.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISEI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

