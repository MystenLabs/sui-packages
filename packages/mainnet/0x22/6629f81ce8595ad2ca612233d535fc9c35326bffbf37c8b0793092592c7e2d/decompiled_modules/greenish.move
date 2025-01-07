module 0x226629f81ce8595ad2ca612233d535fc9c35326bffbf37c8b0793092592c7e2d::greenish {
    struct GREENISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREENISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREENISH>(arg0, 6, b"Greenish", b"Sui Greenish", b"Sui Greenish is the fresh breeze of the Sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Copia_de_new_3_2_355d2b5064.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREENISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREENISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

