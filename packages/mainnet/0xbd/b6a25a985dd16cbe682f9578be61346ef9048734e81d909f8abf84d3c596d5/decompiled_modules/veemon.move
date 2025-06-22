module 0xbdb6a25a985dd16cbe682f9578be61346ef9048734e81d909f8abf84d3c596d5::veemon {
    struct VEEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEEMON>(arg0, 6, b"VEEMON", b"SUIMON", b"The new mascot on SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicoustvmm64bf3bwdsfognuhdx3yf7xnovnxvcj5d3yasedo3o4ti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VEEMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

