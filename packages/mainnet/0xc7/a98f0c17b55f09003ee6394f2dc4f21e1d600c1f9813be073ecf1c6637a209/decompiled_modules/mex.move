module 0xc7a98f0c17b55f09003ee6394f2dc4f21e1d600c1f9813be073ecf1c6637a209::mex {
    struct MEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEX>(arg0, 9, b"MEX", b"MEXICO ", b"Meme coin to steez up the crypto space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8bf7a110-5800-4120-a092-a6b96bfa6fcc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

