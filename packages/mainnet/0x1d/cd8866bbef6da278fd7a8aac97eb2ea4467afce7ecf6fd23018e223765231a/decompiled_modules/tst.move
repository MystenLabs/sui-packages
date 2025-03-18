module 0x1dcd8866bbef6da278fd7a8aac97eb2ea4467afce7ecf6fd23018e223765231a::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TST>(arg0, 6, b"TST", b"TST Meme Coin by SuiAI", b"Generate TST meme token that represents for SuAI community [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/IW770f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

