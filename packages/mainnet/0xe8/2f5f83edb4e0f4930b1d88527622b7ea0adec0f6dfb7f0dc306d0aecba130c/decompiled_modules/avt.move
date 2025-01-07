module 0xe82f5f83edb4e0f4930b1d88527622b7ea0adec0f6dfb7f0dc306d0aecba130c::avt {
    struct AVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVT>(arg0, 9, b"AVT", b"Avatar", b"As the Avatar, Aang is the bridge between the human and spirit worlds and is the only person who can master all four elements. \"Avatar\" maintains the balance of the world and nature to create peace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e62997f8-11ce-48af-b66f-41a373c5ca38.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVT>>(v1);
    }

    // decompiled from Move bytecode v6
}

