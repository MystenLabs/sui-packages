module 0x3a16585551caaa76029c712457558eccd54dc2c103673fb2f6f578f8c9aa2910::doddy {
    struct DODDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODDY>(arg0, 6, b"DODDY", b"Doddy Oil", b"I'm your daddy, bring me Boden and Tremp. I will let them taste my Doddy oil!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1d3c98b9b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

