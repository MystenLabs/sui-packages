module 0xb3b920c2528a3014696497756dc8ad5fd0706c4cd8a65167e6150fd6061238d1::cate {
    struct CATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATE>(arg0, 6, b"CATE", b"Cate On Sui", b"$DOGE led the meme revolution for over a decade, now it's $CATE's turn to reign supreme. Embrace the rise of $CATE, poised to become the largest and most vibrant community on the Ethereum blockchain. Join us, as we make history with humor, one meme at a time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xa00453052a36d43a99ac1ca145dfe4a952ca33b8_8151b877bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

