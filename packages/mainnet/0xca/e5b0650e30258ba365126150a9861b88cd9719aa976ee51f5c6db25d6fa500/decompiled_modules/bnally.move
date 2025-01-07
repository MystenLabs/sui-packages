module 0xcae5b0650e30258ba365126150a9861b88cd9719aa976ee51f5c6db25d6fa500::bnally {
    struct BNALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNALLY>(arg0, 9, b"BNALLY", b"Billiz", b"Bnally is building on Sui BLOCKCHAIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37b0c5a8-fdda-44b6-a2e3-6849dd90c21e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

