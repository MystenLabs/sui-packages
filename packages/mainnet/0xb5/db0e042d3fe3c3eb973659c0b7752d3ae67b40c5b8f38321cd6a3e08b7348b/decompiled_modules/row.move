module 0xb5db0e042d3fe3c3eb973659c0b7752d3ae67b40c5b8f38321cd6a3e08b7348b::row {
    struct ROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROW>(arg0, 6, b"ROW", b"ROW", b"Wow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreicplngsusrovql56e7wtsv4ahi7agite2ek3gtiwwmppftclo5bk4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROW>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROW>>(v2, @0xfe65cf3f401586ad76108d97b4a49fa382c3b16235f36e0fc972035b25414e9e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

