module 0x5e3e4101750c06a5d02c8710392cc422107b398a0627ef6e96f3859e0282a184::smk {
    struct SMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMK>(arg0, 6, b"SMK", b"SUIMUSK", b"SUIMUSK, is the real crypto on SUI! It is not just a token; we are building the most trusted meme coin on SUI, backed by real value and a winning community. SUIMUSK is fair launched on SUI with MovePump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimusk512x512_7b49c05fca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

