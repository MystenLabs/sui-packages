module 0x6701de86b4a2ccec812a9afc987fb2d112897558bd1ba90ffd998a15fd5cb84e::kkdc {
    struct KKDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKDC>(arg0, 9, b"KKDC", b"KKDC", b"KKDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeicvoounsnezrbuivnebsrndwslhnmrsehosovntt2wslsvynzpny4")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<KKDC>>(0x2::coin::mint<KKDC>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKDC>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

