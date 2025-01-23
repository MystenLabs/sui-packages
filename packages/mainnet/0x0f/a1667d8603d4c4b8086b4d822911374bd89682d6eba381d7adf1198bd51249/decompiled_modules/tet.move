module 0xfa1667d8603d4c4b8086b4d822911374bd89682d6eba381d7adf1198bd51249::tet {
    struct TET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TET>(arg0, 8, b"TET", b"TEST", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/e52962c0-d93a-11ef-a74b-b3b817eed47e")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TET>>(v1);
        0x2::coin::mint_and_transfer<TET>(&mut v2, 110000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TET>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

