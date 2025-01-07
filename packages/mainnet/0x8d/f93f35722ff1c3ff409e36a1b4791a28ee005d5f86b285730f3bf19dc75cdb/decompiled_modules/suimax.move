module 0x8df93f35722ff1c3ff409e36a1b4791a28ee005d5f86b285730f3bf19dc75cdb::suimax {
    struct SUIMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAX>(arg0, 6, b"SUIMAX", b"Sui Maximus", b"The Matrix of AI Cryptocurrencies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037501_7588a8a7c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

