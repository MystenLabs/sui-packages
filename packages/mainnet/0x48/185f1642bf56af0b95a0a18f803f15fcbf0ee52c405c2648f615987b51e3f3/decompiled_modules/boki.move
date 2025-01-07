module 0x48185f1642bf56af0b95a0a18f803f15fcbf0ee52c405c2648f615987b51e3f3::boki {
    struct BOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOKI>(arg0, 6, b"BOKI", b"Book of Kitty", b"Book of Kitty is built on top of SUIs strong blockchain, which is safe, expandable, and user-friendly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/noname_0e1298ce41.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

