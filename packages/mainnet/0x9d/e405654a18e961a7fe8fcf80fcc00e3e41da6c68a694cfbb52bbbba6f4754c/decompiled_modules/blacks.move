module 0x9de405654a18e961a7fe8fcf80fcc00e3e41da6c68a694cfbb52bbbba6f4754c::blacks {
    struct BLACKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKS>(arg0, 6, b"BLACKS", b"BLACK SCREEN", b"Satoshi Nakamoto is the name used by the presumed pseudonymous] person or persons who developed bitcoin, authored the bitcoin white paper, and created and deployed bitcoin's original reference implementation.As part of the implementation, Nakamoto also devised the first blockchain database Nakamoto was active in the development of bitcoin until December 2010.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_08_132240_6e6227b6df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

