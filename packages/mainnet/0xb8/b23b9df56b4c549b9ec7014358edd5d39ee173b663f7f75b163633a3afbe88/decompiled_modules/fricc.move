module 0xb8b23b9df56b4c549b9ec7014358edd5d39ee173b663f7f75b163633a3afbe88::fricc {
    struct FRICC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRICC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRICC>(arg0, 6, b"Fricc", b"Friccodile", b"CROCODILE and water, hand in glove a perfect marriage with the Sui Network. FRICC is a viral and audacious Crocodile.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidmx27jzftspuqlw3ebgevgq6lsx4rcn2k3yrooms74rkp2ludbpe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRICC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FRICC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

