module 0x80ac2b9138dd285cd1b88edac3d677149cd45db07fedfff6a705adf843ae5c89::hot {
    struct HOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOT>(arg0, 9, b"HOT", b"Hot Coin", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3ecaa52-c7b3-4560-ba82-2a6ce73c9a91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

