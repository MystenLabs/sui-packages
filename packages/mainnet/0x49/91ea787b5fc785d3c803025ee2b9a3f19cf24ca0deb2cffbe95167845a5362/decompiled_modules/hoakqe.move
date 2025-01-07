module 0x4991ea787b5fc785d3c803025ee2b9a3f19cf24ca0deb2cffbe95167845a5362::hoakqe {
    struct HOAKQE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOAKQE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOAKQE>(arg0, 9, b"HOAKQE", b"Hsbcd", b"Hi helo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a17e43de-741e-4d60-9aa9-654b7fc823f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOAKQE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOAKQE>>(v1);
    }

    // decompiled from Move bytecode v6
}

