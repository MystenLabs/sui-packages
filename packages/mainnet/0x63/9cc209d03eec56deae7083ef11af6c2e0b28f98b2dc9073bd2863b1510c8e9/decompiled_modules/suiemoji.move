module 0x639cc209d03eec56deae7083ef11af6c2e0b28f98b2dc9073bd2863b1510c8e9::suiemoji {
    struct SUIEMOJI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIEMOJI>, arg1: 0x2::coin::Coin<SUIEMOJI>) {
        0x2::coin::burn<SUIEMOJI>(arg0, arg1);
    }

    fun init(arg0: SUIEMOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEMOJI>(arg0, 2, b"SuiEmoji", b"SuiEmoji", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIEMOJI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEMOJI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIEMOJI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIEMOJI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

