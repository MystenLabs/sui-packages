module 0xcf8c301929ca5f257dd6d9b693d03c235ccbc444e43969d90dab52491980113c::bldy {
    struct BLDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLDY>(arg0, 9, b"BLDY", b"BIRD LADY ", b"BUY ANGRY BIRD LADY TO MAKE A PROFIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/898b897c-d4f7-47df-abd1-a8fa246857be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

