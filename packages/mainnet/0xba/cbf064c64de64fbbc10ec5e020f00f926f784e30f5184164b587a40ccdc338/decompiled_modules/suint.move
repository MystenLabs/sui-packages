module 0xbacbf064c64de64fbbc10ec5e020f00f926f784e30f5184164b587a40ccdc338::suint {
    struct SUINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINT>(arg0, 6, b"Suint", b"SUINT ON SUI", b"Lets SUINT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_15_22_33_21_8cd74b854f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

