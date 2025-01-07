module 0xa96dbff8285e103071ec44fc86cfe820cc19553f03be9bd982890e4202ac4063::ssph {
    struct SSPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSPH>(arg0, 9, b"SSPH", b"SuiSphere", b"SuiSphere is here fully loaded", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSPH>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSPH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

