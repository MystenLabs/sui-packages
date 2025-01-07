module 0x4fb8bc62a907832df026a0ad51c8373b15d2b79277dd33201c3579cc1604a1ea::allsui {
    struct ALLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALLSUI>(arg0, 9, b"ALLSUI", b"All Sui", b"Just to achieve impossible ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1b8a24c-7366-43d8-90e3-bf3edb58d61e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

