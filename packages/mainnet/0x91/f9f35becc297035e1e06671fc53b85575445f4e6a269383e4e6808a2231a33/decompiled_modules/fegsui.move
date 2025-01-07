module 0x91f9f35becc297035e1e06671fc53b85575445f4e6a269383e4e6808a2231a33::fegsui {
    struct FEGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEGSUI>(arg0, 6, b"Fegsui", b"FegSui", b"FEG (Feed Every Gorilla), one of the most recognized crypto meme tokens, is making its debut on the Sui Network! fegsui.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_113936_4696e79bab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

