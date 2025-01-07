module 0x13e4c60f86c86cf24eca7921c81ffe0c9e40d45a2ff9b7695a060b6d09a497fe::king_neiro {
    struct KING_NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING_NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING_NEIRO>(arg0, 9, b"KING NEIRO", b"The King Neiro on Sui", b"The King Neiro  - The fun-loving meme king reigning supreme in the Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/x2z1mRN/Social-Template-1x1-39.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KING_NEIRO>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING_NEIRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KING_NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

