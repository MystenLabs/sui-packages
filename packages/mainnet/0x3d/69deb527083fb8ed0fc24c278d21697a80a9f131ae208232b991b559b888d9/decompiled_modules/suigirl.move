module 0x3d69deb527083fb8ed0fc24c278d21697a80a9f131ae208232b991b559b888d9::suigirl {
    struct SUIGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGIRL>(arg0, 6, b"SUIGIRL", b"SUI GIRL", b"SUI GIRL borned in 2026. This is where it all began.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaq6c634pxlwifksfi35d7hiqcnt6ir4qh2s4xojq55udmqoix7ye")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGIRL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

