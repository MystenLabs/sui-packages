module 0x68f0bcdc1dfa9bb11036c7de4fb19adfe715a1a4d1426d7a70ae8ab718a829ac::cuppa {
    struct CUPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUPPA>(arg0, 6, b"CUPPA", b"CUPPA WATER", b"Native Asset On $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2991_dceeae837d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

