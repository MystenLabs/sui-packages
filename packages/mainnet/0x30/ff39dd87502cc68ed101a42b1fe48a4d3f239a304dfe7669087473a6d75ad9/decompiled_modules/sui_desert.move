module 0x30ff39dd87502cc68ed101a42b1fe48a4d3f239a304dfe7669087473a6d75ad9::sui_desert {
    struct SUI_DESERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_DESERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_DESERT>(arg0, 9, b"SUI DESERT", x"f09f8cb553756920446573657274", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_DESERT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_DESERT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_DESERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

