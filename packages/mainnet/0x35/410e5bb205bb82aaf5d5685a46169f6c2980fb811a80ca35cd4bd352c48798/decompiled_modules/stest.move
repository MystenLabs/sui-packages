module 0x35410e5bb205bb82aaf5d5685a46169f6c2980fb811a80ca35cd4bd352c48798::stest {
    struct STEST has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<STEST>, arg1: 0x2::coin::Coin<STEST>) {
        0x2::coin::burn<STEST>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<STEST>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEST>>(arg0, @0x0);
    }

    fun init(arg0: STEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEST>(arg0, 6, b"STEST", b"Sui Test", x"24535045504520697320746865206669727374206d656d65206f6e205375692061696d696e6720666f7220243530304d2e20245045504520656e657267792c205375692073706565642e20426f726e20746f2072756c652074686520636861696e202d206e6f7420666f6c6c6f772069742e20486f7020696e206561726c7920f09f90b8202d2068747470733a2f2f737569706570652e6e6574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/mW3y4mo.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<STEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STEST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

