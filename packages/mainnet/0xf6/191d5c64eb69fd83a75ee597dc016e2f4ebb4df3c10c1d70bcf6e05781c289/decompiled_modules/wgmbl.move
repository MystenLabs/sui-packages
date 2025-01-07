module 0xf6191d5c64eb69fd83a75ee597dc016e2f4ebb4df3c10c1d70bcf6e05781c289::wgmbl {
    struct WGMBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGMBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WGMBL>(arg0, 9, b"WGMBL", b"WeWeGombeL", b"WeWeGombeL is another meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1bcf5c2-04f7-4dad-8546-c19158d2fcba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WGMBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WGMBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

