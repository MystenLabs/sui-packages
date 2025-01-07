module 0xe7fef2fb1f5c25de7e525971b67cf975cb6cd8d2a71a72975abb81a30d655150::suitoyota {
    struct SUITOYOTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOYOTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOYOTA>(arg0, 6, b"SuiToyota", b"Suiyota", b"Toyotas SUI KING ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1263_053a6cb2ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOYOTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOYOTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

