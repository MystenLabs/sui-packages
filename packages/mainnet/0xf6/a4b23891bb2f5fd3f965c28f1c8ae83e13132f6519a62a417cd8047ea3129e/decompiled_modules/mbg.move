module 0xf6a4b23891bb2f5fd3f965c28f1c8ae83e13132f6519a62a417cd8047ea3129e::mbg {
    struct MBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBG>(arg0, 6, b"MBG", b"Moonbag", b"Greatmoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifptrek63sg3dw3czhonddztxro43g5eo4hccswss2qqjvgiknkgq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

