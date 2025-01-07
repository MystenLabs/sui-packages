module 0x1946494863c884c63bb4787c77f4ff721401d133df6d285be8cce11cb72a0cdb::babyaxol {
    struct BABYAXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYAXOL>(arg0, 6, b"BABYAXOL", b"Baby Axol", b"The cutest meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_195802_7a35de38fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYAXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYAXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

