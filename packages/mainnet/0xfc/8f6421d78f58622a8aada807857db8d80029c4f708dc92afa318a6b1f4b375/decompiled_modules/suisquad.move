module 0xfc8f6421d78f58622a8aada807857db8d80029c4f708dc92afa318a6b1f4b375::suisquad {
    struct SUISQUAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISQUAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISQUAD>(arg0, 6, b"SUISQUAD", b"SUIcide Squad", b"In a chaotic, meme-fueled universe, a rogue squad of infamous meme coin charactersPepe, Wojak, Doge, Neiro, Andy, Myro, and Miladyunite for a high-stakes mission to save the crypto world. Each brings their unique quirks and powers, from Pepe's cunning to Doge's irresistible charm, as they navigate a web of digital villains and unpredictable market swings. Together, this unlikely team must outwit their foes and prove that even the wildest memes have real power when united forming the SUICIDE SQUAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_18_15_04_2_60afdf64d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISQUAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISQUAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

