module 0x164f3f03a5560bd84b48905d1b308cfba1987c678fc456417b7e1d9a1fb5347a::zazorr {
    struct ZAZORR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAZORR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAZORR>(arg0, 6, b"ZAZORR", b"Zazorr The Lizard", b"Zazorr The cosmic lizard lost between realities. Not impressed by your market chart. Not scared of your future. His here just to exist.  and maybe steal your ice cream.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreift3nwrgmnyxl3p32batyp7l37jlrj6gmiufdnoohx6aszqr2fu34")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAZORR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZAZORR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

