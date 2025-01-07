module 0x7bec4bf1d89b54da8622c888d681ac9a683f8a6755d6ea54c3e88d824c6b265d::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 6, b"PUMP", b"Sui Pump", b"PUMP is a pure Sui experiment aiming tackle one of the most fundamental value prop. The ability to have a \"fairly\" distributed supply to a list of decentralized onchain citizens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x216a5a1135a9dab49fa9ad865e0f22fe22b5630a_bd8e705f18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

