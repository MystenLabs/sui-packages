module 0x5edbfddebdebebf576ef66575cd3c88577c82be9b35a73a3e06916bbb24402c2::m_11 {
    struct M_11 has drop {
        dummy_field: bool,
    }

    fun init(arg0: M_11, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M_11>(arg0, 9, b"M_11", b"meomeme", b"meme in the star", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0368a541-3b91-4a02-8e8d-34a8a54a41c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M_11>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M_11>>(v1);
    }

    // decompiled from Move bytecode v6
}

