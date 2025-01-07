module 0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::balance_pool {
    struct BalancePool has store, key {
        id: 0x2::object::UID,
        balance_infos: vector<BalanceInfo>,
        authority: 0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::Authority,
    }

    struct BalanceInfo has copy, drop, store {
        token: 0x1::type_name::TypeName,
        value: u64,
    }

    struct SharedBalancePool has store, key {
        id: 0x2::object::UID,
        balance_infos: vector<BalanceInfo>,
        authority: 0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::Authority,
    }

    public fun new(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) : BalancePool {
        BalancePool{
            id            : 0x2::object::new(arg1),
            balance_infos : 0x1::vector::empty<BalanceInfo>(),
            authority     : 0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::new(arg0, arg1),
        }
    }

    public fun authority(arg0: &BalancePool) : &0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::Authority {
        &arg0.authority
    }

    public fun add_authorized_user(arg0: &mut BalancePool, arg1: address) {
        0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::add_authorized_user(&mut arg0.authority, arg1);
    }

    public fun remove_authorized_user(arg0: &mut BalancePool, arg1: address) {
        0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::remove_authorized_user(&mut arg0.authority, arg1);
    }

    public fun add_shared_authorized_user(arg0: &mut BalancePool, arg1: vector<u8>, arg2: address) {
        0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::add_authorized_user(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, SharedBalancePool>(&mut arg0.id, arg1).authority, arg2);
    }

    public fun new_shared_balance_pool(arg0: &mut BalancePool, arg1: vector<u8>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::verify(&arg0.authority, arg3);
        let v0 = SharedBalancePool{
            id            : 0x2::object::new(arg3),
            balance_infos : 0x1::vector::empty<BalanceInfo>(),
            authority     : 0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::new(arg2, arg3),
        };
        0x2::dynamic_field::add<vector<u8>, SharedBalancePool>(&mut arg0.id, arg1, v0);
    }

    public fun put<T0>(arg0: &mut BalancePool, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<BalanceInfo>(&arg0.balance_infos)) {
            let v1 = 0x1::vector::borrow_mut<BalanceInfo>(&mut arg0.balance_infos, v0);
            if (v1.token == 0x1::type_name::get<T0>()) {
                v1.value = v1.value + 0x2::balance::value<T0>(&arg1);
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()), arg1);
                return
            };
            v0 = v0 + 1;
        };
        let v2 = BalanceInfo{
            token : 0x1::type_name::get<T0>(),
            value : 0x2::balance::value<T0>(&arg1),
        };
        0x1::vector::push_back<BalanceInfo>(&mut arg0.balance_infos, v2);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>(), arg1);
    }

    public fun put_shared<T0>(arg0: &mut BalancePool, arg1: vector<u8>, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, SharedBalancePool>(&mut arg0.id, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<BalanceInfo>(&v0.balance_infos)) {
            let v2 = 0x1::vector::borrow_mut<BalanceInfo>(&mut v0.balance_infos, v1);
            if (v2.token == 0x1::type_name::get<T0>()) {
                v2.value = v2.value + 0x2::balance::value<T0>(&arg2);
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>()), arg2);
                return
            };
            v1 = v1 + 1;
        };
        let v3 = BalanceInfo{
            token : 0x1::type_name::get<T0>(),
            value : 0x2::balance::value<T0>(&arg2),
        };
        0x1::vector::push_back<BalanceInfo>(&mut v0.balance_infos, v3);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>(), arg2);
    }

    public fun remove_shared_authorized_user(arg0: &mut BalancePool, arg1: vector<u8>, arg2: address) {
        0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::remove_authorized_user(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, SharedBalancePool>(&mut arg0.id, arg1).authority, arg2);
    }

    public fun send<T0>(arg0: &mut BalancePool, arg1: 0x1::option::Option<u64>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::verify(&arg0.authority, arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<BalanceInfo>(&arg0.balance_infos)) {
            let v1 = 0x1::vector::borrow_mut<BalanceInfo>(&mut arg0.balance_infos, v0);
            if (v1.token == 0x1::type_name::get<T0>()) {
                let v2 = 0x1::option::destroy_with_default<u64>(arg1, v1.value);
                v1.value = v1.value - v2;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()), v2), arg3), arg2);
                return v2
            };
            v0 = v0 + 1;
        };
        abort 0
    }

    public fun send_shared<T0>(arg0: &mut BalancePool, arg1: vector<u8>, arg2: 0x1::option::Option<u64>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, SharedBalancePool>(&mut arg0.id, arg1);
        0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::verify(&v0.authority, arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<BalanceInfo>(&v0.balance_infos)) {
            let v2 = 0x1::vector::borrow_mut<BalanceInfo>(&mut v0.balance_infos, v1);
            if (v2.token == 0x1::type_name::get<T0>()) {
                let v3 = 0x1::option::destroy_with_default<u64>(arg2, v2.value);
                v2.value = v2.value - v3;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>()), v3), arg4), arg3);
                return v3
            };
            v1 = v1 + 1;
        };
        abort 0
    }

    public fun shared_authority(arg0: &BalancePool, arg1: vector<u8>) : &0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::Authority {
        &0x2::dynamic_field::borrow<vector<u8>, SharedBalancePool>(&arg0.id, arg1).authority
    }

    public fun take<T0>(arg0: &mut BalancePool, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::verify(&arg0.authority, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<BalanceInfo>(&arg0.balance_infos)) {
            let v1 = 0x1::vector::borrow_mut<BalanceInfo>(&mut arg0.balance_infos, v0);
            if (v1.token == 0x1::type_name::get<T0>()) {
                let v2 = 0x1::option::destroy_with_default<u64>(arg1, v1.value);
                v1.value = v1.value - v2;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()), v2), arg2), 0x2::tx_context::sender(arg2));
                return v2
            };
            v0 = v0 + 1;
        };
        abort 0
    }

    public fun take_shared<T0>(arg0: &mut BalancePool, arg1: vector<u8>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, SharedBalancePool>(&mut arg0.id, arg1);
        0x56b6eba27e9aefb4a483cd55c90dae2a0124d1d9255ff7b1013ad77cd8a5f756::authority::verify(&v0.authority, arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<BalanceInfo>(&v0.balance_infos)) {
            let v2 = 0x1::vector::borrow_mut<BalanceInfo>(&mut v0.balance_infos, v1);
            if (v2.token == 0x1::type_name::get<T0>()) {
                let v3 = 0x1::option::destroy_with_default<u64>(arg2, v2.value);
                v2.value = v2.value - v3;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>()), v3), arg3), 0x2::tx_context::sender(arg3));
                return v3
            };
            v1 = v1 + 1;
        };
        abort 0
    }

    // decompiled from Move bytecode v6
}

