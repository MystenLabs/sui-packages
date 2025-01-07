module 0xbde18964049a1226f6e30dd2058ac03205d3d7c6f7a3062760a70e20a4b49d1c::wojak_coin {
    struct WOJAK_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WOJAK_COIN>, arg1: 0x2::coin::Coin<WOJAK_COIN>) {
        0x2::coin::burn<WOJAK_COIN>(arg0, arg1);
    }

    fun init(arg0: WOJAK_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK_COIN>(arg0, 9, b"WOJAK", b"WOJAK", b"Twitter: @WojakSui, Website: suiwojak.gay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://3r5d4jvgo5way7suig4bt2tai5ze4evfdvmzlbqiccjv7sxms6da.arweave.net/3Ho-JqZ3bAx-VEG4GepgR3JOEqUdWZWGCBCTX8rsl4Y"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOJAK_COIN>>(v1);
        0x2::coin::mint_and_transfer<WOJAK_COIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<WOJAK_COIN>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WOJAK_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WOJAK_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

