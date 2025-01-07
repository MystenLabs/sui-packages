module 0xc53944f56cae25597f3ba2516f702b30333ab52ea229fe0eeac40b36016f4404::loffy {
    struct LOFFY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOFFY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOFFY>>(0x2::coin::mint<LOFFY>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: LOFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFFY>(arg0, 9, b"LOFFY", b"LOFFY", b"LOFFY 200m meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOFFY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOFFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFFY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

