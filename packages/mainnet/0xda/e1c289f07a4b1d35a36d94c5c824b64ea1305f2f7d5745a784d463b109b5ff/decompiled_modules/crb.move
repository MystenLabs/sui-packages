module 0xdae1c289f07a4b1d35a36d94c5c824b64ea1305f2f7d5745a784d463b109b5ff::crb {
    struct CRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRB>(arg0, 6, b"CRB", b"CRAB$", b" Bringing you the finest crab-approved memes ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crabs_250_a6282b3db5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

