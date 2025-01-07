module 0x13650f0a42e6f7832caa1aaca2feada05a5cbfb4a4e5c3176af108283063b4f1::evoai {
    struct EVOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVOAI>(arg0, 6, b"EvoAI", b"Evo Ai Brain Computer Systems", b"Pioneering AI, we bridge the gap between brain-computer interface implants & human consciousness. Get ready for the next step in human evolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/VM_5xf_oo_400x400_86b7142499.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVOAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVOAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

