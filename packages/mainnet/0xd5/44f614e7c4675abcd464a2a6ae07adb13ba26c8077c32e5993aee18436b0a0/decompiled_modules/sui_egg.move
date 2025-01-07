module 0xd544f614e7c4675abcd464a2a6ae07adb13ba26c8077c32e5993aee18436b0a0::sui_egg {
    struct SUI_EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_EGG>(arg0, 9, b"SUI EGG", b"SUI EGG", b"egg on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_EGG>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_EGG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_EGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

