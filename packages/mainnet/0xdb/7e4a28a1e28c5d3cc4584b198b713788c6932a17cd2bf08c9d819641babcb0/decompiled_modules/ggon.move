module 0xdb7e4a28a1e28c5d3cc4584b198b713788c6932a17cd2bf08c9d819641babcb0::ggon {
    struct GGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGON>(arg0, 9, b"GGON", b"Gaga on", b"Meme for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38660ff3-597d-4eec-b3e5-37bbb72eeca4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

