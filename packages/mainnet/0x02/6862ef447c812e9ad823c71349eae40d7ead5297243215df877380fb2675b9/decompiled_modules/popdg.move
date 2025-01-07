module 0x26862ef447c812e9ad823c71349eae40d7ead5297243215df877380fb2675b9::popdg {
    struct POPDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDG>(arg0, 9, b"POPDG", b"POPDOG", b"POP DOG FAN MEME ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5f03b7e-e405-4b15-bf06-b067eebb73fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

