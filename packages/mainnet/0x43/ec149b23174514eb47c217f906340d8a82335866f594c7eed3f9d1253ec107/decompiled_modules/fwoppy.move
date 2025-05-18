module 0x43ec149b23174514eb47c217f906340d8a82335866f594c7eed3f9d1253ec107::fwoppy {
    struct FWOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOPPY>(arg0, 6, b"FWOPPY", b"FWOPPY the FROG", b"might be something fwoppy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigzh463miej5fkug62ce22yogb32zin2ad2ra4okcxdhmxb6u76ua")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FWOPPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

