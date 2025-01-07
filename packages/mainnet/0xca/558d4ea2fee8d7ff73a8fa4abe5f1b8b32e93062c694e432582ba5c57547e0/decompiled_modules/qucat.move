module 0xca558d4ea2fee8d7ff73a8fa4abe5f1b8b32e93062c694e432582ba5c57547e0::qucat {
    struct QUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUCAT>(arg0, 6, b"QUCAT", b"Queen cat", x"717565656e206f662061206b696e67646f6d206973207479706963616c6c7920612066656d616c65206d6f6e617263680a77686f2072756c6573206f7665722061206b696e67646f6d2e205368652069732074686520686967686573740a617574686f7269747920696e20746865206c616e642c206f6674656e20686f6c64696e6720706f6c69746963616c2c0a736f6369616c2c20616e642072656c6967696f757320706f776572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042448_0510fe8d8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

