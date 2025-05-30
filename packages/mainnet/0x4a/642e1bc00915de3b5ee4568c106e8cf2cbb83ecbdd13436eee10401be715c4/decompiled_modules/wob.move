module 0x4a642e1bc00915de3b5ee4568c106e8cf2cbb83ecbdd13436eee10401be715c4::wob {
    struct WOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOB>(arg0, 6, b"WOB", b"Pokewob", x"4a6f696e2074686520776f62626c652e205265666c65637420746865206368616f732e20436f756e74657220746f20746865206d6f6f6e210a0a54484520424c5545204c4547454e44204f4e2053554920424c4f434b434841494e2049532048455245", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5qvsog2wzqsxyaskqh4tflbj63yuziwcbi73bfmibz66h6e4tt4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

