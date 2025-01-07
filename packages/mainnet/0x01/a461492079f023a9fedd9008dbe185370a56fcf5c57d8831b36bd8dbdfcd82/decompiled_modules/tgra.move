module 0x1a461492079f023a9fedd9008dbe185370a56fcf5c57d8831b36bd8dbdfcd82::tgra {
    struct TGRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGRA>(arg0, 6, b"TGRA", b"Trumgra", b"Trumgra on movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfsdfsfsf_e9656e65ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TGRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

