module 0x80357d1168682f3375bdf06ad25d8c41108bd0571d15c25a36d6a07ba1c0476::baloo {
    struct BALOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALOO>(arg0, 6, b"BALOO", b"SUIBALOO", b"BALOO global rebellion and lets own the fucking SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_084606_575_905855eab8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

