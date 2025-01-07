module 0xfcd38d395f4a994c5845d38e73c4348c162556b0b87b111cc2451ae61e6757d1::wndw {
    struct WNDW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WNDW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WNDW>(arg0, 9, b"WNDW", b"REDWINDOW", b"THIS LIGHT IS GONNA ALWAYS BE RED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19bc84df-0541-4c19-a74f-556b991f3929.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WNDW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WNDW>>(v1);
    }

    // decompiled from Move bytecode v6
}

