module 0xb0b941e7f3e7d2343d94c83d75bebe51c38ed8330b70aca051737da76acd2d7a::spx6900 {
    struct SPX6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX6900>(arg0, 6, b"SPX6900", b"SPX6900 ON SUI", b"$SPX6900: FLIPPING THE STOCK MARKET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6siva_o_U_400x400_e409ac014d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPX6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

