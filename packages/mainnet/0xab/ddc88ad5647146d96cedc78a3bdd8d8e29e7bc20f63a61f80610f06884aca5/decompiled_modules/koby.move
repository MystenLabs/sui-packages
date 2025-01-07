module 0xabddc88ad5647146d96cedc78a3bdd8d8e29e7bc20f63a61f80610f06884aca5::koby {
    struct KOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBY>(arg0, 6, b"KOBY", b"Koby", b"Koby is not just another token; he's a cool, hip-hop loving dog bringing a fresh vibe to the Solana ecosystem. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725225456872_2709242c1c271a8e20e0af823feae029_d3bc33b108.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

