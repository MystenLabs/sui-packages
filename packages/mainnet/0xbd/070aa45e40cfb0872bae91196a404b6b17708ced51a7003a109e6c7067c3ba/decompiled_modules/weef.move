module 0xbd070aa45e40cfb0872bae91196a404b6b17708ced51a7003a109e6c7067c3ba::weef {
    struct WEEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEF>(arg0, 9, b"WEEF", b"Wolf", b"The best in hunting meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d29f6335-532a-42f5-8563-5307a6732adc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

