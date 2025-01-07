module 0x967393a94b8972259dc4054919e239dac3a9feedf119a2721879546f7f7ef599::ham {
    struct HAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAM>(arg0, 9, b"HAM", b"HAMSTER", b"HAMSTER MINI #MEME #NFT FOR COMMUNITY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0cd673b-bc79-4ef8-b95e-7c70f498d38e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

