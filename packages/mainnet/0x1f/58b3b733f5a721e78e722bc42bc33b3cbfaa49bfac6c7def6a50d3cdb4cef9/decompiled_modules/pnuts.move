module 0x1f58b3b733f5a721e78e722bc42bc33b3cbfaa49bfac6c7def6a50d3cdb4cef9::pnuts {
    struct PNUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTS>(arg0, 6, b"PNUTS", b"PEANUT THE SQUIRREL", x"5065616e75742074686520537175697272656c20697320536f6c616e61e280997320636865656b79206c6974746c652062726f746865722c206e6f77206f6e207468652053756920626c6f636b636861696e2120466173742c2066756e2c20616e6420726561647920746f207374617368206761696e732c205065616e7574206973206865726520746f2070726f7665206865277320676f7420776861742069742074616b65732e204a6f696e207468652061636f726e2061726d7920616e64207761746368207468697320737175697272656c20736f61722120f09f8cb0f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731374963214.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

