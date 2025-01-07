module 0x799f74555fa1673dd758b8a691c2ac6442d19e75316951b47213a54a4add6bcb::aanya {
    struct AANYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AANYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AANYA>(arg0, 9, b"AANYA", b"ANYA", b"LANDED ANYA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b06309d-27bd-4da7-9c84-753743882ed1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AANYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AANYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

