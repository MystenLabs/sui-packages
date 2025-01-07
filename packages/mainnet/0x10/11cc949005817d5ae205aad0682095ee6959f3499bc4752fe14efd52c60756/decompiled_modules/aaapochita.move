module 0x1011cc949005817d5ae205aad0682095ee6959f3499bc4752fe14efd52c60756::aaapochita {
    struct AAAPOCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPOCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPOCHITA>(arg0, 6, b"AAAPOCHITA", b"aaaPochita", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pochita_2ff8303ead.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPOCHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAPOCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

