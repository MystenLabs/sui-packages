module 0xdb2debfd67bbdc2105a0fea58ad5163bb27a2f52dc3b59b1d1b4726342834428::yoka {
    struct YOKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOKA>(arg0, 6, b"YOKA", b"Yokacoin", b"Yoka is an intelligent memoin, yoka memoin is not just a joke, but has artistry ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054518_1e11ea666b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

