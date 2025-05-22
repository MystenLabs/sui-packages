module 0x8ad3bc9c0f5443da0cf991892b7f07c92d418d87f682e6c0e597c72952731dd4::peal {
    struct PEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEAL>(arg0, 6, b"PEAL", b"PEAL the SEAL", x"5365616c7320617265206b6e6f776e2061732074686520646f6773206f6620746865207365612c20736f204920677565737320796f752063616e20736179204920676f74207468617420646f6720696e206d65210a0a546865204c617267657374205365616c20576569676873204d6f7265205468616e20466f757220546f6e732c20746861742773206d7920756e636c652062757420686520736169642069276d20676f6e6e612062652062696767657220616e64207374726f6e676572207468656e2068696d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicfurdbgj5efjq2zgpkir4qf5yuay5iwashm6bx53muwuobcffifa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

