module 0x1055f30a030bf6ee380f6dcc47b4eb441a3ce7bdc3ec155ad8718321022a6f10::sui_shark {
    struct SUI_SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_SHARK>(arg0, 9, b"SUI SHARK", x"f09fa68853756920536861726b", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_SHARK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_SHARK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_SHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

