module 0x4a5eae6e2a16d1b582937bdb1b1e941f05a77253523eac8bc2a5fc5d6c1b09ea::psharky {
    struct PSHARKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSHARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSHARKY>(arg0, 6, b"PSHARKY", b"PEPE SHARKY", b"PEPE SHARKY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_11_03_08_9701578e4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSHARKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSHARKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

