module 0x93137d5c873cd4d1ac3119b45f2402937fac1fda69cb60c484d21c3002413dc4::meme_v4 {
    struct MEME_V4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_V4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_V4>(arg0, 9, b"MEME_V4", b"DonDieMeme", b"DontDieMeme is a brand new marketplace where you can stake Meme 3.0 , v4 & LP tokens for free Genesis NFTs and artworks, bid using Meme V4 to win 1/1 NFTs, Only accepts Meme V4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65409652-566b-414d-88f0-571885faaec2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_V4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_V4>>(v1);
    }

    // decompiled from Move bytecode v6
}

