module 0xaecb799f64f5d8f914ad66193a2d3979f5b9386cc4217761dba17ae176d2dc47::suikoko {
    struct SUIKOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKOKO>(arg0, 9, b"SuiKoko", b"Koko The Chimp", b"Introducing Koko the Chimp where the memes are minted and laughter thrives on  SUI Blockchain.Brace yourself for a meme  experience like never before with KOKO.  Website: https://suikoko.online Twitter: https://x.com/SuiKoKo_Sui Telegram: https://t.me/SuiKoko", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1728389390422-5a93c0a3ba84b3a1b88b00dcce9b3df6.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIKOKO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKOKO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

