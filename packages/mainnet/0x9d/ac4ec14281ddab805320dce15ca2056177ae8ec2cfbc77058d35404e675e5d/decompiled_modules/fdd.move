module 0x9dac4ec14281ddab805320dce15ca2056177ae8ec2cfbc77058d35404e675e5d::fdd {
    struct FDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDD>(arg0, 6, b"FDD", b"eeaeq", b"Everyone's favorite.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidyqax22ci5it63nng4gcnvk3ocvp7eeou4beoiy7vi34campwyzi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FDD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

