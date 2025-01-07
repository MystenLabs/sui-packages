module 0x602af137ec1d41dc366393f7499aa6313651277b63f5c80a263d4147c03eb1dc::dope {
    struct DOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPE>(arg0, 9, b"DOPE", b"DORA PEPE", b"A small, smiling blue frog wearing a rainbow hat with a spinning propeller on top, holding a four-bladed pinwheel, spreading joy and innocence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/657807ad-e564-4e42-b66c-3dbf391502c2-1000007431.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

