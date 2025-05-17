module 0x34ff6039232dde646d04d40f194a3b43ec29a31f11366d1b1f009914f7dbd369::gmgm {
    struct GMGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMGM>(arg0, 6, b"GMGM", b"GMGM TOKEN", b"NEW CULTURE HAS ARRIVED and GMGM GUYS!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif2edwbkwwbtu46wj6iyo52kulv2rkzv2q2njdvrofbnfdlcydhga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GMGM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

