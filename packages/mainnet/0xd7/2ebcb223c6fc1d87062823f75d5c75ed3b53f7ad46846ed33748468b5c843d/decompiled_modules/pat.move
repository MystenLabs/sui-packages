module 0xd72ebcb223c6fc1d87062823f75d5c75ed3b53f7ad46846ed33748468b5c843d::pat {
    struct PAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAT>(arg0, 9, b"PAT", b"Pepe's Cat", x"4d65657420504154202d2050657065e2809973204361742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTZ3MN2UcZCgcEiX3DHpw5u5n5GPzdFJbQezJdiPTcyui")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

