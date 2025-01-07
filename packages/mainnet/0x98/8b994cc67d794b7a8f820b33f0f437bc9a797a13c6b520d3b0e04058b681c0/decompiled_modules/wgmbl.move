module 0x988b994cc67d794b7a8f820b33f0f437bc9a797a13c6b520d3b0e04058b681c0::wgmbl {
    struct WGMBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGMBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WGMBL>(arg0, 9, b"WGMBL", b"WeWeGombeL", b"WeWeGombeL is another meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a5e27cd-b1f8-4456-9f65-7dafc1bc6901.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WGMBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WGMBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

