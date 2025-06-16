module 0xa726c0301632722e080fdb0acfb044eacb4b6c0bd5be840564220a6b9702dcd1::dgf {
    struct DGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGF>(arg0, 6, b"DGF", b"dfdcc", b"dfgcvbc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaz3ljw6j52dnvawjg2b5jq4p6phd7vqdjn7yczx3y7zani4e6jgy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DGF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

