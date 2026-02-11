module 0x605359ba5133d30e859dc60ecb9b1397e1e661d1b4bb7b4d9027cde8f8c708cb::loondon {
    struct LOONDON has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOONDON>, arg1: 0x2::coin::Coin<LOONDON>) {
        0x2::coin::burn<LOONDON>(arg0, arg1);
    }

    fun init(arg0: LOONDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOONDON>(arg0, 6, b"LOONDON", b"loondon", b"xxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOONDON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOONDON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOONDON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LOONDON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

