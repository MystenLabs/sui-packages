module 0x2c1fa6fefe7f702e62847768b5a7f479dd50221c255456027da3fbe8f63c18ef::cat2o {
    struct CAT2O has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT2O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT2O>(arg0, 6, b"CAT2O", b"cat2o", b"Most Famous Telegram official sticker pack Cat2o now on SUI. Unofficial cat mascot of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0503_dc9528dbef.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT2O>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT2O>>(v1);
    }

    // decompiled from Move bytecode v6
}

