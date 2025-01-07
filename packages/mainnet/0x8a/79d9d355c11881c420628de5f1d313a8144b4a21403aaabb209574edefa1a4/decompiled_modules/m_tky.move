module 0x8a79d9d355c11881c420628de5f1d313a8144b4a21403aaabb209574edefa1a4::m_tky {
    struct M_TKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: M_TKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M_TKY>(arg0, 9, b"M_TKY", b"Maxicoin", b"A meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f030dc42-0f6a-4583-9ff8-13e40cd145a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M_TKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M_TKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

