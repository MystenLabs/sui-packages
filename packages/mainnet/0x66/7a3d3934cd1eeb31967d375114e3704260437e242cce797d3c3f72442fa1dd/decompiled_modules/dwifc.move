module 0x667a3d3934cd1eeb31967d375114e3704260437e242cce797d3c3f72442fa1dd::dwifc {
    struct DWIFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWIFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWIFC>(arg0, 9, b"DWIFC", b"Deng Wif Cancer", b"moo deng gets cancer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DWIFC>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWIFC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWIFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

