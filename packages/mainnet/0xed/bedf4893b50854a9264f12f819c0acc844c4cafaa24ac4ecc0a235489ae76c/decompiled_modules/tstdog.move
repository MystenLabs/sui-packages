module 0xedbedf4893b50854a9264f12f819c0acc844c4cafaa24ac4ecc0a235489ae76c::tstdog {
    struct TSTDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTDOG>(arg0, 6, b"TSTDOG", b"TSTDOG Token", b"Fake coin dont buy more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

