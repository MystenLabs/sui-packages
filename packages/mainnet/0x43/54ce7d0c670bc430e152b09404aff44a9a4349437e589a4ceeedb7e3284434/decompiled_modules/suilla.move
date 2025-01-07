module 0x4354ce7d0c670bc430e152b09404aff44a9a4349437e589a4ceeedb7e3284434::suilla {
    struct SUILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLA>(arg0, 6, b"SUILLA", b"SUILLA SUI", b"In 2024, SUI grew like Godzilla awakening from the depths of the sea. Thats why this meme named SUILLA, representing SUIs strength and immortality", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1734869287_681624_ABA_17_E00_D4_E4_464_F_AC_37_711447953078_b8958a6620.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

