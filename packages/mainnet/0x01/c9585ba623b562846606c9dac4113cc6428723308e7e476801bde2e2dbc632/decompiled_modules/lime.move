module 0x1c9585ba623b562846606c9dac4113cc6428723308e7e476801bde2e2dbc632::lime {
    struct LIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIME>(arg0, 6, b"LIME", b"LIMEONSUI", x"4c696d65206f6e205375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lime_576143_1280_19aac80699.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

