module 0xe114caa0d2e1786d4f51863fdcfef2fd8b71fab5428e204fda45a79c3ad9fcba::biao {
    struct BIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIAO>(arg0, 6, b"BIAO", b"Biao on Sui", b"BIAO ON SUI TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifct2wm3522i3cgsdjwxyaoxi7j7tlkcehkevt6s44pzc4r7v3gda")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BIAO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

