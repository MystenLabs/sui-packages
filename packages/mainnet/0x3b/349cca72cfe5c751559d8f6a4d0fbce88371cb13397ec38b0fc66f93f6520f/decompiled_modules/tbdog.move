module 0x3b349cca72cfe5c751559d8f6a4d0fbce88371cb13397ec38b0fc66f93f6520f::tbdog {
    struct TBDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBDOG>(arg0, 6, b"TBDOG", b"The Bonneted Dog", b"Bonneted Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241010191613_f17402474b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

