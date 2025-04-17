module 0x6c067a69c11bcf637a42939c2434da2c403090cb0fe26614b832c898cb3a54e::fluffy {
    struct FLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFY>(arg0, 6, b"FLUFFY", b"MOON FLUFFY", x"54686520637574657374206d617273686d616c6c6f7720746f6b656e206f6e207468652053554920626c6f636b636861696e2e0a4f4720466c75666679206f66204d6f6f6e62616773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreighi4xf35anc2xcfpbg4yo35rhccqb2arxuqclbtxtzlt5kptikxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLUFFY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

