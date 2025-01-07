module 0x758e52c285ddd27f0001626800d6d08df56cb538e0144b1b888fc4b73b4f6085::xmasguy {
    struct XMASGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMASGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMASGUY>(arg0, 6, b"XMASGUY", b"XmasGuy on SUI", b"$XmasGuy on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hibuwg7_400x400_d999884d58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMASGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMASGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

