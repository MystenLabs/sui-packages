module 0x807e4dc37f2a365349cec2aeb72385be4404298098a4c4cef244d22aab283837::yuu {
    struct YUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUU>(arg0, 9, b"YUU", b"Youg", x"49e280996d20676f696e6720746f206574796d6f6c6f677920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51c5f480-6419-4952-95c7-7ac9ebc0cafb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

