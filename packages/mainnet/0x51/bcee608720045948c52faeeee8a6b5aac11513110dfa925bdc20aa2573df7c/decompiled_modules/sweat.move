module 0x51bcee608720045948c52faeeee8a6b5aac11513110dfa925bdc20aa2573df7c::sweat {
    struct SWEAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWEAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEAT>(arg0, 6, b"SWEAT", b"Sweat Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWEAT>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWEAT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SWEAT>>(v2);
    }

    // decompiled from Move bytecode v6
}

