module 0x28b59e85250938caa92d81465d01540b5d03a83fdcebda0c0128affc0f568ab9::BOZO {
    struct BOZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOZO>(arg0, 9, b"BOZO", b"Bozo Collective", b"https://bozocollective.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1704143547769798656/W_J4MHEz_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOZO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOZO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOZO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BOZO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

