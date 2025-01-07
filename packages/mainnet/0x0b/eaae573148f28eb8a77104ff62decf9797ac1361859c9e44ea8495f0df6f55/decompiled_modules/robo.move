module 0xbeaae573148f28eb8a77104ff62decf9797ac1361859c9e44ea8495f0df6f55::robo {
    struct ROBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBO>(arg0, 6, b"ROBO", b"ROBOSUI", b"Each $ROBO is unique and represents a variety of meme themes, ranging from famous internet moments and viral trends to exclusively designed memes. Our coins are crafted in different styles, featuring various hilarious expressions, meme accessories, backgrounds, and colors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_5603a19f38.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

