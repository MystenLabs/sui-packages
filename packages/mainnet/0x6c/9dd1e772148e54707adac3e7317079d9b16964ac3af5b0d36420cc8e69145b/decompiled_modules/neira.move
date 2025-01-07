module 0x6c9dd1e772148e54707adac3e7317079d9b16964ac3af5b0d36420cc8e69145b::neira {
    struct NEIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRA>(arg0, 6, b"Neira", b"NEIRAonSUI", x"4e65697261206973204e6569726f277320776f6d616e2c206973206172726976696e6720746f2072696465207468652077617665206f66207468652063727970746f206d61726b6574206f6e2074686520535549206e6574776f726b2e2045766572797468696e6720696e6469636174657320746861742069742077696c6c2062652061206875676520687970652c20736f20737461792074756e656420616e6420646f6e74206d6973732074686973206f70706f7274756e697479210a0a200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241009_065853_854_b987ef44ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

