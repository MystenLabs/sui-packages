module 0xc77f2b1ec6e5d63d861093b5618f3c25229ca39c5e95586ffbfa6621d3c615c3::rexhat {
    struct REXHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REXHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REXHAT>(arg0, 6, b"REXHAT", b"RexWifHat", x"2052657857696648617421202452455848415420686173206172726976656420746f2073746172742061206e65772065726120696e20746865206d656d652063727970746f206d61726b65742e0a466f726765742020446f6773202043617420616e64202046726f67732c2074686520726963686573742064696e6f7361757220696e207468652063727970746f20776f726c6420697320686572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1721982445970_ee3f8b923bbdfce5874c3b246dea7ec0_5f412f409c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REXHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REXHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

