module 0x91b951f4c40ed549552f6d8aa9f260c9e6617977d9e6209726dd890a6f8e1f9c::tiken1 {
    struct TIKEN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKEN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKEN1>(arg0, 9, b"TIKEN1", b"Token", b"Token7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c749338-99a3-406d-b8ef-c619026edbb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKEN1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIKEN1>>(v1);
    }

    // decompiled from Move bytecode v6
}

