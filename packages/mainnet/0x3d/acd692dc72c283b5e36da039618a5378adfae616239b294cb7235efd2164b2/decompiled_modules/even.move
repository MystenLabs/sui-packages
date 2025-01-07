module 0x3dacd692dc72c283b5e36da039618a5378adfae616239b294cb7235efd2164b2::even {
    struct EVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVEN>(arg0, 6, b"EVEN", b"EVEN.SUI", b"cA-fauNdeR cEo of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EVEN_S_c8a24a2aea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

