module 0x3529824d5382d7f1bac0d9bf28b36cfbff3a19e108b694ccade5165e145ec4a1::trumpy {
    struct TRUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPY>(arg0, 6, b"TRUMPY", b"Trumpy", b"47th President of the United Smurfs of Amurica: strong, fearless, the best leader ever. Fighting for freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logotrumpy_2eabc38660.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

