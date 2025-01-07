module 0x2b602f086e4af719ed3ef9243dc72e875bf62fcf3b3bba4c48f9b7b0681ae99e::jorgi {
    struct JORGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JORGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JORGI>(arg0, 6, b"JORGI", b"Jorgi on Sui", b"JORGI - The longest blackhead", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jorgi_e4bd4c07b2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JORGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JORGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

