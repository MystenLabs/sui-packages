module 0x4965298989d6c359f986a37b9ac69951af9680c61ed35fb746a4d43c66f3b60::sbd {
    struct SBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBD>(arg0, 6, b"SBD", b"SuiBirds", b"The cyber birds on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4014_9ae0018e5f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

