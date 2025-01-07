module 0xd29b409e07916e2f67e2aab8f83f7e46a0041b1fd64bef8376eb0c7a60c653a2::wgmi {
    struct WGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WGMI>(arg0, 9, b"WGMI", b"WagmiToad", x"5765e28099726520616c6c20676f6e6e61206d616b65206974e2809d20617320746f616473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87823693-9896-4a16-89fb-1aa8358459b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

