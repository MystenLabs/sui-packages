module 0x11461c4c04384d13b5ab787ebac3fb063f9d5df6ee63d133e96b79edaf24c744::steamm_airdropper {
    struct AirdropEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun airdrop<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        0x1::vector::reverse<u64>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            v0 = v0 + 0x1::vector::pop_back<u64>(&mut arg2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg2);
        assert!(0x2::coin::value<T0>(&arg0) == v0, 1);
        0x1::vector::reverse<u64>(&mut arg2);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 13906834277422596095);
        0x1::vector::reverse<address>(&mut arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, 0x1::vector::pop_back<u64>(&mut arg2), arg3), 0x1::vector::pop_back<address>(&mut arg1));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
        0x1::vector::destroy_empty<u64>(arg2);
        0x2::coin::destroy_zero<T0>(arg0);
        let v3 = AirdropEvent{
            coin_type : 0x1::type_name::get<T0>(),
            amount    : v0,
        };
        0x2::event::emit<AirdropEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

