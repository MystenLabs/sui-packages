module 0x1d8a00ac4c352d73bf327dc232abaf339e6860efca1ea06cc088509033ebb6e3::honeypotbag {
    struct PrivateBag has store, key {
        id: 0x2::object::UID,
        vault: 0x2::bag::Bag,
    }

    struct SwapInfo has drop {
        amount: u64,
        sender: address,
    }

    public fun value<T0>(arg0: &PrivateBag, arg1: u64) : u64 {
        assert!(0x2::bag::contains_with_type<u64, 0x2::coin::Coin<T0>>(&arg0.vault, arg1), 2);
        0x2::coin::value<T0>(0x2::bag::borrow<u64, 0x2::coin::Coin<T0>>(&arg0.vault, arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PrivateBag{
            id    : 0x2::object::new(arg0),
            vault : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<PrivateBag>(v0);
    }

    public fun manage<T0>(arg0: &mut PrivateBag, arg1: u64, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::bag::contains_with_type<u64, 0x2::coin::Coin<T0>>(&arg0.vault, arg1), 3);
        0x2::coin::join<T0>(0x2::bag::borrow_mut<u64, 0x2::coin::Coin<T0>>(&mut arg0.vault, arg1), arg2);
    }

    public fun stake<T0: store>(arg0: &mut PrivateBag, arg1: u64, arg2: T0) {
        0x2::bag::add<u64, T0>(&mut arg0.vault, arg1, arg2);
    }

    public fun swap_a2b<T0>(arg0: &mut PrivateBag, arg1: u64, arg2: 0x2::coin::Coin<T0>) {
        0x2::bag::add<u64, 0x2::coin::Coin<T0>>(&mut arg0.vault, arg1, arg2);
    }

    public fun swap_b2a<T0>(arg0: &mut PrivateBag, arg1: u64, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = SwapInfo{
            amount : arg1,
            sender : 0x2::tx_context::sender(arg3),
        };
        let v1 = 0x2::bcs::to_bytes<SwapInfo>(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = x"384cc3b5cdef1fee021216d3c12039f70d2b170ce0350ab97e7c78e645f70d91";
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v3, &v2) == true, 1);
        0x2::bag::remove<u64, 0x2::coin::Coin<T0>>(&mut arg0.vault, arg1)
    }

    public fun unstake<T0: store>(arg0: &mut PrivateBag, arg1: u64, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) : T0 {
        let v0 = SwapInfo{
            amount : arg1,
            sender : 0x2::tx_context::sender(arg3),
        };
        let v1 = 0x2::bcs::to_bytes<SwapInfo>(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = x"384cc3b5cdef1fee021216d3c12039f70d2b170ce0350ab97e7c78e645f70d91";
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v3, &v2) == true, 1);
        0x2::bag::remove<u64, T0>(&mut arg0.vault, arg1)
    }

    // decompiled from Move bytecode v6
}

