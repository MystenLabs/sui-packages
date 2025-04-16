module 0xa391be14688cf46d1184e282d16a33b43b3927c20a2ff94f25148c0ba3563890::geous {
    struct GEOUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEOUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEOUS>(arg0, 6, b"GEOUS", b"Geous Trader", b"Let's progress the community to win.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigt7khpbpv7j4mmlhqekvjqhvix5v75oy3xjkhh72itq4i32zcgmi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEOUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GEOUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

