module 0x4715e6a1750d3a277fa6c16fe3921fb8b115612640b031f6d9801512019b710::gave {
    struct GAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAVE>(arg0, 6, b"GAVE", b"Gave coin", b"The first coin to be implemented in Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058605_dc9d7d30c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

