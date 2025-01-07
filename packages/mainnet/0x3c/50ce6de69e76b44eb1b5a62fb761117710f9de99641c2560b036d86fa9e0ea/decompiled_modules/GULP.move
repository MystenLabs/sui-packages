module 0x3c50ce6de69e76b44eb1b5a62fb761117710f9de99641c2560b036d86fa9e0ea::GULP {
    struct GULP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GULP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GULP>(arg0, 2, b"GULP", b"GULP", b"Dive into SUI fluid blockchain with a token that flows as smoothly as water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/7/72/Gulp.js_Logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GULP>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GULP>(&mut v2, 31551750000000000, @0x505d42f138305710b44b2a57346f7f3b4b1941f7f9a3d4b9283e829729edac8, arg1);
        0x2::coin::mint_and_transfer<GULP>(&mut v2, 10517250000000000, @0x505d42f138305710b44b2a57346f7f3b4b1941f7f9a3d4b9283e829729edac8, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GULP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

