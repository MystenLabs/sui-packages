module 0x76305957845d1c245d8d094cf28f7de6b47b801363c3233d67b6296823d8d565::magaai {
    struct MAGAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MAGAAI>(arg0, 6, b"MAGAAI", b"MAGA AI by SuiAI", b"MAGA AI is more than just an information bot; it is a powerful tool for navigating the complexities of the crypto world. By combining the engaging style of Donald Trump with sophisticated AI capabilities, MAGA AI offers users a unique and valuable resource for staying informed and making smart decisions in the blockchain space. Join us in making America great again with AI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ez_b0291e14b9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGAAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

