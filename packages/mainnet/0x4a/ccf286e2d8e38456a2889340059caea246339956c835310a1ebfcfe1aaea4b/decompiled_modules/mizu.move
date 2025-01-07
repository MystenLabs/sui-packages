module 0x4accf286e2d8e38456a2889340059caea246339956c835310a1ebfcfe1aaea4b::mizu {
    struct MIZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZU>(arg0, 6, b"MIZU", b"MIZUCOIN", b"Big things have small beginnings", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Coin_4159f4759f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

