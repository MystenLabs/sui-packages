module 0x1f0d6c5f53b2096ab1abbfca02a2fde0f8707d62b234d780a007c7882ea733d2::fyre {
    struct FYRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYRE>(arg0, 6, b"FYRE", b"Fyre of Sui", x"412074696e7920244659524520666c616d65207769746820626f756e646c65737320616d626974696f6e2c20726561647920746f2069676e69746520746865206479696e6720537569205472656e63686573206261636b20746f206974277320676c6f72792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fyre_logo_f70b82b47a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FYRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

