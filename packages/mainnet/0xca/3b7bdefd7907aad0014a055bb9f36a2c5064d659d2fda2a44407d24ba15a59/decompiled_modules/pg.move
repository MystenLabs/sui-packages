module 0xca3b7bdefd7907aad0014a055bb9f36a2c5064d659d2fda2a44407d24ba15a59::pg {
    struct PG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PG>(arg0, 9, b"PG", b"Peg", b"Meme coin based on pegs and inspirated by clothes on pegs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3487b74-ee05-4773-87a7-87572be3e2cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PG>>(v1);
    }

    // decompiled from Move bytecode v6
}

