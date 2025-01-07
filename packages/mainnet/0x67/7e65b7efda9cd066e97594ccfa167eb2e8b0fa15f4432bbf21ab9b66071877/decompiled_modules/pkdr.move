module 0x677e65b7efda9cd066e97594ccfa167eb2e8b0fa15f4432bbf21ab9b66071877::pkdr {
    struct PKDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKDR>(arg0, 6, b"PKDR", b"PikaDrug", b"PikaDrug is not your ordinary Pikachu!  This unique character has a deep love for nature and dedicates its life to preserving the environment. Known as the \"Eco-Warrior Pikachu,\" PikaDrug is always surrounded by lush forests, blooming flowers, and vibrant greenery. From planting trees to cleaning rivers, PikaDrug spreads a message of harmony between cute caricature art and the natural world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pikadrug_772a067bfe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

