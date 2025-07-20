module 0x7d06a8a8eb46a19e77c2851e2c1b0d5e5a1cd983ab7e89f40d8200c5db2adbde::orai {
    struct ORAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ORAI>(arg0, 6, b"ORAI", b"ORACLE AI", x"4f7261636c65204149206973206120766973696f6e2d64726976656e206167656e74206f6e20537569207468617420736565732c20726561736f6e732c20616e642061637473206175746f6e6f6d6f75736c79206f6e636861696e2e2e497420776174636865732074686520626c6f636b636861696e206c696b6520616e20657965e2809470726564696374696e67207472656e64732c206c6f6767696e67206465636973696f6e732c20616e6420706f776572696e6720696e74656c6c6967656e7420636f6e7472616374732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0534_76253d47da.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

