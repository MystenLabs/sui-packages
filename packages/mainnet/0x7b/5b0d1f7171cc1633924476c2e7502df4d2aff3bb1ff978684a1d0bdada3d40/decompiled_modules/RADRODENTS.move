module 0x7b5b0d1f7171cc1633924476c2e7502df4d2aff3bb1ff978684a1d0bdada3d40::RADRODENTS {
    struct RADRODENTS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RADRODENTS>, arg1: 0x2::coin::Coin<RADRODENTS>) {
        0x2::coin::burn<RADRODENTS>(arg0, arg1);
    }

    fun init(arg0: RADRODENTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RADRODENTS>(arg0, 8, b"RADRODENTS", b"RADRODENTS", b"https://radrodents.dev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/qArdsHfMr04JR-G1RVON4znOOcmbF6-RIDojS_PF8CY?ext=png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<RADRODENTS>>(0x2::coin::mint<RADRODENTS>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RADRODENTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RADRODENTS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

