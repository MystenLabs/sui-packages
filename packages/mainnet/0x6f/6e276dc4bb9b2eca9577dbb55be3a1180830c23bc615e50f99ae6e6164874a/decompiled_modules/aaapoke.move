module 0x6f6e276dc4bb9b2eca9577dbb55be3a1180830c23bc615e50f99ae6e6164874a::aaapoke {
    struct AAAPOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPOKE>(arg0, 6, b"aaaPOKE", b"aaaPokeSui", x"43616e27742073746f702c20776f6e27742073746f702028207468696e6b696e672061626f75742053554929200a4c6574277320676f6f6f6f6f202020616161616161616161616161616161616161616161616161", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_bce588de6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAPOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

