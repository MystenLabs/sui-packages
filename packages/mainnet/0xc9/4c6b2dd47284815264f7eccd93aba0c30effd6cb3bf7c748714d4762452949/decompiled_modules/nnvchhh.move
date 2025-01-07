module 0xc94c6b2dd47284815264f7eccd93aba0c30effd6cb3bf7c748714d4762452949::nnvchhh {
    struct NNVCHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNVCHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNVCHHH>(arg0, 9, b"NNVCHHH", x"4b686766c491786363", b"Bbvcchjj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7825306c-92d6-46a4-8991-a537700e7fb5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNVCHHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNVCHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

