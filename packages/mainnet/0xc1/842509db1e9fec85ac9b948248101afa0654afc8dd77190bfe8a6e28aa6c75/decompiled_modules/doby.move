module 0xc1842509db1e9fec85ac9b948248101afa0654afc8dd77190bfe8a6e28aa6c75::doby {
    struct DOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBY>(arg0, 6, b"DOBY", b"Sui Doby", x"24444f425920486527732074686520756c74696d6174652069636f6e2065766572796f6e6520647265616d73206f66206265636f6d696e6720616e6420746865206e657874206d6173636f74206f6620535549210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/goby_98a6e404e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

