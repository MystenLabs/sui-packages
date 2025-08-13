module 0x6b2f3faee9da285bc989587b57c06160e4a2ee2f303721b69b32c0135ac52bac::vic {
    struct VIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIC>(arg0, 9, b"VIC", b"VICTOR NOVEL", b"asdasdasdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VIC>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIC>>(v2, @0xf129ff0022c360c932fb549dff4debb7285552dc737084268b57f9d26e06a3a3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

