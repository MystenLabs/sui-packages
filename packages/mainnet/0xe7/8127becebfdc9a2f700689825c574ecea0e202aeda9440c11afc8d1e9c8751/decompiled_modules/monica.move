module 0xe78127becebfdc9a2f700689825c574ecea0e202aeda9440c11afc8d1e9c8751::monica {
    struct MONICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONICA>(arg0, 9, b"MONICA", b"Monica", b"MONICA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYqUE28yPDj9kGerREgNwaexUbtTmbucQFqsQNWzcin81")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MONICA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONICA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONICA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

