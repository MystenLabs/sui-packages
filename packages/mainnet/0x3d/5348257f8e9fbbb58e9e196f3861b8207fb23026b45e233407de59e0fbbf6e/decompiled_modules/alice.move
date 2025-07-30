module 0x3d5348257f8e9fbbb58e9e196f3861b8207fb23026b45e233407de59e0fbbf6e::alice {
    struct ALICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALICE>(arg0, 6, b"ALICE", b"ALICE GAMES", b"Crafting unforgettable gaming experiences!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifx6s7aqkhjijpa5itk7e26o3nmji5hb2ajzx6ahro2ku2envdcwe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALICE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

