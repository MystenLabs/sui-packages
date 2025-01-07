module 0x88afde569d8dcc4988e58f6aa1ec635c3a90daf3826d9ddb897d1b94154cae2::sgy {
    struct SGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGY>(arg0, 6, b"SGY", b"SUIGGY", b"SUIGGY COMMUNITY DRIVEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001091_89db8c73fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

