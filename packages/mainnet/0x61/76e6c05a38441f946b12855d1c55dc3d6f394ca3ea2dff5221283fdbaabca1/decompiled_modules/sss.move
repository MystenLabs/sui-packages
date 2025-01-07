module 0x6176e6c05a38441f946b12855d1c55dc3d6f394ca3ea2dff5221283fdbaabca1::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 6, b"SSS", b"3S", b"This is the cutest cat in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E31_E7_ABE_A2_A6_4128_B6_E3_C157_AE_334_ED_6_8f6876363a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

