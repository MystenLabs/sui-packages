module 0x1fa516aec7372f795c8c6c82161c2cadc10ef76fc08ef938e738c724dcdb70b4::bec {
    struct BEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEC>(arg0, 6, b"BEC", b"Blue emoji coin", b"Blue Emoji or Bluemoji is a custom set of stickers that consists of several dozen detailed blue-colored emoji. Starting in early 2021, emoji from the sticker pack achieved virality online as reaction images and as source material for memes, with the emoji eating a cookie and the emoji stifling a laugh with its hand gaining particular prevalence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053440_c1895561af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

