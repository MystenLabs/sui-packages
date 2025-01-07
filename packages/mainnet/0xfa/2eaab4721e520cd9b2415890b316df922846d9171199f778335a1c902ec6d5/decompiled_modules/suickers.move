module 0xfa2eaab4721e520cd9b2415890b316df922846d9171199f778335a1c902ec6d5::suickers {
    struct SUICKERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICKERS>(arg0, 6, b"SUICKERS", b"Suickers", b"This meme token create for deploying to community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000115279_7e5a774c73.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICKERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICKERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

