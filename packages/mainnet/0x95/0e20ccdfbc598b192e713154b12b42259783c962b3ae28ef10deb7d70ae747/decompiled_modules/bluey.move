module 0x950e20ccdfbc598b192e713154b12b42259783c962b3ae28ef10deb7d70ae747::bluey {
    struct BLUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLUEY>(arg0, 6451535148975123531, b"BLU", b"BLUEY", b"Blue", b"https://images.hop.ag/ipfs/QmTwh8tbECzUndYffzjoPSXRHxC71JFmYsCZmvQsWHoFXa", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/blueyportalsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

