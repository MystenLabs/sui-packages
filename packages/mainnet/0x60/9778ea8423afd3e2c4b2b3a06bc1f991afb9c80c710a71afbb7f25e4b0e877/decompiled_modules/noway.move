module 0x609778ea8423afd3e2c4b2b3a06bc1f991afb9c80c710a71afbb7f25e4b0e877::noway {
    struct NOWAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOWAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOWAY>(arg0, 9, b"NOWAY", b"No Way", x"4e6f207761792062726f2e20486572652077696c6c20626520796f75722070726f66697420f09f988e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cfc94fe5-4515-4670-9a24-870f33e5d426.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOWAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOWAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

