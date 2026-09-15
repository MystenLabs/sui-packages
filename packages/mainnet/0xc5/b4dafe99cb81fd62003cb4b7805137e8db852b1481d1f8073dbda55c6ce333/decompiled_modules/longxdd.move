module 0xc5b4dafe99cb81fd62003cb4b7805137e8db852b1481d1f8073dbda55c6ce333::longxdd {
    struct LONGXDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONGXDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONGXDD>(arg0, 18, b"Longxdd", b"Longxdd", b"Longxdd standard Sui coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LONGXDD>>(0x2::coin::mint<LONGXDD>(&mut v2, 314159265358979330, arg1), @0xe671c9046116890bddad6a5af56dae3431a91837d302cac8c944cf6d28e17c7e);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LONGXDD>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LONGXDD>>(v2);
    }

    // decompiled from Move bytecode v7
}

