module 0x6fe1e246e50910175521a5771612d79b3dbcad8dbdb4efa24c800319b5032781::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHI>(arg0, 6, b"SATOSHI", b"Peter Todd", b"SATOSHI IS PETER TODD.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tkn_0x04bb3879e6ff39f4d42f485fa3ff58f0083a572e23c7e73829f6dab021f1fb17_f2eeec18a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

