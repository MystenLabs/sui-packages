module 0xe685f2270f6caefb2fa354353921e9cda99008b3cd9d7fe09051156bf6d38652::bigbud {
    struct BIGBUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGBUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGBUD>(arg0, 6, b"BIGBUD", b"Big Bud", b"Good vibes only @ https://bigbudsmoke.shop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_15_200722_867392e667.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGBUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGBUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

