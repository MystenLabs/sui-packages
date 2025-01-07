module 0x9343fd764647d351b376dafad8a8781daf09ee1e494dfef631bdce146669de82::trump47th {
    struct TRUMP47TH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP47TH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP47TH>(arg0, 9, b"TRUMP47TH", b"Trump47", b"America President 47th", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ccf121b3-9444-4742-acc4-c78ef14b22d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP47TH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP47TH>>(v1);
    }

    // decompiled from Move bytecode v6
}

