module 0x243c0fbd3ec4d1e78be46ec7b12e09a78e08bbf1eb547831745cdcd50ab8a3ec::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DAWG>, arg1: 0x2::coin::Coin<DAWG>) {
        0x2::coin::burn<DAWG>(arg0, arg1);
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 2, b"DWG", b"Dawg", b"Just a dawg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/U3S0a9a.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DAWG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DAWG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

