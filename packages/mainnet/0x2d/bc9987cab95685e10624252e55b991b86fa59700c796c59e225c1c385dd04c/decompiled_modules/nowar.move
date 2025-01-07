module 0x2dbc9987cab95685e10624252e55b991b86fa59700c796c59e225c1c385dd04c::nowar {
    struct NOWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOWAR>(arg0, 6, b"NOWAR", b"WE WANT NO WAR", x"244e4f574152206973206d6f7265207468616e206a75737420612063727970746f20746f6b656e3b20697427732074686520696e737472756d656e742074686174206675656c73207468652057452057414e54204e4f2057415220636f6d6d756e6974792e0a0a44726976656e20616e6420676f7665726e6564207468726f756768206120666f727468636f6d696e6720446563656e7472616c697a6564204175746f6e6f6d6f7573204f7267616e697a6174696f6e202844414f292e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725121112984_af8298dcbe7f2a7e746cc4ba8eb58fb3_20d5aa3908.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOWAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOWAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

