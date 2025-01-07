module 0x319318b1fe0c341e0d669a8dcbf854d3869008b8b3e1460bcbc8cb5dc78499f6::fengsui {
    struct FENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENGSUI>(arg0, 6, b"FENGSUI", b"FENG SUI", b"Feng Sui is an ancient Chinese practice that arranges spaces to allow good energy, or \"Qi,\" to flow freely. It aims to bring balance, peace, and positive outcomes like health and success into your life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_360a9b2dee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

