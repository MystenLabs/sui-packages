module 0x2122d76ae97b3a085547943371abc5bce39227e8687ca5feca283b1320c1a26c::suimusk {
    struct SUIMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMUSK>(arg0, 6, b"SUIMUSK", b"BLUE ELON MUSK", b"SUI Elon aims to attract attention and potential investment by associating themselves with both the trending memecoin phenomenon and the influential tech entrepreneur.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3675_8131559ea7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

