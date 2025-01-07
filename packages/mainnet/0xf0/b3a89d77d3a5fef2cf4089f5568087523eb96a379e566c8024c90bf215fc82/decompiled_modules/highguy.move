module 0xf0b3a89d77d3a5fef2cf4089f5568087523eb96a379e566c8024c90bf215fc82::highguy {
    struct HIGHGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIGHGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIGHGUY>(arg0, 6, b"HIGHGUY", b"High Guy on SUI", x"4a7573742061202448494748204755590a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eqax_ZQ_Mc_400x400_c363a4bc30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIGHGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIGHGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

