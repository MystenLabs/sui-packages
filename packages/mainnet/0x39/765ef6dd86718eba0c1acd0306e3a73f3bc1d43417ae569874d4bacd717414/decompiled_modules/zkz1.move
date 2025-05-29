module 0x39765ef6dd86718eba0c1acd0306e3a73f3bc1d43417ae569874d4bacd717414::zkz1 {
    struct ZKZ1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZKZ1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZKZ1>(arg0, 6, b"ZKZ1", b"Zuckzilla ", x"4166746572206465766f7572696e6720746865206d6574617665727365732c204d61726b205a75636b657262657267206d75746174656420696e746f205a75636b7a696c6c6120e28094206120746f776572696e67206c697a6172642d6265696e672074686174206665656473206f6e206461746120616e64206c696b65732e204865206e6f77206f776e7320536f6c616e612c20736c65657073206f6e20426974636f696e2c20616e64206c69766573747265616d732068697320647265616d7320766961204e657572616c696e6b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748535064991.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZKZ1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZKZ1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

