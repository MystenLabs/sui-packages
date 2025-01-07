module 0x8521e5714b3717a1277acd3dac0cf9d1c7781b8602dc709755270359c577e15e::chilld {
    struct CHILLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLD>(arg0, 6, b"Chilld", b"Chilldogss", b"Chilll the word dog's come ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000875615_d388bb4b5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

