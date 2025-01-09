module 0x677a4bbbf8f0e34e108676126d9effc0579e853242cc8a44acef9f7b418a9be2::chompsky {
    struct CHOMPSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMPSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMPSKY>(arg0, 6, b"CHOMPSKY", b"Chompsky", b"Matt Furies CHOMPSKY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cartoon03_4084947da3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMPSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMPSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

