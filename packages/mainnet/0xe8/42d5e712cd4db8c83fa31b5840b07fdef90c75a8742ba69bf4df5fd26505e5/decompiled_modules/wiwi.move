module 0xe842d5e712cd4db8c83fa31b5840b07fdef90c75a8742ba69bf4df5fd26505e5::wiwi {
    struct WIWI has drop {
        dummy_field: bool,
    }

    public entry fun burn_treasury_cap(arg0: 0x2::coin::TreasuryCap<WIWI>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WIWI>>(arg0);
    }

    fun init(arg0: WIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIWI>(arg0, 9, b"WIWI", b"WIWI", b"wiwiwiwiwiwi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/gigagfun/token-assets/refs/heads/main/wiwiwi.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIWI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WIWI>>(0x2::coin::mint<WIWI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIWI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

