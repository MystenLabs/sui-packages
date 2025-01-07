module 0x574b7f0c341a52cef56c8b0093cfa8d7f83d505ff1a22a9507fc097f5c1ba49::suf {
    struct SUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUF>(arg0, 9, b"SUF", b"SuiFlow ", b"SuiFlow (SUF) is a utility token designed to foster community growth, education, and engagement on the Sui Blockchain. SUF token holders gain access to exclusive resources, events, and opportunities, empowering them to succeed in the Web3 ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c43baabc-98d6-4d78-9577-3fd11d163375.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

