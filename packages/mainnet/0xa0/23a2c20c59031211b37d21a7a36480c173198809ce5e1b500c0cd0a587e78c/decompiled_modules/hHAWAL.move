module 0xa023a2c20c59031211b37d21a7a36480c173198809ce5e1b500c0cd0a587e78c::hHAWAL {
    struct HHAWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHAWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHAWAL>(arg0, 9, b"hHAWAL", b"hHAWAL Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv-curator.haedal.xyz/Lendvault/lpt/hhawal_e1d0183f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HHAWAL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHAWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

