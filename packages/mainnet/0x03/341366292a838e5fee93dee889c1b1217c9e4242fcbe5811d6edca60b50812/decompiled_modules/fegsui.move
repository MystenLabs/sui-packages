module 0x3341366292a838e5fee93dee889c1b1217c9e4242fcbe5811d6edca60b50812::fegsui {
    struct FEGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEGSUI>(arg0, 6, b"FEGSUI", b"Feg Sui", b"Invest in FEG SUI The Future of Meme Tokens on Sui Network! Looking for the next big thing in crypto? FEG SUI combines the viral energy of meme tokens with the power and security of the Sui network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_2324e56504.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

