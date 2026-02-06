module 0x180dcdec2520bac975388643c99931ceeca71044de86b7e50c4d800803978bbe::qwer {
    struct QWER has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<QWER>, arg1: 0x2::coin::Coin<QWER>) {
        0x2::coin::burn<QWER>(arg0, arg1);
    }

    fun init(arg0: QWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWER>(arg0, 6, b"qswdqde", b"qwer", b"cdwcwd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QWER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<QWER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QWER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

