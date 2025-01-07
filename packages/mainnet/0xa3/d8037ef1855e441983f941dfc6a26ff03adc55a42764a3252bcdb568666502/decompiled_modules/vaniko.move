module 0xa3d8037ef1855e441983f941dfc6a26ff03adc55a42764a3252bcdb568666502::vaniko {
    struct VANIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VANIKO>(arg0, 9, b"VANIKO", b"Binance cat \"VANIKO\"", b"VANIKO, THE ONLY BINANCE CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaWFZLpBsnBd3aakWatFenyVRtHgB3229G5YiQX57Yike")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VANIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VANIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

