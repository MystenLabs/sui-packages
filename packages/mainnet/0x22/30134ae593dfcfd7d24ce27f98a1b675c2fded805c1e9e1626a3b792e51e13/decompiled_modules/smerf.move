module 0x2230134ae593dfcfd7d24ce27f98a1b675c2fded805c1e9e1626a3b792e51e13::smerf {
    struct SMERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMERF>(arg0, 6, b"SMERF", b"Smerf", b"In the heart of the Sui,  was the bustling Smerf Village. Led by their wise and playful leader, Papa Smerf, the Smerfs spent their days crafting memes and spreading joy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_00_25_30_af6f0ff339.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMERF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMERF>>(v1);
    }

    // decompiled from Move bytecode v6
}

