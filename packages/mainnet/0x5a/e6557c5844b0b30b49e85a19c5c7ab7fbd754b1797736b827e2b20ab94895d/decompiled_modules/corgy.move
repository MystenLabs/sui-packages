module 0x5ae6557c5844b0b30b49e85a19c5c7ab7fbd754b1797736b827e2b20ab94895d::corgy {
    struct CORGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORGY>(arg0, 6, b"CORGY", b"CORGY CLUB", b"#CORGY about fetching real value and loyalty, not mysterious catnip schemes. Woof woof!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_95f18738d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

