module 0xcaea6dbb6adfcad24e734d44cdf9575e6505dfb82476c9da00aa2cd13ba0e983::donky {
    struct DONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKY>(arg0, 6, b"DONKY", b"Donky on Sui", b"It's a memecoin and the most famous playable at all time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/donky_a6d188a57d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

