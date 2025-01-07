module 0xa0ee6b4313a5fd81520131e8051cf1f5b614e7ca9acdfefbe5a665789c1762bc::catdet {
    struct CATDET has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATDET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATDET>(arg0, 6, b"CATDET", b"Catdet on SUI", x"4361746465742773206d697373696f6e3f200a0a466f72676520636f6e6e656374696f6e7320616d6f6e6720646567656e7320696e207468652066617274686573742072656163686573206f66207468652067616c6178792e200a4173207468652070726f6a656374206f7262697473207468726f756768207468652073746172732c2069747320676f616c206973206e6f7468696e672073686f7274206f6620617374726f6e6f6d6963616c3a20746f20726561636820612063656c65737469616c206d696c6573746f6e65206f6620612031206d696c6c696f6e206d61726b6574206361702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_cat_dx_3a51fa0009.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATDET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATDET>>(v1);
    }

    // decompiled from Move bytecode v6
}

