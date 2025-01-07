module 0x75cbef87c71f8b37e691cfa5d88667b90e4b99a2b5606c839d8386c1919155f1::babycate {
    struct BABYCATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYCATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYCATE>(arg0, 6, b"BabyCate", b"BABYcate", b"BabyCate community a happy weekendMeow. GoldenCat #BabyCate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_1729430105563_5f1c2967d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYCATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYCATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

