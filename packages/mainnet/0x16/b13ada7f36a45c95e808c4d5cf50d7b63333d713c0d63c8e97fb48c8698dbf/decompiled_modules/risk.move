module 0x16b13ada7f36a45c95e808c4d5cf50d7b63333d713c0d63c8e97fb48c8698dbf::risk {
    struct RISK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RISK>(arg0, 9, b"RISK", b"RISK", b"the biggest risk is not taking the risk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RISK>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RISK>>(v1);
    }

    // decompiled from Move bytecode v6
}

