module 0x9c520e98bcf0313836ea3beedf2b9f3aadcf9da755ae3ca06d4fe568e99f417c::htr {
    struct HTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTR>(arg0, 6, b"HTR", b"Hopper the rabbit", x"5468652066617374657374206372656174757265206f6e200a405375696e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HOP_c094a14871.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

