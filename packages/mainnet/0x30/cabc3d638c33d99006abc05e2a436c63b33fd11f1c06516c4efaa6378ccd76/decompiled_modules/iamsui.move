module 0x30cabc3d638c33d99006abc05e2a436c63b33fd11f1c06516c4efaa6378ccd76::iamsui {
    struct IAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAMSUI>(arg0, 6, b"IAMSUI", b"I AM SUI", b"The swift and savvy sensei of SuiLand More than just a meme coin  we are a fusion of martial arts mastery and blockchain innovation built to kick momentum into the SUI ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihxhlvmjzxvz2mjfdagnlxkqlf5ngx5fbfh4cgkushijp7xnyzjve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IAMSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

