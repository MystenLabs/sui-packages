module 0x7d01eb5c33d51fe1c2a2d7f26365a7302be513f02df22faf447aa709989458e6::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 6, b"GG", b"Meme Dot GG", x"736f6d657468696e6720697320636f6f6b696e6720f09fa791e2808df09f8db3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957367012.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

