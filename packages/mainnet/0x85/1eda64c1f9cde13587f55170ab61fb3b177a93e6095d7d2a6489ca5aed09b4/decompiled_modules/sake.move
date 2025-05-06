module 0x851eda64c1f9cde13587f55170ab61fb3b177a93e6095d7d2a6489ca5aed09b4::sake {
    struct SAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKE>(arg0, 6, b"Sake", b"sakura", b"poker time on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibsseiz3wqpipezi427xup4cbetgbm5sfaozqlwbrg4lpfju6bggu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

