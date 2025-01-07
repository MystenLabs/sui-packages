module 0x650eaa5f9f1b86133873cabbae3f9893b0a1db33caecd8ddb57f41ca65d45757::ALIEN {
    struct ALIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIEN>(arg0, 9, b"ALIEN", b"ALIEN.FI", b"ALIEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1646886748310446086/4Df6Plmb_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALIEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ALIEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ALIEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

