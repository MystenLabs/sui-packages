module 0x4fcc1e45a1b9d13b19fede41a65e23f4188535569524c451bd51dd050f4e8c3d::ryt {
    struct RYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYT>(arg0, 6, b"RYT", b"gkj", b"GHGFIUO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaa5zfxjrwqhim2w674kmbhbo6oxshzpct4zm34eusqxw3bgvkimu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RYT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

