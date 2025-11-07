module 0x2bdf78fa2ed0ab4af696ea8e14ba64967e677c652a2ebfcd845cc9e55f507a0c::vault {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct PositionVault has store, key {
        id: 0x2::object::UID,
        locked: bool,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (PositionVault, OwnerCap) {
        let v0 = PositionVault{
            id     : 0x2::object::new(arg0),
            locked : false,
        };
        let v1 = OwnerCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public fun collect_anyone<T0, T1>(arg0: &mut PositionVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, 0x2::dynamic_object_field::borrow_mut<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, 1), true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), @0xab27568feefb456705b788933db882d4830eca7259a66a0d49f8568b2bfda70d);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg3), @0xab27568feefb456705b788933db882d4830eca7259a66a0d49f8568b2bfda70d);
    }

    entry fun collect_anyone_entry<T0, T1>(arg0: &mut PositionVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        collect_anyone<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun collect_owner<T0, T1>(arg0: &OwnerCap, arg1: &mut PositionVault, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, 0x2::dynamic_object_field::borrow_mut<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.id, 1), true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg4), 0x2::tx_context::sender(arg4));
    }

    entry fun collect_owner_entry<T0, T1>(arg0: &OwnerCap, arg1: &mut PositionVault, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        collect_owner<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun deposit(arg0: &OwnerCap, arg1: &mut PositionVault, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.locked, 0);
        0x2::dynamic_object_field::add<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.id, 1, arg2);
    }

    entry fun deposit_entry(arg0: &OwnerCap, arg1: &mut PositionVault, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &mut 0x2::tx_context::TxContext) {
        deposit(arg0, arg1, arg2, arg3);
    }

    public fun lock(arg0: &OwnerCap, arg1: &mut PositionVault) {
        arg1.locked = true;
    }

    entry fun lock_entry(arg0: &OwnerCap, arg1: &mut PositionVault) {
        lock(arg0, arg1);
    }

    entry fun new_and_send(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg0);
        0x2::transfer::public_transfer<PositionVault>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun new_to(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg1);
        0x2::transfer::public_transfer<PositionVault>(v0, arg0);
        0x2::transfer::public_transfer<OwnerCap>(v1, arg0);
    }

    public fun withdraw(arg0: &OwnerCap, arg1: &mut PositionVault, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.locked, 2);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::dynamic_object_field::remove<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.id, 1), 0x2::tx_context::sender(arg2));
    }

    entry fun withdraw_entry(arg0: &OwnerCap, arg1: &mut PositionVault, arg2: &mut 0x2::tx_context::TxContext) {
        withdraw(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

