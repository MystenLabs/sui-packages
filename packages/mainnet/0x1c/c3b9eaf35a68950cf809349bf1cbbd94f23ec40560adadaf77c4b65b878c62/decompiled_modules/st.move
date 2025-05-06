module 0x1cc3b9eaf35a68950cf809349bf1cbbd94f23ec40560adadaf77c4b65b878c62::st {
    struct ST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST>(arg0, 6, b"ST", b"sattoshi", b"What if sattoshi is a boy?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicdn7dozxzl5vd2psnucympmnuxwp7ughe4jityydi3cq7aqavala")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

