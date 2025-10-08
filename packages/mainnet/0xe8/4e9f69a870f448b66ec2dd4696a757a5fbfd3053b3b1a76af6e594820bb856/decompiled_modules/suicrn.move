module 0xe84e9f69a870f448b66ec2dd4696a757a5fbfd3053b3b1a76af6e594820bb856::suicrn {
    struct SUICRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICRN>(arg0, 6, b"SUICRN", b"SUICORN", x"46697273742074686579206c61756768200a5468656e2074686579206c6561726e0a5468656e207468657920464f4d4f0a24535549434f524e20746865206d6f73742064616e6765726f7573206d656d65206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie6x7vq5x6dumg26jg62ozvqqujq3mlqj6qtsmb2hgxvxxiktmfs4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICRN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

