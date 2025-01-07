module 0x2ed909f54d7ae146c488d5d95cc473bae994a293c2a1f240569183c3aa42ed9e::chvn {
    struct CHVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHVN>(arg0, 6, b"CHVN", b"CryptoHaven", b"This platform seeks to create a more transparent, secure, and user-friendly environment for token creation, ultimately contributing to a more trustworthy cryptocurrency ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/312_1284da1620.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

