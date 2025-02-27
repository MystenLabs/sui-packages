module 0x74aac76c7e5b5d98b5a4b4a3cfeed6847fe9743a0004d687af03d2154fd5f2e3::defi {
    struct DEFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFI>(arg0, 9, b"DEFI", b"DeFi Token", b"Decentralized Finance Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

