module 0x13360dfdb8e1888d0053a1c36d81654c4b04933876cf65ac7062b8109cb25b0e::cheng {
    struct CHENG has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHENG>, arg1: 0x2::coin::Coin<CHENG>) {
        0x2::coin::burn<CHENG>(arg0, arg1);
    }

    fun init(arg0: CHENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENG>(arg0, 9, b"CHENG", b"cheng the holy mystical sui guru", x"e8bf99e4b8aae992b1e5b881e4bba3e8a1a8e79d80e7a59ee7a798e79a844368656e67e5a4a7e7a59e2054776974746572203a2068747470733a2f2f747769747465722e636f6d2f4368656e674f6e5375692054656c656772616d203a2068747470733a2f2f742e6d652f6368656e67746865686f6c796d7973746963616c73756967757275", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/nAKzjku.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHENG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHENG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

