module 0xd744ffb6d0293e0670bee5064445993529251ee4a377a2dd096eaa82928e3d03::hopi {
    struct HOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPI>(arg0, 6, b"HOPI", b"HOPI", x"4465736372697074696f6e3a205468652068696c6172696f75736c7920636c75656c65737320686970706f206f6e20537569f09fa69bf09f92ab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmQv4usd5eMQYMp93E5pASEWyQP9JCi7QM3bAaWhVfz4pn")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HOPI>>(0x2::coin::mint<HOPI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HOPI>>(v2);
    }

    // decompiled from Move bytecode v6
}

