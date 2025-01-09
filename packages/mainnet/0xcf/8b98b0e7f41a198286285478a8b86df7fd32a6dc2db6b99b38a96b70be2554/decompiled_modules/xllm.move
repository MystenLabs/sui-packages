module 0xcf8b98b0e7f41a198286285478a8b86df7fd32a6dc2db6b99b38a96b70be2554::xllm {
    struct XLLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: XLLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XLLM>(arg0, 9, b"XLLM", b"Extra Large Language Model", b"Extra Large Language Model Token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmer8VD5mgcEojEPgktZx5NeQjFMaMPWxznhN4iY122kW1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XLLM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XLLM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XLLM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

