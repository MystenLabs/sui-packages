module 0xf252edbe8b03eee695a386e2bd63309225240dd59b2e21e2eaacd5623b722c19::b_sbusdt {
    struct B_SBUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SBUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SBUSDT>(arg0, 9, b"bsbUSDT", b"bToken sbUSDT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SBUSDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SBUSDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

