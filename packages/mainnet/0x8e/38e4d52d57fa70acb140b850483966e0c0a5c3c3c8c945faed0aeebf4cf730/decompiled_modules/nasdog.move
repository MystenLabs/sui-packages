module 0x8e38e4d52d57fa70acb140b850483966e0c0a5c3c3c8c945faed0aeebf4cf730::nasdog {
    struct NASDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NASDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NASDOG>(arg0, 6, b"NASDOG", b"Nasdaq dog", b"the dog wif stocks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreichsm7yna2umz7mthuau2pehxzkxe5wqxykmq7zqn767gvlcyrkxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NASDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NASDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

