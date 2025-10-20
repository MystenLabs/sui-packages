module 0x1d92e86d8be99b4d8ce08401e9b39c7a00e80ba5af1b6b6018abc530d5b3db66::slf {
    struct SLF has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SLF>, arg1: 0x2::coin::Coin<SLF>) {
        0x2::coin::burn<SLF>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SLF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SLF>>(0x2::coin::mint<SLF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLF>(arg0, 9, b"SLF", b"SUILabFun", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SLF>>(0x2::coin::mint<SLF>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

