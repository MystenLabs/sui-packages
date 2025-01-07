module 0x8b8a54ab8f8d0bf5a32e3bfe9cbebb5f6f5573e79b505f55a7324ffedb7167c8::bozo_coin {
    struct BOZO_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOZO_COIN>, arg1: 0x2::coin::Coin<BOZO_COIN>) {
        0x2::coin::burn<BOZO_COIN>(arg0, arg1);
    }

    fun init(arg0: BOZO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOZO_COIN>(arg0, 9, b"SOBA", b"SOBA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i7czr3pov4y7zj7clm4gy27g6la5bcrw4zjmlax2jk74c35gigiq.arweave.net/R8WY7e6vMfyn4ls4bGvm8sHQijbmUsWC-kq_wW-mQZE"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOZO_COIN>>(v1);
        0x2::coin::mint_and_transfer<BOZO_COIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BOZO_COIN>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOZO_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BOZO_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

