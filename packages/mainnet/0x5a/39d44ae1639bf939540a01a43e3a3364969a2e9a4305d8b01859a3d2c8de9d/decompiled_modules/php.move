module 0x5a39d44ae1639bf939540a01a43e3a3364969a2e9a4305d8b01859a3d2c8de9d::php {
    struct PHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHP>(arg0, 6, b"PHP", b"Paper Hands Pepe", x"4869212049742773206d652c20506570652e0a4920686176652050617065722048616e647321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepepaper3_581ea92433.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHP>>(v1);
    }

    // decompiled from Move bytecode v6
}

