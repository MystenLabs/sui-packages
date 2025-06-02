module 0x25f769dbdd756b1448f0555e6990273a8c44790c331a9221d3b96a2c79cf9ab0::suirfing {
    struct SUIRFING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRFING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRFING>(arg0, 6, b"SUIRFING", b"Suirfinguin", x"41206d656d652070656e6775696e2073757266696e6720746865207761766573206f66205375692e2053757266732075702c20616e6420736f20697320245355495246494e472e2052696465207468652077617665206f72206765742077697065642e0a506f7765726564206279206d656d65732c206675656c6564206279204d6f6f6e626167732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigzivsl436d5yb3maisax4gnnkl7o2gcm6c5qw36v2kvlxbivk3em")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRFING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRFING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

