module 0xd6cf0102c5e2a47a9eea3393f0249d96a2c3ad97fb3f59799bacdab3cf29856e::libra {
    struct LIBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIBRA>(arg0, 9, b"LIBRA", b"LIBRA ON SUI", b"As a symbol of this movement and in honor of Javier Milei's libertarian ideas the $LIBRA token is designed to strengthen the Argentine economy from the ground up by supporting entrepreneurship and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreihoa365hnkdahh5cmyjd5xtllria2gqik3m4g5undug5ystkoknby")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LIBRA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIBRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBRA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

