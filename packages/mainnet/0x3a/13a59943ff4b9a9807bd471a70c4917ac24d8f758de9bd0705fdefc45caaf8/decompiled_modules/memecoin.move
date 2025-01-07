module 0x3a13a59943ff4b9a9807bd471a70c4917ac24d8f758de9bd0705fdefc45caaf8::memecoin {
    struct MEMECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECOIN>(arg0, 9, b"MEMECOIN", b"meme", b"is meme season again?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61e9a145-0a19-41bb-9033-ba78c6d430c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

