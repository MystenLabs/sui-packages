module 0x260fdc74d0a5b8ef20056d4f1d9c96840bb1a6a5149d3bdd9e615a965d3db94e::SIMBA {
    struct SIMBA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIMBA>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 9000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<SIMBA>>(0x2::coin::mint<SIMBA>(arg0, v0, arg2), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SIMBA>>(0x2::coin::mint<SIMBA>(arg0, calculate_tax(v0), arg2), 0x2::tx_context::sender(arg2));
    }

    fun calculate_tax(arg0: u64) : u64 {
        arg0 * 40 / 100
    }

    fun init(arg0: SIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMBA>(arg0, 6, b"SIMBA", b"", b"Join the movement and get the reward", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://interestprotocol.infura-ipfs.io/ipfs/QmcNYZn1urSEXBiZi2SiFzyeQcfNmTfHDU4kZLxhpCTRUK")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

