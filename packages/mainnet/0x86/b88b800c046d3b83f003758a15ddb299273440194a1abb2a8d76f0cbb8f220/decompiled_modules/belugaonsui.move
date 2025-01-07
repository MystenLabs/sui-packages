module 0x86b88b800c046d3b83f003758a15ddb299273440194a1abb2a8d76f0cbb8f220::belugaonsui {
    struct BELUGAONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGAONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGAONSUI>(arg0, 6, b"BelugaOnSui", b"Beluga", b"The majestic $BELUGA is making waves in the Sui ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluega_d0671a03b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGAONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELUGAONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

