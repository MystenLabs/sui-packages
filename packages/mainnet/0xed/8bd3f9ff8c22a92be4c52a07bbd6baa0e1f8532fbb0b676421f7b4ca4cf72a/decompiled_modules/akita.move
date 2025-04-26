module 0xed8bd3f9ff8c22a92be4c52a07bbd6baa0e1f8532fbb0b676421f7b4ca4cf72a::akita {
    struct AKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKITA>(arg0, 6, b"AKITA", b"AKITA on SUI", b"Just a TICKER!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_T_12_Les_400x400_1_97b358d2fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

