module 0xf0821ffcb9643b4374da5e25be0b1df758bdb990f8ab356266d6110491a8a441::htw {
    struct HTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTW>(arg0, 6, b"HTW", b"Help Taiwan", b"Help Taiwan Community in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003069_6e87a6e092.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

