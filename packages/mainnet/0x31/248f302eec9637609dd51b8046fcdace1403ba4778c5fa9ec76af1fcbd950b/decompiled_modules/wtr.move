module 0x31248f302eec9637609dd51b8046fcdace1403ba4778c5fa9ec76af1fcbd950b::wtr {
    struct WTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTR>(arg0, 9, b"WTR", b"Water", b"the next 100x meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b72d113c-53a2-4959-ad12-26de10318e90-1000362515.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

