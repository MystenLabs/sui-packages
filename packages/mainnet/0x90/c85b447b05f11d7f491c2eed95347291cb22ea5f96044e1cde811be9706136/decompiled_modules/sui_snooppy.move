module 0x90c85b447b05f11d7f491c2eed95347291cb22ea5f96044e1cde811be9706136::sui_snooppy {
    struct SUI_SNOOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_SNOOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_SNOOPPY>(arg0, 9, b"SUI SNOOPPY", x"f09f90b6536e6f70707920537569", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_SNOOPPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_SNOOPPY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_SNOOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

