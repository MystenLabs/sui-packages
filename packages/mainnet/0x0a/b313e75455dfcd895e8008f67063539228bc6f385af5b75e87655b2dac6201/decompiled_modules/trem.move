module 0xab313e75455dfcd895e8008f67063539228bc6f385af5b75e87655b2dac6201::trem {
    struct TREM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREM>(arg0, 6, b"TrEM", b"TRUMP & ELON MUSK", b"pump pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/392aded3452849c0db03542c4f8b5a5d_e2d6879ca4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREM>>(v1);
    }

    // decompiled from Move bytecode v6
}

