module 0xf25925a800cd0f39a1652b7f2b169b9608538a23cc07cfbf2ffa581022b15b52::poop {
    struct POOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<POOP>(arg0, 6, b"POOP", b"POOP COIN by SuiAI", b"The shitcoin to end all shitcoins on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/poop_coin_14fc6c5548.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POOP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

