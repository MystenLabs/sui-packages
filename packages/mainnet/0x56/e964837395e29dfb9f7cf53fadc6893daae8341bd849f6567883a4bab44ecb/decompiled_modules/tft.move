module 0x56e964837395e29dfb9f7cf53fadc6893daae8341bd849f6567883a4bab44ecb::tft {
    struct TFT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TFT>, arg1: 0x2::coin::Coin<TFT>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TFT>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TFT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TFT>>(0x2::coin::mint<TFT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFT>(arg0, 6, b"TFT", b"TFT", b"TFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://niattopup.com/upload/category_masteradmin_20240319214848.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_treasury_cap<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

