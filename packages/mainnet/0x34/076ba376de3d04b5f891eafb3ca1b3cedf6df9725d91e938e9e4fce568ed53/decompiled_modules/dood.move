module 0x34076ba376de3d04b5f891eafb3ca1b3cedf6df9725d91e938e9e4fce568ed53::dood {
    struct DOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOD>(arg0, 6, b"Dood", b"Doodler", b"Doodler on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigjks4yaj2icgmo3p6qwrhplooyj2cnj5tlefk6z53lpcfl6yov4a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOOD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

