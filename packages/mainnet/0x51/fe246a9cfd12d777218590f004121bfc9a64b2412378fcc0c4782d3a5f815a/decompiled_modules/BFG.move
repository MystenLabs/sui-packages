module 0x51fe246a9cfd12d777218590f004121bfc9a64b2412378fcc0c4782d3a5f815a::BFG {
    struct BFG has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<BFG>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0x850e5c9080bf47e912f2644092f3b8e90419f282fe4a74e4e3ee78061056c745 || 0x2::tx_context::sender(arg2) == @0x850e5c9080bf47e912f2644092f3b8e90419f282fe4a74e4e3ee78061056c745, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<BFG>>(arg0, arg1);
    }

    fun init(arg0: BFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFG>(arg0, 9, b"BFG", b"Butt Fart Gang", b"The loudest memecoin on SUI. Powered by pure gas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tan-hidden-shark-534.mypinata.cloud/ipfs/bafybeifskwcyxxgkjmuhpiexx6dvlp5lmdnzstriai3osqx5ja373jvvqe")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BFG>>(0x2::coin::mint<BFG>(&mut v2, 1000000000000000000, arg1), @0x850e5c9080bf47e912f2644092f3b8e90419f282fe4a74e4e3ee78061056c745);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BFG>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

