module 0x9cdcf0b86ab7d18c5c764e59c79f53231653289f84f76e3f6d3fdf659febc5c2::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"Whale Street on SUI", b"Whale Street dominates the Sui blockchain like a mafia kingpin, controlling the flow of deals and commanding respect across the network. With every calculated transaction, he navigates the digital waters with power and precision, always staying a step ahead in the game of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_30_18_05_34_cac8f076e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

