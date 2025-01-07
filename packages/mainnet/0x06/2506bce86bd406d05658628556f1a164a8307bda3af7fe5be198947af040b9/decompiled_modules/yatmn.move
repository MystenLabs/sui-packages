module 0x62506bce86bd406d05658628556f1a164a8307bda3af7fe5be198947af040b9::yatmn {
    struct YATMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YATMN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<YATMN>(arg0, 6, b"YATMN", b"You Are The Media Now", b"Create and share your own media with our AI agent embodying the 'You Are The Media Now' concept. It helps you find your voice and spread your stories by providing you with the tools to produce media independently and creatively.'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/7175b947_ec81_410e_b163_256ab6c7fda3_6b89f23094.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YATMN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YATMN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

