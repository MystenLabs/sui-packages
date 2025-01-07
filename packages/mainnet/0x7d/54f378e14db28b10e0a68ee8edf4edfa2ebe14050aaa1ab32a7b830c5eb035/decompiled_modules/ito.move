module 0x7d54f378e14db28b10e0a68ee8edf4edfa2ebe14050aaa1ab32a7b830c5eb035::ito {
    struct ITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITO>(arg0, 6, b"ITO", b"ITSUI", b"you are scared?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ito_d3a9f2aa44.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

