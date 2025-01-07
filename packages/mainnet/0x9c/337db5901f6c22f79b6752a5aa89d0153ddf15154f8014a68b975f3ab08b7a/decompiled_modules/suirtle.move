module 0x9c337db5901f6c22f79b6752a5aa89d0153ddf15154f8014a68b975f3ab08b7a::suirtle {
    struct SUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRTLE>(arg0, 6, b"SUIRTLE", b"SUIRTLE ON SUI", x"54484953204f4646494349414c202453554952544c450a0a53756972746c652c20746865206c6f79616c20616e6420656e657267657469632063727970746f2067756964652c206865726520746f206c65616420796f75207468726f7567682074686520626c6f636b636861696e20776f726c6421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0881_e1e226d2cd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

