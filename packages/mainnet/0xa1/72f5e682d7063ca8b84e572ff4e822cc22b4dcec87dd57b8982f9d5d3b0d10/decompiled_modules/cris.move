module 0xa172f5e682d7063ca8b84e572ff4e822cc22b4dcec87dd57b8982f9d5d3b0d10::cris {
    struct CRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRIS>(arg0, 9, b"CRIS", b"Cris Duong", b"meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e355fe60-7417-4744-80b0-11aec7b6648f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

