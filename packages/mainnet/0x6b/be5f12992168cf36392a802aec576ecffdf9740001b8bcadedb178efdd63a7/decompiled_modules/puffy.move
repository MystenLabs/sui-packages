module 0x6bbe5f12992168cf36392a802aec576ecffdf9740001b8bcadedb178efdd63a7::puffy {
    struct PUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFY>(arg0, 6, b"PUFFY", b"PUFFY SUI", b"$PUFFY is getting ready to make waves on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibmrejhr7eikrv2ogocpnhp3mxf6mc5tof3towuzzqankgubi3r6q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUFFY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

