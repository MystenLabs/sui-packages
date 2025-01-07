module 0x8a614f9f863edcb58792755baca15d139f0abe84e143a4bf7a4d919bb91752a6::fegsui {
    struct FEGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEGSUI>(arg0, 6, b"FEGSUI", b"FegSui", b"FEG (Feed Every Gorilla), one of the most recognized crypto meme tokens, is making its debut on the Sui Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000290_92df5b1942.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

