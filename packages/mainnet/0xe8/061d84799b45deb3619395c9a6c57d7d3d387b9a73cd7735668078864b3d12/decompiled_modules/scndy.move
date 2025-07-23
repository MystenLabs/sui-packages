module 0xe8061d84799b45deb3619395c9a6c57d7d3d387b9a73cd7735668078864b3d12::scndy {
    struct SCNDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCNDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCNDY>(arg0, 6, b"SCNDY", b"Sui Candy", b"The rare candy of $Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiei325a42fffe24z3b4kc4r7jpu2qg2dhwvr7dvtix5inphjpsjt4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCNDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCNDY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

