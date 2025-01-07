module 0x646da973e21d46064d70dc70c8bbe3a2b220edb5365d8e6301c852cee62ae3de::raky {
    struct RAKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAKY>(arg0, 6, b"RAKY", b"Raky Sui", b"Raky isn't just a memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/raki_sui_b238950f32.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

