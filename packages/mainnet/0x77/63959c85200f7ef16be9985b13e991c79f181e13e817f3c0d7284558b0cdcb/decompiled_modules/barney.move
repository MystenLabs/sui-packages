module 0x7763959c85200f7ef16be9985b13e991c79f181e13e817f3c0d7284558b0cdcb::barney {
    struct BARNEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARNEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARNEY>(arg0, 9, b"BARNEY", b"BARNEY BARNEY", b"BARNEY BARNEY BARNEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeid2mvbnm3v366enw3p2zib7pbdhuty5t2ctu6u32mqe4iagv5ypau.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BARNEY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARNEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARNEY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

