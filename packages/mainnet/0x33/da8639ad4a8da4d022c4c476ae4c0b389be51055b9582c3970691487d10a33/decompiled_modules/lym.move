module 0x33da8639ad4a8da4d022c4c476ae4c0b389be51055b9582c3970691487d10a33::lym {
    struct LYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LYM>(arg0, 6, b"LYM", b"ListYourMemes", b"ListYourMemes is a platform where users can upload and share their memes on Turbos.finance. Developed by Bjorn Louer from Vesse.nl, the project aims to combine meme culture with the SUI blockchain technology. Connect on Telegram at @teamvieze.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735978347779.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LYM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LYM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

