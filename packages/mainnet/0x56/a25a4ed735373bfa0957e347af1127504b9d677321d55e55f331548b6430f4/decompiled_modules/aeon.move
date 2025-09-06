module 0x56a25a4ed735373bfa0957e347af1127504b9d677321d55e55f331548b6430f4::aeon {
    struct AEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEON>(arg0, 9, b"AEON", b"AEON", b"AEON WILL RISE | Website: https://aeon.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/UM8aNlq.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

