module 0xb857d4ae73d5443aa9a2623d3e8f7ceb63333038df59752ecc028912480ec3d4::naicat {
    struct NAICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAICAT>(arg0, 9, b"NAICAT", b"NEINEI", b"Just an adventurous cat ready to bond with other animals.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a92ca29-3d16-4c3b-897b-942fee8f9ebf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

