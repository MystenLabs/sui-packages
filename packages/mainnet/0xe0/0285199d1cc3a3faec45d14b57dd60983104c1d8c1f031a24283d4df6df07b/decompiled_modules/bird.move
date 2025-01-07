module 0xe00285199d1cc3a3faec45d14b57dd60983104c1d8c1f031a24283d4df6df07b::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRD>(arg0, 6, b"BIRD", b"Bird Money", b"Telegram: https://t.me/bird_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/XegzWXp.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRD>>(v0, @0x655c3b71777ab32f2123b5bda456a9a16e6fd6e93e34678090ba488d38998a30);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BIRD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BIRD>(arg0, arg1, @0x655c3b71777ab32f2123b5bda456a9a16e6fd6e93e34678090ba488d38998a30, arg2);
    }

    // decompiled from Move bytecode v6
}

