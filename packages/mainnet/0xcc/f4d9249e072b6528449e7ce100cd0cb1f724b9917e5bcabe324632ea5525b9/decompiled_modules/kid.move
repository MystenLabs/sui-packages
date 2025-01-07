module 0xccf4d9249e072b6528449e7ce100cd0cb1f724b9917e5bcabe324632ea5525b9::kid {
    struct KID has drop {
        dummy_field: bool,
    }

    fun init(arg0: KID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KID>(arg0, 6, b"KID", b"KID BENGALA", b"LETS GOOOO GUYS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Tl_H_Hs_D_Wc_AAW_Ud6_ddbd105a1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KID>>(v1);
    }

    // decompiled from Move bytecode v6
}

