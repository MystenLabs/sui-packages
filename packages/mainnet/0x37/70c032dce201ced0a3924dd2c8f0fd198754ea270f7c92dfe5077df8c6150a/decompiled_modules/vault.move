module 0x3770c032dce201ced0a3924dd2c8f0fd198754ea270f7c92dfe5077df8c6150a::vault {
    struct CoinType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct Promise<phantom T0> {
        final_coin_type: CoinType<T0>,
        guards: vector<0x2::object::ID>,
    }

    public fun after_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: Promise<T0>, arg2: vector<0xff0f43936e11679d05c4ae33be8620a2dc94b3ecb2f5b7eb1b667124921520dc::swap::HopGuard<T0, T0>>) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::string::utf8(b"vault::after_swap");
        0x1::debug::print<0x1::string::String>(&v0);
        let Promise {
            final_coin_type : _,
            guards          : v2,
        } = arg1;
        let v3 = v2;
        let v4 = &arg2;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xff0f43936e11679d05c4ae33be8620a2dc94b3ecb2f5b7eb1b667124921520dc::swap::HopGuard<T0, T0>>(v4)) {
            assert!(0xff0f43936e11679d05c4ae33be8620a2dc94b3ecb2f5b7eb1b667124921520dc::swap::hop_guard_id<T0, T0>(0x1::vector::borrow<0xff0f43936e11679d05c4ae33be8620a2dc94b3ecb2f5b7eb1b667124921520dc::swap::HopGuard<T0, T0>>(v4, v5)) == 0x1::vector::pop_back<0x2::object::ID>(&mut v3), 1);
            v5 = v5 + 1;
        };
        0xff0f43936e11679d05c4ae33be8620a2dc94b3ecb2f5b7eb1b667124921520dc::swap::after_swap<T0>(arg0, arg2)
    }

    public fun before_swap<T0, T1>(arg0: &mut Vault, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, vector<0xff0f43936e11679d05c4ae33be8620a2dc94b3ecb2f5b7eb1b667124921520dc::swap::HopGuard<T0, T1>>, Promise<T1>) {
        let v0 = 0x1::string::utf8(b"vault::before_swap");
        0x1::debug::print<0x1::string::String>(&v0);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v1 = CoinType<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v1);
        let v3 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v4 = &arg1;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(v4)) {
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v3, 0x2::coin::split<T0>(v2, *0x1::vector::borrow<u64>(v4, v5), arg2));
            v5 = v5 + 1;
        };
        let v6 = 0xff0f43936e11679d05c4ae33be8620a2dc94b3ecb2f5b7eb1b667124921520dc::swap::before_swap<T0, T1>(arg1, arg2);
        let v7 = &v6;
        let v8 = 0x1::vector::empty<0x2::object::ID>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<0xff0f43936e11679d05c4ae33be8620a2dc94b3ecb2f5b7eb1b667124921520dc::swap::HopGuard<T0, T1>>(v7)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v8, 0xff0f43936e11679d05c4ae33be8620a2dc94b3ecb2f5b7eb1b667124921520dc::swap::hop_guard_id<T0, T1>(0x1::vector::borrow<0xff0f43936e11679d05c4ae33be8620a2dc94b3ecb2f5b7eb1b667124921520dc::swap::HopGuard<T0, T1>>(v7, v9)));
            v9 = v9 + 1;
        };
        let v10 = CoinType<T1>{dummy_field: false};
        let v11 = Promise<T1>{
            final_coin_type : v10,
            guards          : v8,
        };
        (v3, v6, v11)
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinType<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinType<T0>>(&arg0.id, v0)) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0, arg1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    // decompiled from Move bytecode v6
}

