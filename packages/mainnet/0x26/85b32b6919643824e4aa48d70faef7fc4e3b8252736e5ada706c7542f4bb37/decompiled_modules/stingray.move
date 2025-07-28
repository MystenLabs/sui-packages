module 0x2685b32b6919643824e4aa48d70faef7fc4e3b8252736e5ada706c7542f4bb37::stingray {
    struct STINGRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STINGRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STINGRAY>(arg0, 6, b"STINGRAY", b"Stingray Agents", b"Unveiling crypto`s hidden gems with clean blockchain data and signals.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifbuukelrkn7qum5dqpimp7saib2pzw3ljz5tkzna3x3d4crup3ge")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STINGRAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STINGRAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

