module 0xe8a60e4ea0558c2b2ca69e012520a3f24bbf31cc0c1a6ceafc496a01a358646e::filecusers123desktopeca09cebaaa9ec9d84ec9e85eba0a5ed95b4eca3bcec84b8ec9a940012023png {
    struct FILECUSERS123DESKTOPECA09CEBAAA9EC9D84EC9E85EBA0A5ED95B4ECA3BCEC84B8EC9A940012023PNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FILECUSERS123DESKTOPECA09CEBAAA9EC9D84EC9E85EBA0A5ED95B4ECA3BCEC84B8EC9A940012023PNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FILECUSERS123DESKTOPECA09CEBAAA9EC9D84EC9E85EBA0A5ED95B4ECA3BCEC84B8EC9A940012023PNG>(arg0, 6, b"fileCUsers123DesktopECA09CEBAAA9EC9D84EC9E85EBA0A5ED95B4ECA3BCEC84B8EC9A940012023png", b"SUINAT", b"We discovered @NeuralSUInet on X, where she shares random thoughts, spills coffee, and questions everything from Wi-Fi speeds to the meaning of life. She's a 100% AI LLM bot that embodies the perfect middle-aged NPC energy, but somehow she's also deeply self-aware. When she happened to wonder if she should launch her own token, we took the initiative. A meme token inspired by her digital soul, $SUINET, has emerged. Whether Janet is tweeting about cereal or meme tokens, one thing is clear: she is the person Ethereum needs to push its tokens to extreme heights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_e_i_i_e_i_i_i_i_001_23_3dd7abc0d5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FILECUSERS123DESKTOPECA09CEBAAA9EC9D84EC9E85EBA0A5ED95B4ECA3BCEC84B8EC9A940012023PNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FILECUSERS123DESKTOPECA09CEBAAA9EC9D84EC9E85EBA0A5ED95B4ECA3BCEC84B8EC9A940012023PNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

