module 0xafa5cae74bbdece686522b0f9cc2f16beac73cc009ab3151e5435878a101d37d::kingdog {
    struct KINGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGDOG>(arg0, 6, b"KINGDOG", b"KINGDOG Token", b"KING KING KING dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KINGDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

