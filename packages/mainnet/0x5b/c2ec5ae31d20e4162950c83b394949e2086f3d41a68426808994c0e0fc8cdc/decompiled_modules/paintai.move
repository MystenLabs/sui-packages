module 0x5bc2ec5ae31d20e4162950c83b394949e2086f3d41a68426808994c0e0fc8cdc::paintai {
    struct PAINTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAINTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAINTAI>(arg0, 6, b"PAINTAI", b"The Dog Paint Ai", b"Dog paintai is a color that will be beautiful and grateful in the sui ecosystem community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048627_b55589b065.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAINTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAINTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

