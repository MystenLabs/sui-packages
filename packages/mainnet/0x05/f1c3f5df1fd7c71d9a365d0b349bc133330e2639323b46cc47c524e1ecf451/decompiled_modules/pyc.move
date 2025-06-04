module 0x5f1c3f5df1fd7c71d9a365d0b349bc133330e2639323b46cc47c524e1ecf451::pyc {
    struct PYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYC>(arg0, 6, b"PYC", x"506f6bc3a96d6f6e20596163687420436c7562", b"All the Pokemon just pulled up to the Yacht Club looking based as hell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiev66xfutwnckill2uijyo77bms5ptwizbu4d6jb2cqvk7ohcgnx4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PYC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

