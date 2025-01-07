module 0xca99d7dcd756f0b3417508f9cfabb57df889dabea9f4641cc3f796201c1fce69::noooo {
    struct NOOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOOO>(arg0, 6, b"NOOOO", b"Noooo Sui", b"$NOOOO is a meme token with no intrinsic value or expectation of financial return. Its sole purpose is to own the libs and have fun along the way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002305_d4fa93fcb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

