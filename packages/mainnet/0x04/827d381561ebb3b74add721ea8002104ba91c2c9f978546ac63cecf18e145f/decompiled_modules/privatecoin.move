module 0x4827d381561ebb3b74add721ea8002104ba91c2c9f978546ac63cecf18e145f::privatecoin {
    struct PRIVATECOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PRIVATECOIN>, arg1: 0x2::coin::Coin<PRIVATECOIN>) {
        0x2::coin::burn<PRIVATECOIN>(arg0, arg1);
    }

    public fun disable_treasury(arg0: 0x2::coin::TreasuryCap<PRIVATECOIN>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PRIVATECOIN>>(arg0);
    }

    fun init(arg0: PRIVATECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIVATECOIN>(arg0, 9, b"USDC", b"TarUS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"`https://raw.githubusercontent.com/tokenusdt/USDTlogo1/refs/heads/main/USD_Coin_logo_(cropped).png`")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIVATECOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIVATECOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PRIVATECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PRIVATECOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

