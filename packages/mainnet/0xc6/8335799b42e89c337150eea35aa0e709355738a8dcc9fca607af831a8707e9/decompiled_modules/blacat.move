module 0xc68335799b42e89c337150eea35aa0e709355738a8dcc9fca607af831a8707e9::blacat {
    struct BLACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACAT>(arg0, 6, b"BLACAT", b"The Blacky Cat", b"THE BLACKY CAT - What is the definition of soaring high, is it possible for a $BLACAT to do that, or is it just an illusion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2l3fuk_0b85b063f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

