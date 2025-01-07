module 0x9559210a2b9e4311f1e35247b5f426053e3577663adbcc0307fc95da1d9bd0db::tromp {
    struct TROMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROMP>(arg0, 9, b"TROMP", b"Do lund tr", b"This is a meme coin of doland trump. Buy if you support doland trump. Trump 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b670213c-425b-4385-aedb-d9c38118bf01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

