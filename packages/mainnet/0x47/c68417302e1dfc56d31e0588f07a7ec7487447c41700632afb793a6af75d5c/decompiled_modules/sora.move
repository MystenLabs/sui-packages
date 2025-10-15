module 0x47c68417302e1dfc56d31e0588f07a7ec7487447c41700632afb793a6af75d5c::sora {
    struct SORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORA>(arg0, 6, b"SORA", b"Sora Ai Sui", b"Sora Ai on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibyvurdkukvrh67ldmibvopwat5xykmzfqkv5fff4x5qqrckrdfme")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SORA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

