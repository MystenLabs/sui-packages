module 0x88d5402170c62de559a2846b7b071beba9421a621fb466f7914d7ded24caafca::skt {
    struct SKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKT>(arg0, 6, b"SKT", b"SuiKermit", b"Sui Kermit, the sensational hopping meme frog of Sui Blockchain! With his infectious charm and undeniable meme-worthy presence,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Kermit_93a5b6401d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

