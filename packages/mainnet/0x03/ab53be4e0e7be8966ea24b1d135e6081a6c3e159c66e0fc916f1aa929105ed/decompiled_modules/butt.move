module 0x3ab53be4e0e7be8966ea24b1d135e6081a6c3e159c66e0fc916f1aa929105ed::butt {
    struct BUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTT>(arg0, 6, b"BUTT", b"BUTTCOIN", b"Why Spanish.. its butt not culo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig2mspgpshbm5df7mqm7ajofknswlwxxormhpqkthgyitufvjsnny")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

