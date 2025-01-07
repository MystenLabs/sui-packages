module 0x724673284ca57b4da9e020a9125310b87424f895c9c29c5109aac2663d5ce695::beme {
    struct BEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEME>(arg0, 6, b"BEME", b"BEME SUI", x"506c616e203a204275726e203525200a5472656e64696e6720315765656b730a44657850726570616964", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7040_a79dbe243d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

