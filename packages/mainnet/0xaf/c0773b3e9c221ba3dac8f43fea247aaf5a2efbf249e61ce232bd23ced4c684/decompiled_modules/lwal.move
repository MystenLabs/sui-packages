module 0xafc0773b3e9c221ba3dac8f43fea247aaf5a2efbf249e61ce232bd23ced4c684::lwal {
    struct LWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LWAL>(arg0, 6, b"LWAL", b"Little Walrus", b"im a little walrus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9115_bbcd2c39a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

