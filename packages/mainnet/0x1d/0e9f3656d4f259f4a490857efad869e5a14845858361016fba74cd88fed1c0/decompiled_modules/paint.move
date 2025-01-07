module 0x1d0e9f3656d4f259f4a490857efad869e5a14845858361016fba74cd88fed1c0::paint {
    struct PAINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAINT>(arg0, 6, b"PAINT", b"Fewo World On Sui", b"Fewo World is the first Meme art project on Sui unlike anything you have seen in this space before...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_f5ab589cf2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

