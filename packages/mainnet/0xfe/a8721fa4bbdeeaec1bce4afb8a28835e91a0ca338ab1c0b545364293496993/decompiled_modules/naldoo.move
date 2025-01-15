module 0xfea8721fa4bbdeeaec1bce4afb8a28835e91a0ca338ab1c0b545364293496993::naldoo {
    struct NALDOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NALDOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NALDOO>(arg0, 6, b"Naldoo", b"naldo", b"the naldo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cristiano_ronaldo_ai_voice_0c55379a18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NALDOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NALDOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

