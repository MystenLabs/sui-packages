module 0x685f0c03fffa98db4b1f8f21da844aa02a670b9714e18bb5d47ecfde19d84aaa::wassui {
    struct WASSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASSUI>(arg0, 6, b"WASSUI", b"wassui", b"WASSIE is a memecoin launched on the Ethereum blockchain, paying homage to a beloved internet meme. The Wassie meme originated in 2017 by user wasserpest, and evolved through interactions involving inversebrah and various other contributors. The first illustration appeared in 2016 on Twitter now X and was drawn by Japanese hentai artist Tukinowagamo. WASSUI aspires to position itself among the leading meme-inspired cryptocurrencies in the market. More information can be found at www.wassui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_38_3c34a263fb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WASSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

