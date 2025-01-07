module 0x70969c2941ec34f6dce844b1ce40d42e894485e30d55462de34761a52996ffca::garnet {
    struct GARNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARNET>(arg0, 6, b"GARNET", b"1.3 Steven Universe", b"3/100", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Steven_Universe_Garnet_icon_3_2a0df19575.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

