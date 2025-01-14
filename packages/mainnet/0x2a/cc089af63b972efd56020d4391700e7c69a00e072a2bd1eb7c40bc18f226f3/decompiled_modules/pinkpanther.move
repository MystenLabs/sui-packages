module 0x2acc089af63b972efd56020d4391700e7c69a00e072a2bd1eb7c40bc18f226f3::pinkpanther {
    struct PINKPANTHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKPANTHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKPANTHER>(arg0, 6, b"PINKPANTHER", b"PINKPANTHER music", x"50494e4b50414e54484552206d75736963200a4e65772067656e65726174696f6e206d757369632e200a4f757220736f6369616c206d65646961206163636f756e742077696c6c206265207769746820796f7520696e20746865206e656172206675747572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018383_79e2076b7d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKPANTHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKPANTHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

