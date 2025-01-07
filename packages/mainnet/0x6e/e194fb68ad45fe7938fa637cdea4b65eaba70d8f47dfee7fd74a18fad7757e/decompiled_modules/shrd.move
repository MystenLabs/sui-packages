module 0x6ee194fb68ad45fe7938fa637cdea4b65eaba70d8f47dfee7fd74a18fad7757e::shrd {
    struct SHRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRD>(arg0, 6, b"SHRD", b"Shining Rod", b"THE SHINIEST AND HARDEST ROD IN CRYPTO WORLD!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nyweld_1af813bd23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

