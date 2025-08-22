module 0x60936644f792a44faa2a650a290f27650314a0b0a2f07d64af5ed52fca901bcb::bububu {
    struct BUBUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBUBU>(arg0, 9, b"bububu", b"suipiritbuu", b"buuuuuuuuuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUBUBU>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBUBU>>(v2, @0x1a13a8cd7546238c381c200fc168e3512e466fb9d8902f5a5c62adeec7cf01dc);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

