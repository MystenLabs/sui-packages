module 0xc436bef18fbe91f53584815ab6f15a89e2ab9e098d6cea75118320ae4b40d15::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 9, b"SUI", b"SUIPUP", b"Suipup is a meme coin on the fast, scalable Sui blockchain. With low fees, rapid transactions, and a deflationary model, it rewards holders and builds a fun, engaged community. Join Suipup and be part of the next big meme coin revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/140de37b-49fa-4a28-ac19-de7da352142c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

