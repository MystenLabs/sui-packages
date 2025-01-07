module 0xe01a83a3801023db5149e03722d78d6f2a49014d4411ab94e9868fac8bf02c65::lugi {
    struct LUGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUGI>(arg0, 6, b"LUGI", b"LUGI THE DOLPH", b"Lugi is the dolph attractive", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LUGI_5004d63b20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

