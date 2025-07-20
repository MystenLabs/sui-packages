module 0x9a5306a0534433da89beb17e65df68159dffbf17f07dbe1fe9dfd68726cee48b::sonek {
    struct SONEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONEK>(arg0, 6, b"SONEK", b"Sonek Sui", x"41424f555420534f4e454b0a536f6e656b202069732061206d656d65636f696e206275696c74206f6e207468652053756920626c6f636b636861696e2c2064657369676e656420746f20656e7465727461696e20616e6420636f6e6e6563742074686520676c6f62616c2063727970746f20636f6d6d756e6974792e20536f6e656b20436f696e20636f6d62696e65732068756d6f722c20637265617469766974792c20616e6420616476616e63656420746563686e6f6c6f67792066726f6d20746865205375692065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiet4iaomwsxb5ytlatxmfilluzyng5gsj37dtk6iz3z5edn6vqcqq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SONEK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

