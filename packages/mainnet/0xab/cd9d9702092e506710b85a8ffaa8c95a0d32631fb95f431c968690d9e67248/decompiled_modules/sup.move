module 0xabcd9d9702092e506710b85a8ffaa8c95a0d32631fb95f431c968690d9e67248::sup {
    struct SUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUP>(arg0, 6, b"SUPPORT", b"SUPPORT TO DEPLOY COIN", b"Need deploy clean CA? DM: https://t.me/x0yx0z", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/t0wVu5I.jpg"))), arg1);
        let v2 = v0;
        let v3 = @0x3f8fe67a33611b57ad3e4e0fa7f2c5aa898f09f2c4935d759732e3356c8f7642;
        0x2::coin::mint_and_transfer<SUP>(&mut v2, 1000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUP>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

