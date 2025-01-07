module 0x7c26855f16f7c6fce3bf3dc854349fde0ae3683f98a8b00d48e63c66ceb23000::chalk {
    struct CHALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHALK>(arg0, 6, b"CHALK", b"Chalk", b"just a chalk dude on $Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ca_ecf43186d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

