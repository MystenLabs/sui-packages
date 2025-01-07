module 0x61bb6efeb183c4db7a3e827387aa3805236d2460161367a9991034d6e4db7f2d::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 9, b"WOOF", b"Lost Dogs", b"Lost Dogs is an NFT survival game by Notcoin, where players take on the role of stray dogs in a post-apocalyptic world, earning and using $WOOF tokens to buy, trade, and upgrade items.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eab7dd5c-309e-4e14-929d-f08b988ca3de-IMG_5896.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

