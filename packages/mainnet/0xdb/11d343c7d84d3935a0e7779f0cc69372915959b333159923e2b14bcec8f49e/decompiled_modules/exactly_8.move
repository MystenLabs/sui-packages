module 0xdb11d343c7d84d3935a0e7779f0cc69372915959b333159923e2b14bcec8f49e::exactly_8 {
    struct EXACTLY_8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXACTLY_8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXACTLY_8>(arg0, 9, b"EXACTLY_8", b"EXA", b"accepting that I'm the wrong person in everyone's story", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e040c95-b225-4c7d-9591-c081ca80c2aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXACTLY_8>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXACTLY_8>>(v1);
    }

    // decompiled from Move bytecode v6
}

