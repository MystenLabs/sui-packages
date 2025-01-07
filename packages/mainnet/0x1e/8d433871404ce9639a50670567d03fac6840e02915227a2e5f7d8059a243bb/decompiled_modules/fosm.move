module 0x1e8d433871404ce9639a50670567d03fac6840e02915227a2e5f7d8059a243bb::fosm {
    struct FOSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOSM>(arg0, 6, b"FOSM", b"Frog Summer", b"Telegram: https://t.me/frog_summer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/dnjBOBO.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOSM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOSM>>(v0, @0xda7f05fff4a2f57ead072aca37f57b3825b1883e56f822deed365083f5badb5c);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FOSM>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FOSM>(arg0, arg1, @0xda7f05fff4a2f57ead072aca37f57b3825b1883e56f822deed365083f5badb5c, arg2);
    }

    // decompiled from Move bytecode v6
}

