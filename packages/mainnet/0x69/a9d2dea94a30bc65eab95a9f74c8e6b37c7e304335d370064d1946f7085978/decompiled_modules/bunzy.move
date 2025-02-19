module 0x69a9d2dea94a30bc65eab95a9f74c8e6b37c7e304335d370064d1946f7085978::bunzy {
    struct BUNZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNZY>(arg0, 6, b"Bunzy", b"Bunzy Token", x"3232323220726574726f2c20736f756c66756c2062756e6e6965732072756e6e696e672061206d75636b206f6e200a405375694e6574776f726b0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xv2rrf0y_400x400_fa4bc60085.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

