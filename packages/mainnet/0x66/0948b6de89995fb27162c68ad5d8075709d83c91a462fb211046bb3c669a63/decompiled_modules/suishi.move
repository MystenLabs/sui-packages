module 0x660948b6de89995fb27162c68ad5d8075709d83c91a462fb211046bb3c669a63::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"First Sushi on SUI", x"5375736869206c6f7665727320616e64207465636820656e7468757369617374732c20756e6974652120f09f8da3e29ca8204d656574205355495348492c2074686520666972737420746f6b656e206f6e2074686520535549206e6574776f726b20696e7370697265642062792074686520776f726c64e2809973206d6f73742069636f6e6963204a6170616e65736520646973682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732125274507.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

