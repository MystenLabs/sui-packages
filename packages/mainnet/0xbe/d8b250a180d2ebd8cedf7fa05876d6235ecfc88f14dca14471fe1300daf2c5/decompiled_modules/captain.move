module 0xbed8b250a180d2ebd8cedf7fa05876d6235ecfc88f14dca14471fe1300daf2c5::captain {
    struct CAPTAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPTAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPTAIN>(arg0, 6, b"CAPTAIN", b"Captain Sui", b"Captain Sui leading the Blue Troops into the Next Season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicl7abakvwliken4xpoyfw6yimobqvbyssxda42fudiaaaezuusxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPTAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAPTAIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

