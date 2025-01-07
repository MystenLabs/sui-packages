module 0xddebcd207f8ccf08a18d3c448c42385aaf2b2195337b5f7728003b521d7084d6::mameh_4me {
    struct MAMEH_4ME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMEH_4ME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMEH_4ME>(arg0, 9, b"MAMEH_4ME", b"Mameh", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eac0b376-295d-4e43-b1e2-6813dd3ed7d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMEH_4ME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMEH_4ME>>(v1);
    }

    // decompiled from Move bytecode v6
}

