module 0x2137fe2e9a330d8b65ad50778a5ec1df05ed96366a317c1b0245c09a4cf9ad3c::greenish {
    struct GREENISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREENISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREENISH>(arg0, 6, b"Greenish", b"Sui Greenish", b"Sui Greenish is the fresh breeze of the Sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sinvcdxbewtr345_t_A_tulo_1_5d058c040c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREENISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREENISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

