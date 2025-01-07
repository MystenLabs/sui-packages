module 0xad4f939bff9548401fd2ebca24b435200335e06dd5fb92c05635366cfc391b73::bitmog {
    struct BITMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITMOG>(arg0, 6, b"BITMOG", b"8-Bit Mog", b"An old school gaming homage to one of the greatest community memecoins ever created! Play #8BITMOG now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241004_160200_255_b9a38529ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITMOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

