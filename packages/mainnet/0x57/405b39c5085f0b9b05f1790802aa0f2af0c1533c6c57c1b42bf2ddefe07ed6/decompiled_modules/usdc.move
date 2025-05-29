module 0x57405b39c5085f0b9b05f1790802aa0f2af0c1533c6c57c1b42bf2ddefe07ed6::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 9, b"USDC", b"USD COIN", b"Buy this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a0f8bc295c89508e34c02daf08a43908blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

