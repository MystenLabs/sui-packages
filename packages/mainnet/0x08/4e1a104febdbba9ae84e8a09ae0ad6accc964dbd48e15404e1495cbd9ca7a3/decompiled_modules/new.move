module 0x84e1a104febdbba9ae84e8a09ae0ad6accc964dbd48e15404e1495cbd9ca7a3::new {
    struct NEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEW>(arg0, 9, b"NEW", b"NEW MEME", b"MEW MEW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f89d86a1-1c0b-4a67-a827-4f3571580d02.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

