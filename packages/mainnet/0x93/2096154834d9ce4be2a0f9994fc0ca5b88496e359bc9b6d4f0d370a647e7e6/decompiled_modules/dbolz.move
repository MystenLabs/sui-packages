module 0x932096154834d9ce4be2a0f9994fc0ca5b88496e359bc9b6d4f0d370a647e7e6::dbolz {
    struct DBOLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBOLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBOLZ>(arg0, 6, b"DBOLZ", b"Dragon Bolz", x"44424f4c5a0a54686520556c74696d617465204d656d6520436f696e2046696768746572204f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih6u7vpf2njcvymt2upbkukptpgb2h4jjrwi2ey7lnfp4i4uuvwni")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBOLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DBOLZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

