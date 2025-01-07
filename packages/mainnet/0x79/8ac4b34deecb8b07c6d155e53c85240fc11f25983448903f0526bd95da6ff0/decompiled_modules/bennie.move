module 0x798ac4b34deecb8b07c6d155e53c85240fc11f25983448903f0526bd95da6ff0::bennie {
    struct BENNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENNIE>(arg0, 6, b"Bennie", b"Bennie The Frenchie", b"A Meme Coin of Empowerment! $Bennie is all about accessing your highest potential and infinite paws-abilities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gfxq_i_Bb_QA_Ags0q_0c60ee68be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

