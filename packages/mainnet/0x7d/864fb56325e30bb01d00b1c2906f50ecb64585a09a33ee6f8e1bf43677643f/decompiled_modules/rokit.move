module 0x7d864fb56325e30bb01d00b1c2906f50ecb64585a09a33ee6f8e1bf43677643f::rokit {
    struct ROKIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROKIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROKIT>(arg0, 6, b"ROKIT", b"Rocket Kitty", x"546865204b6f6f6c65737420726f636b6574206b69747479206f6e205375692e204772616220796f75722024524f4b495420616e6420737472617020696e20666f722074686520726964652c2062656361757365206e6578742073746f7020697320746865206d6f6f6e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rokit_logo_e781915143.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROKIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROKIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

