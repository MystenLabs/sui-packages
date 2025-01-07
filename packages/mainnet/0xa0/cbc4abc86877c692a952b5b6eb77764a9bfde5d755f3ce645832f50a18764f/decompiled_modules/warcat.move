module 0xa0cbc4abc86877c692a952b5b6eb77764a9bfde5d755f3ce645832f50a18764f::warcat {
    struct WARCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARCAT>(arg0, 9, b"WARCAT", b"WOW", b"From another univers to another univers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c8fc9c4-1a22-4558-9d6d-6d3f41138ee2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

