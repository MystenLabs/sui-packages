module 0x961e423c2ae4ae0c2c8d02c3fa4cb48f1ca54b30002470b31bcc288003ab1dbf::neww {
    struct NEWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWW>(arg0, 9, b"NEWW", b"NewwCoin", b"A new token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEWW>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

