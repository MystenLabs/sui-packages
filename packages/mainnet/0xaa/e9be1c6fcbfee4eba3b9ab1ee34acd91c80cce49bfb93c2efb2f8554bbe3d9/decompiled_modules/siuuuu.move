module 0xaae9be1c6fcbfee4eba3b9ab1ee34acd91c80cce49bfb93c2efb2f8554bbe3d9::siuuuu {
    struct SIUUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUUU>(arg0, 6, b"SIUUUU", b"New token 1", b"Test token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/b5ae6450-dfe3-11ef-9dba-070b578638a0")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIUUUU>>(v1);
        0x2::coin::mint_and_transfer<SIUUUU>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUUU>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

