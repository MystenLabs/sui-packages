module 0x8c47c0bde84b7056520a44f46c56383e714cc9b6a55e919d8736a34ec7ccb533::suicune {
    struct SUICUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUNE>(arg0, 9, b"HSUI", b"Suicune", b"The Legendary Beast of SUI, believed to be both the embodiment of the north winds and compassion of pure spring waters. Suicune will be fully community operated.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/rmQPsBG.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICUNE>>(v1);
        0x2::coin::mint_and_transfer<SUICUNE>(&mut v2, 245000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUNE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

