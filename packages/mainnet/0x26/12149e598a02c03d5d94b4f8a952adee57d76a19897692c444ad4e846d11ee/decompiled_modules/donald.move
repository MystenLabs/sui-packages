module 0x2612149e598a02c03d5d94b4f8a952adee57d76a19897692c444ad4e846d11ee::donald {
    struct DONALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONALD>(arg0, 9, b"DONALD", b"DONALD COIN ON SUI", b"DONALD is on SUI now. LFG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.fm/u/x87js8tssv")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DONALD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

