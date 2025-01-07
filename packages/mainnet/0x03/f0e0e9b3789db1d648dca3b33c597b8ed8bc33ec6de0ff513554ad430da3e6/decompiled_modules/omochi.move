module 0x3f0e0e9b3789db1d648dca3b33c597b8ed8bc33ec6de0ff513554ad430da3e6::omochi {
    struct OMOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMOCHI>(arg0, 6, b"OMOCHI", b"SUIomochi", x"57616974696e6720666f72206120646970206f6e20746869732054696b746f6b2066726f6720246f6d6f6368690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240926145140_66a976b6b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

