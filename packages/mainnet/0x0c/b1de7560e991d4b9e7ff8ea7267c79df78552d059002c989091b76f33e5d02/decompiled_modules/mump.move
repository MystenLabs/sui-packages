module 0xcb1de7560e991d4b9e7ff8ea7267c79df78552d059002c989091b76f33e5d02::mump {
    struct MUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMP>(arg0, 9, b"MUMP", b"Muskpump", b"Meme In honour of musk and trump friendship", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b70b1034-9383-40f2-baf3-c1d1af28318b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

