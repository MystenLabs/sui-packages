module 0x20beacf7b28f2c2395a3feefe2c57b399f0dc4bc44a11b59e72ee557a69c01f6::warped {
    struct WARPED has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WARPED>, arg1: 0x2::coin::Coin<WARPED>) {
        0x2::coin::burn<WARPED>(arg0, arg1);
    }

    fun init(arg0: WARPED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARPED>(arg0, 9, b"WARPED", b"Warped", b"Warped Utility Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.warped.games/warped.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WARPED>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARPED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARPED>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

