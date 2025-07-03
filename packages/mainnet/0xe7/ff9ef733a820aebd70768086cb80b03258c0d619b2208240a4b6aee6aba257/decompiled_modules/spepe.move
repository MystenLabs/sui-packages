module 0xe7ff9ef733a820aebd70768086cb80b03258c0d619b2208240a4b6aee6aba257::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPEPE>, arg1: 0x2::coin::Coin<SPEPE>) {
        0x2::coin::burn<SPEPE>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<SPEPE>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(arg0, @0x0);
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 6, b"SPEPE", b"Sui Pepe", x"24535045504520697320746865206669727374206d656d65206f6e205375692061696d696e6720666f7220243530304d2e20245045504520656e657267792c205375692073706565642e20426f726e20746f2072756c652074686520636861696e202d206e6f7420666f6c6c6f772069742e20486f7020696e206561726c7920f09f90b8202d2068747470733a2f2f737569706570652e6e6574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/Hi7aR0m.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

