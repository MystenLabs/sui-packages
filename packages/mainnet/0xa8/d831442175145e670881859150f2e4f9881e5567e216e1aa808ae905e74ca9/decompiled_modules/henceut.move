module 0xa8d831442175145e670881859150f2e4f9881e5567e216e1aa808ae905e74ca9::henceut {
    struct HENCEUT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HENCEUT>, arg1: 0x2::coin::Coin<HENCEUT>) {
        0x2::coin::burn<HENCEUT>(arg0, arg1);
    }

    fun init(arg0: HENCEUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HENCEUT>(arg0, 2, b"HENCEUT", b"HENCEUT", b"MEMEK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://1000logos.net/wp-content/uploads/2017/12/Pornhub-symbol-500x419.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HENCEUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HENCEUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HENCEUT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HENCEUT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

