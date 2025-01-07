module 0x25e8c473bc20ecec1790c30508672f1a4dd44e0b880e1e9761c41930d78e47ed::chillsanta {
    struct CHILLSANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSANTA>(arg0, 6, b"CHILLSANTA", b"ChillSanta on SUI", b"Chill Santa for Christmas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vs_S_Nfh3_U_400x400_1dbed26627.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLSANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLSANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

