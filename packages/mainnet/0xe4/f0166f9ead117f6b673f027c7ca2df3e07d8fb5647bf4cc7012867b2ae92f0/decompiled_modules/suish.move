module 0xe4f0166f9ead117f6b673f027c7ca2df3e07d8fb5647bf4cc7012867b2ae92f0::suish {
    struct SUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISH>(arg0, 6, b"SUISH", b"SUISH on Sui", b"Just Pump it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib343atarryvghph36ds6habdeobvprowbeyvw5uurv7njrzwxs64")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

