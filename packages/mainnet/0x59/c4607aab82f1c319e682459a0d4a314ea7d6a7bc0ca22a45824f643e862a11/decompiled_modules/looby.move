module 0x59c4607aab82f1c319e682459a0d4a314ea7d6a7bc0ca22a45824f643e862a11::looby {
    struct LOOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOBY>(arg0, 6, b"LOOBY", b"Looby Rabbit Sui", b"The ultimate memecoin badboy, er rabbit, rat? Honestly, we still don't have a f*cking clue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014454_91528be8fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

