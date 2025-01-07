module 0xa9710c9e8a8f86993a7f9b849050314ac2b820d63b25a04a587c284f674e860d::flxcat {
    struct FLXCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLXCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLXCAT>(arg0, 6, b"FLXCAT", b"Felix The Cat", b"The Legendary Celebrity Cat, Returns on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002228_405ae3b9bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLXCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLXCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

