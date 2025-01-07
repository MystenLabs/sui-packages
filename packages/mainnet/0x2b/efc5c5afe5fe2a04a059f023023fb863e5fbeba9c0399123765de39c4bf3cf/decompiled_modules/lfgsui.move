module 0x2befc5c5afe5fe2a04a059f023023fb863e5fbeba9c0399123765de39c4bf3cf::lfgsui {
    struct LFGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFGSUI>(arg0, 6, b"LFGSUI", b"MedicinalSuishi", b"Combat Veterans dealing with PTSD benefit from natural remedies of cannabis and love sushi. Let's build a strong community. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000961_f7edc5d648.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LFGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

