module 0xfabc7f76deeef888f48263047665d1e4f74d0526be240d38ad7a7925d50b7e49::eric {
    struct ERIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERIC>(arg0, 9, b"Eric", b"EricCoin", b"A coin for Eric", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ERIC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERIC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

