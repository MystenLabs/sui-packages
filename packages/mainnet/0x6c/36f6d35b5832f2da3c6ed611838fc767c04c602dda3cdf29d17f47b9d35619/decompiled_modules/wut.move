module 0x6c36f6d35b5832f2da3c6ed611838fc767c04c602dda3cdf29d17f47b9d35619::wut {
    struct WUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUT>(arg0, 6, b"WUT", b"Wut", b"Wut is an original wordplay memecoin. from the confused monkey meme, with an expression that seems to say \"Wut Da Fak\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731422493728.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

