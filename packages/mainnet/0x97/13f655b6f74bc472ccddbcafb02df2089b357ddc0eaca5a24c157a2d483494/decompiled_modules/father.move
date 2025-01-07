module 0x9713f655b6f74bc472ccddbcafb02df2089b357ddc0eaca5a24c157a2d483494::father {
    struct FATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATHER>(arg0, 6, b"FATHER", b"Sui Father", b"Sui Father is the wise and strong leader of the Sui world. Like a protective dad, he watches over everyone, guiding them on their journey through Sui. A coin with power and authority, its time to follow the father figure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Father_1_5d8576770e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

