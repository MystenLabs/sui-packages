module 0xd773b84ed2c7006bff1b60d4d99786965d6f7841c7db0858044a395a2de22cd4::suike {
    struct SUIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKE>(arg0, 6, b"SUIKE", b"SUIPONKE", b"First ponke on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000123754_4e5764b5f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

