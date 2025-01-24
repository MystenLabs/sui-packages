module 0x398692af13e3019d547989f4370095235cf07b84779abbb159b1796c012b4f52::toly {
    struct TOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOLY>(arg0, 9, b"Toly", b"Toly On Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNrD7NAQ3Ls3eYxFnRWKdGihnjPMFMKpTbuZsXDe3Gjqb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOLY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOLY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

