module 0x6220d2ca2edc89f690a29ca35732d08b114efc9d5144d142e8a5f865a88ea163::devs {
    struct DEVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVS>(arg0, 9, b"DEVS", b"DEVANG", b"Just a cute guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXShNzYiLoQtD5yeqDqZdEBZaSaXRL2jd7UmTAGNWUt1g")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEVS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVS>>(v1);
    }

    // decompiled from Move bytecode v6
}

