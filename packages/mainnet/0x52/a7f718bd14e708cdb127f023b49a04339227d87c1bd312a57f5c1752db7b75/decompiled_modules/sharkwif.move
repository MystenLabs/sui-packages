module 0x52a7f718bd14e708cdb127f023b49a04339227d87c1bd312a57f5c1752db7b75::sharkwif {
    struct SHARKWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKWIF>(arg0, 6, b"SharkWif", b"Shark Wif Hat", b"Shark Wif Hat is a community meme on the Sui Network, featuring an effective deflationary characteristics. The goal of Shark Wif Hat is to become the top meme on the Sui Network hits $1 BILLION. It's going to happen.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_500_878bee8fd8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

