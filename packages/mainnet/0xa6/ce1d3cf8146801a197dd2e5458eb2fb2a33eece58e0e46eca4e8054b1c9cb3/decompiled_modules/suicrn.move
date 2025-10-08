module 0xa6ce1d3cf8146801a197dd2e5458eb2fb2a33eece58e0e46eca4e8054b1c9cb3::suicrn {
    struct SUICRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICRN>(arg0, 6, b"SUICRN", b"SUICORN", x"46697273742074686579206c617567680a5468656e2074686579206c6561726e0a5468656e207468657920464f4d4f0a2453554943524e20746865206d6f73742064616e6765726f7573206d656d65206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie6x7vq5x6dumg26jg62ozvqqujq3mlqj6qtsmb2hgxvxxiktmfs4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICRN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

