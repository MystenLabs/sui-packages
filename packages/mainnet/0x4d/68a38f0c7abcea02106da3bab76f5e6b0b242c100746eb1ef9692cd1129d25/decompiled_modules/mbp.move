module 0x4d68a38f0c7abcea02106da3bab76f5e6b0b242c100746eb1ef9692cd1129d25::mbp {
    struct MBP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MBP>, arg1: 0x2::coin::Coin<MBP>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<MBP>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MBP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MBP>>(0x2::coin::mint<MBP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MBP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBP>(arg0, 9, b"MBP", b"ManBearPig", b"Half man. Half Bear. Half pig. ManBearPig.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbVsFA5AMd6UkeKCXyegJSy9YxpuWLcAXH5cjN4xD36fq?filename=MBP.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

