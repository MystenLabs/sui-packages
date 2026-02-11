module 0xed0a2387c75365f05da5a6095bb8101b033ccdc01bfed75c9a7d828726407eb6::london {
    struct LONDON has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LONDON>, arg1: 0x2::coin::Coin<LONDON>) {
        0x2::coin::burn<LONDON>(arg0, arg1);
    }

    fun init(arg0: LONDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONDON>(arg0, 6, b"LONDON", b"london", b"xxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LONDON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONDON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LONDON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LONDON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

