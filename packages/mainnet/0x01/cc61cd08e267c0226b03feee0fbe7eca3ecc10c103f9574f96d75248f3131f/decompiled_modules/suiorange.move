module 0x1cc61cd08e267c0226b03feee0fbe7eca3ecc10c103f9574f96d75248f3131f::suiorange {
    struct SUIORANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIORANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIORANGE>(arg0, 6, b"SUIORANGE", b"Orange on SUI", b"When life gives you another color, trade them for orange!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Orange_2e044e3c20.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIORANGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIORANGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

