module 0xf996040a2b848db68ad905cebc69e70a848600d82ab63ac7b7cd0f1150f9c659::twiggy {
    struct TWIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIGGY>(arg0, 6, b"TWIGGY", b"TWIGGY on SUI", b"Just TWIGGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_LB_Vmi_Q6_400x400_8936fb8fba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

