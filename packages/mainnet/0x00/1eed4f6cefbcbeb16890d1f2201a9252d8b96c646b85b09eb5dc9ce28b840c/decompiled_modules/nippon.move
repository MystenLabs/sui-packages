module 0x1eed4f6cefbcbeb16890d1f2201a9252d8b96c646b85b09eb5dc9ce28b840c::nippon {
    struct NIPPON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIPPON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIPPON>(arg0, 6, b"NIPPON", b"NIKE PRO", b"NIKE + PORN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0c3e563de35b086918266d7d46da67af_b93adf0cda.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIPPON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIPPON>>(v1);
    }

    // decompiled from Move bytecode v6
}

