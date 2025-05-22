module 0xb5dfd569892d182600ea6e1e3abf115080cc507ec2c0e97ec7b299e28bebee73::unicorn {
    struct UNICORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNICORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNICORN>(arg0, 6, b"Unicorn", b"Davi the unicorn", b"Davi the unicorn will change sui fate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigvqg3dk4tyemkeecicqko3bolx3fylu5y6t2rqcm734f7qvfe6sy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNICORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UNICORN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

