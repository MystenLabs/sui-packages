module 0x1fb75d161fc71b3c47c822fa2ca2ddeb02c6f65ce0f74a6157e2466e424c774e::barry {
    struct BARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRY>(arg0, 6, b"Barry", b"Barry The Puffer fish", x"4261727279205468652046616d6f75732050756666657220666973683a200a3235306b206f6e20496e7374616772616d200a3534306b206f6e2054696b746f6b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/99cec14a_1a68_4543_ba92_7062bd542f81_5c3d275130.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

