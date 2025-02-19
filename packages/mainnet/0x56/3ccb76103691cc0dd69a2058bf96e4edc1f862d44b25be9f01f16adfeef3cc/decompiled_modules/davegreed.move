module 0x563ccb76103691cc0dd69a2058bf96e4edc1f862d44b25be9f01f16adfeef3cc::davegreed {
    struct DAVEGREED has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVEGREED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAVEGREED>(arg0, 9, b"DAVEGREED", b"DAVE GREED PORTNOY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS771i9ABkG6esSgPUBdPsnbJW3dVRk3qcsAfuywrnx5Q")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAVEGREED>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAVEGREED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVEGREED>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

