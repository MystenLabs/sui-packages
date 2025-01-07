module 0xe9a4eedd521ef40ac23969d75169c9c9b4ae51ba2a7f58a853cbf25ed723a0b2::suicune {
    struct SUICUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUNE>(arg0, 9, b"SUI", b"Suicune", b"The Legendary Beast of SUI, believed to be both the embodiment of the north winds and compassion of pure spring waters. Suicune will be fully community operated.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/rmQPsBG.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICUNE>>(v1);
        0x2::coin::mint_and_transfer<SUICUNE>(&mut v2, 245000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUNE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

