module 0x32305a5d669590a697341ebc1673f74f8f26f668cf5cb15aa71f10a48e95d696::asdf {
    struct ASDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDF>(arg0, 6, b"ASDF", b"ASDF token", b"ASDF IS ON SUI BECAUSE ASDF WHY NOT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1_d338dd5eb1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

