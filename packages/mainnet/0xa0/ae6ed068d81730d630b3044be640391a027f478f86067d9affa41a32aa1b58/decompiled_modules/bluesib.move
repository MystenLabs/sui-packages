module 0xa0ae6ed068d81730d630b3044be640391a027f478f86067d9affa41a32aa1b58::bluesib {
    struct BLUESIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUESIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUESIB>(arg0, 6, b"BLUESIB", b"BLUE SUISHIB", b"OFFICIAL BLUE SHIB, GOING TO CURVE!! Hodll!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3710_a6b79fba43.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUESIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUESIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

