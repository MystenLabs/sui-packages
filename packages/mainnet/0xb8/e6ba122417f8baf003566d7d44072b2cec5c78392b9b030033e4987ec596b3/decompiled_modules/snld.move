module 0xb8e6ba122417f8baf003566d7d44072b2cec5c78392b9b030033e4987ec596b3::snld {
    struct SNLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNLD>(arg0, 9, b"SNLD", b"Suinaldo", b"Meme coin token For Ronaldo Fans Boys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e15ade0a-1822-4ecd-ac5a-2b020805eca5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

