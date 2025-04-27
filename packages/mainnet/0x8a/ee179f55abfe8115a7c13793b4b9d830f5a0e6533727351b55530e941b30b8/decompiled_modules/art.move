module 0x8aee179f55abfe8115a7c13793b4b9d830f5a0e6533727351b55530e941b30b8::art {
    struct ART has drop {
        dummy_field: bool,
    }

    fun init(arg0: ART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ART>(arg0, 9, b"Art", b"Artcoin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRz297RoXCTGcoMRQNzE9WataWRUPhSqnzXj4F1w8p1mX")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ART>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ART>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ART>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

