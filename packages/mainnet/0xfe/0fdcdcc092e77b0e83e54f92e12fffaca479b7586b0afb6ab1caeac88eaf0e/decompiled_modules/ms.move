module 0xfe0fdcdcc092e77b0e83e54f92e12fffaca479b7586b0afb6ab1caeac88eaf0e::ms {
    struct MS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MS>(arg0, 6, b"MS", b"MoonScan", b"Making SUI as transparent as water. Scan smarter, Invest earlier", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiazg2raz6eq5w7u6oxncdltbckhtmtojtlpqzpyu6725kcf6vbpoq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

