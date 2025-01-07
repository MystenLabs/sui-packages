module 0x827f84e3c5c195669fa42aa8a8a044dfe12be093e3293e89c53a4a51eee2cc4b::suif {
    struct SUIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIF>(arg0, 6, b"SUIF", b"Suimese Fighting Fish", b"Adorable fish based on the \"Siamese fighting fish\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5429_132590c82a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

