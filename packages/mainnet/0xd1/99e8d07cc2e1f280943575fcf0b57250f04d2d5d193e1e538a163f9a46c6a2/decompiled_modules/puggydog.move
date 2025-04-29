module 0xd199e8d07cc2e1f280943575fcf0b57250f04d2d5d193e1e538a163f9a46c6a2::puggydog {
    struct PUGGYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGGYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGGYDOG>(arg0, 6, b"Puggydog", b"PuggyOnSui", b"Why buy meme coin ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiha3rxop4hqki5tlnansx3jetse7cx4wq7ak7sopnfnkr4bc43tni")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGGYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUGGYDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

