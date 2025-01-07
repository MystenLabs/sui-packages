module 0x9f2a18d407c740f38e398b8ef2dbc1643f14a2beb8e63e846e9d0a294a866f11::wynn {
    struct WYNN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WYNN>, arg1: 0x2::coin::Coin<WYNN>) {
        0x2::coin::burn<WYNN>(arg0, arg1);
    }

    fun init(arg0: WYNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYNN>(arg0, 6, b"WYNN", b"ANITA MAX WYNN", b"ANITA MAX WYNN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.anitamaxwynn.biz/_app/immutable/assets/logo.-td0PWI9.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WYNN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYNN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WYNN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WYNN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

