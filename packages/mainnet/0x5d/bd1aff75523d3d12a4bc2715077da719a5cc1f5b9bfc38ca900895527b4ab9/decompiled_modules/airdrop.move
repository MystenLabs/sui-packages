module 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::airdrop {
    struct TypusAirdropRegistry has key {
        id: 0x2::object::UID,
    }

    struct AirdropInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        airdrops: 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::BigVector,
    }

    struct Airdrop has drop, store {
        user: address,
        value: u64,
    }

    struct SetAirdropEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        key: 0x1::ascii::String,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct RemoveAirdropEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        key: 0x1::ascii::String,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct ClaimAirdropEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        key: 0x1::ascii::String,
        user: address,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    public fun claim_airdrop<T0>(arg0: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::Version, arg1: &mut TypusAirdropRegistry, arg2: 0x1::ascii::String, arg3: &0x2::tx_context::TxContext) : 0x1::option::Option<0x2::balance::Balance<T0>> {
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::version_check(arg0);
        if (!0x2::dynamic_field::exists_with_type<0x1::ascii::String, AirdropInfo<T0>>(&arg1.id, arg2)) {
            abort 1
        };
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, AirdropInfo<T0>>(&mut arg1.id, arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::length(&v0.airdrops);
        let v3 = (0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::slice_size(&v0.airdrops) as u64);
        let v4 = 0;
        let v5 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::borrow_slice_mut<Airdrop>(&mut v0.airdrops, v4);
        let v6 = v5;
        let v7 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::get_slice_length<Airdrop>(v5);
        let v8 = 0;
        while (v8 < v2) {
            let v9 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::borrow_from_slice_mut<Airdrop>(v6, v8 % v3);
            if (v9.user == v1) {
                let v10 = 0x1::vector::empty<u64>();
                0x1::vector::push_back<u64>(&mut v10, v9.value);
                let v11 = ClaimAirdropEvent{
                    token       : 0x1::type_name::get<T0>(),
                    key         : arg2,
                    user        : v1,
                    log         : v10,
                    bcs_padding : vector[],
                };
                0x2::event::emit<ClaimAirdropEvent>(v11);
                v9.value = 0;
                return 0x1::option::some<0x2::balance::Balance<T0>>(0x2::balance::split<T0>(&mut v0.balance, v9.value))
            };
            if (v8 + 1 < v2 && v8 + 1 == v4 * v3 + v7) {
                let v12 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::get_slice_idx<Airdrop>(v6) + 1;
                v4 = v12;
                let v13 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::borrow_slice_mut<Airdrop>(&mut v0.airdrops, v12);
                v6 = v13;
                v7 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::get_slice_length<Airdrop>(v13);
            };
            v8 = v8 + 1;
        };
        0x1::option::none<0x2::balance::Balance<T0>>()
    }

    public fun claim_airdrop_by_index<T0>(arg0: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::Version, arg1: &mut TypusAirdropRegistry, arg2: 0x1::ascii::String, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x1::option::Option<0x2::balance::Balance<T0>> {
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::version_check(arg0);
        if (!0x2::dynamic_field::exists_with_type<0x1::ascii::String, AirdropInfo<T0>>(&arg1.id, arg2)) {
            abort 1
        };
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, AirdropInfo<T0>>(&mut arg1.id, arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::borrow_mut<Airdrop>(&mut v0.airdrops, arg3);
        if (v2.user == v1) {
            let v3 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v3, v2.value);
            let v4 = ClaimAirdropEvent{
                token       : 0x1::type_name::get<T0>(),
                key         : arg2,
                user        : v1,
                log         : v3,
                bcs_padding : vector[],
            };
            0x2::event::emit<ClaimAirdropEvent>(v4);
            v2.value = 0;
            return 0x1::option::some<0x2::balance::Balance<T0>>(0x2::balance::split<T0>(&mut v0.balance, v2.value))
        };
        0x1::option::none<0x2::balance::Balance<T0>>()
    }

    public(friend) fun get_airdrop<T0>(arg0: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::Version, arg1: &TypusAirdropRegistry, arg2: 0x1::ascii::String, arg3: address) : vector<u64> {
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::version_check(arg0);
        if (!0x2::dynamic_field::exists_with_type<0x1::ascii::String, AirdropInfo<T0>>(&arg1.id, arg2)) {
            abort 1
        };
        let v0 = 0x2::dynamic_field::borrow<0x1::ascii::String, AirdropInfo<T0>>(&arg1.id, arg2);
        let v1 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::length(&v0.airdrops);
        let v2 = (0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::slice_size(&v0.airdrops) as u64);
        let v3 = 0;
        let v4 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::borrow_slice<Airdrop>(&v0.airdrops, v3);
        let v5 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::get_slice_length<Airdrop>(v4);
        let v6 = 0;
        while (v6 < v1) {
            let v7 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::borrow_from_slice<Airdrop>(v4, v6 % v2);
            if (v7.user == arg3) {
                let v8 = 0x1::vector::empty<u64>();
                let v9 = &mut v8;
                0x1::vector::push_back<u64>(v9, v6);
                0x1::vector::push_back<u64>(v9, v7.value);
                return v8
            };
            if (v6 + 1 < v1 && v6 + 1 == v3 * v2 + v5) {
                let v10 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::get_slice_idx<Airdrop>(v4) + 1;
                v3 = v10;
                let v11 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::borrow_slice<Airdrop>(&v0.airdrops, v10);
                v4 = v11;
                v5 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::get_slice_length<Airdrop>(v11);
            };
            v6 = v6 + 1;
        };
        vector[0, 0]
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TypusAirdropRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<TypusAirdropRegistry>(v0);
    }

    public fun remove_airdrop<T0>(arg0: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::Version, arg1: &mut TypusAirdropRegistry, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::verify(arg0, arg3);
        let AirdropInfo {
            id       : v0,
            balance  : v1,
            airdrops : v2,
        } = 0x2::dynamic_field::remove<0x1::ascii::String, AirdropInfo<T0>>(&mut arg1.id, arg2);
        let v3 = v1;
        0x2::object::delete(v0);
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::drop<Airdrop>(v2);
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::balance::value<T0>(&v3));
        let v5 = RemoveAirdropEvent{
            token       : 0x1::type_name::get<T0>(),
            key         : arg2,
            log         : v4,
            bcs_padding : vector[],
        };
        0x2::event::emit<RemoveAirdropEvent>(v5);
        v3
    }

    public fun set_airdrop<T0>(arg0: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::Version, arg1: &mut TypusAirdropRegistry, arg2: 0x1::ascii::String, arg3: vector<0x2::coin::Coin<T0>>, arg4: vector<address>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::verify(arg0, arg6);
        assert!(0x1::vector::length<address>(&arg4) == 0x1::vector::length<u64>(&arg5), 1);
        let v0 = 0;
        let v1 = if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg1.id, arg2)) {
            0x2::dynamic_field::remove<0x1::ascii::String, AirdropInfo<T0>>(&mut arg1.id, arg2)
        } else {
            AirdropInfo<T0>{id: 0x2::object::new(arg6), balance: 0x2::balance::zero<T0>(), airdrops: 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::new<Airdrop>(2500, arg6)}
        };
        let v2 = v1;
        while (!0x1::vector::is_empty<address>(&arg4)) {
            let v3 = 0x1::vector::pop_back<u64>(&mut arg5);
            v0 = v0 + v3;
            let v4 = Airdrop{
                user  : 0x1::vector::pop_back<address>(&mut arg4),
                value : v3,
            };
            0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::big_vector::push_back<Airdrop>(&mut v2.airdrops, v4);
        };
        let v5 = 0x2::balance::value<T0>(&v2.balance);
        let v6 = 0;
        if (v5 < v0) {
            let v7 = v0 - v5;
            let v8 = v7;
            v6 = v7;
            while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg3)) {
                if (v8 > 0) {
                    let v9 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3);
                    if (0x2::coin::value<T0>(&v9) > v8) {
                        0x2::balance::join<T0>(&mut v2.balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut v9), v8));
                        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg3, v9);
                        v8 = 0;
                        break
                    };
                    v8 = v8 - 0x2::coin::value<T0>(&v9);
                    0x2::balance::join<T0>(&mut v2.balance, 0x2::coin::into_balance<T0>(v9));
                } else {
                    break
                };
            };
            assert!(v8 == 0, 0);
        };
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::utility::transfer_coins<T0>(arg3, 0x2::tx_context::sender(arg6));
        0x2::dynamic_field::add<0x1::ascii::String, AirdropInfo<T0>>(&mut arg1.id, arg2, v2);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = &mut v10;
        0x1::vector::push_back<u64>(v11, v0);
        0x1::vector::push_back<u64>(v11, v6);
        let v12 = SetAirdropEvent{
            token       : 0x1::type_name::get<T0>(),
            key         : arg2,
            log         : v10,
            bcs_padding : vector[],
        };
        0x2::event::emit<SetAirdropEvent>(v12);
    }

    // decompiled from Move bytecode v6
}

