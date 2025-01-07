module 0x5f16634d01dfd32a51ca6f2c8ba9a9c1d798b649212a6ff2096fbb1a34a4306e::captain {
    struct CAPTAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPTAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPTAIN>(arg0, 6, b"CAPTAIN", b"Sui Captain", b"Come with me friends. Let's explore the Sui together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_05_14_26_21_A_special_edition_pirate_and_a_sparrow_sailing_together_on_a_grand_sea_adventure_under_a_dramatic_sunset_The_pirate_wears_an_elaborate_outfit_with_a_e43012748f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPTAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPTAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

