module 0xadbc8e03a9e2c68ca014d602e2c7f551314c05a4089b48810abb412c0b47138d::suiyancat {
    struct SUIYANCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYANCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYANCAT>(arg0, 6, b"SuiyanCat", b"Suiyan Cat", b"Forever flying forever pumping ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0385_5260e29d0f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYANCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYANCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

