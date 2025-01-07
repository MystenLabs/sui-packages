module 0x4c12e2b62a54e38def28799fd66657dc954caee3ac2606074272d323bb77662c::horris {
    struct HORRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORRIS>(arg0, 6, b"Horris", b"Kemala Horris", b"Vote For Za Democrazy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_5879_1b9c4464b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORRIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORRIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

