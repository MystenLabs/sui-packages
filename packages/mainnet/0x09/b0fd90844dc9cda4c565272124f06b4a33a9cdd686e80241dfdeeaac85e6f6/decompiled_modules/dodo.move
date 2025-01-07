module 0x9b0fd90844dc9cda4c565272124f06b4a33a9cdd686e80241dfdeeaac85e6f6::dodo {
    struct DODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODO>(arg0, 6, b"DODO", b"DODO SUI", b"https://x.com/The__Solstice/status/1841171750433816710", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_0r_Td_TWEAA_Ef_M3_80b0a2fc1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

