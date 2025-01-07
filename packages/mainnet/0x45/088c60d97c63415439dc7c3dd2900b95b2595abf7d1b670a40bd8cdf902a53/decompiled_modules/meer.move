module 0x45088c60d97c63415439dc7c3dd2900b95b2595abf7d1b670a40bd8cdf902a53::meer {
    struct MEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEER>(arg0, 6, b"Meer", b"Meerkat", b"The life story of these endangered cute meerkats. The Sui universe treats them badly and they want the bad situation to change.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_4_8344206094.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

