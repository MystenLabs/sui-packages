module 0x7741c478a91176bd6ed6a112f09d48cb21131165e862cc45293949eb3c2c0ad4::receipt {
    struct ReceiptCreated has copy, drop {
        receipt_id: address,
        vault_id: address,
    }

    struct ReceiptUpdated has copy, drop {
        receipt_id: address,
        vault_id: address,
        new_reward: u64,
        unclaimed_reward: u64,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        vault_id: address,
        shares: u256,
        reward_indices: 0x2::table::Table<0x1::type_name::TypeName, u256>,
        unclaimed_rewards: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        last_deposit_ms: u64,
    }

    public(friend) fun add_share(arg0: &mut Receipt, arg1: u256) {
        arg0.shares = arg0.shares + arg1;
    }

    public(friend) fun burn_receipt(arg0: Receipt, arg1: vector<0x1::type_name::TypeName>) : address {
        let Receipt {
            id                : v0,
            vault_id          : _,
            shares            : v2,
            reward_indices    : v3,
            unclaimed_rewards : v4,
            last_deposit_ms   : _,
        } = arg0;
        let v6 = v4;
        let v7 = v0;
        assert!(v2 == 0, 1001);
        let v8 = 0x1::vector::length<0x1::type_name::TypeName>(&arg1);
        while (v8 > 0) {
            let v9 = 0;
            assert!(0x2::table::borrow<0x1::type_name::TypeName, u64>(&v6, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1, v8 - 1)) == &v9, 1002);
            v8 = v8 - 1;
        };
        0x2::object::delete(v7);
        0x2::table::drop<0x1::type_name::TypeName, u256>(v3);
        0x2::table::drop<0x1::type_name::TypeName, u64>(v6);
        0x2::object::uid_to_address(&v7)
    }

    public(friend) fun create_receipt(arg0: address, arg1: u256, arg2: 0x2::table::Table<0x1::type_name::TypeName, u256>, arg3: 0x2::table::Table<0x1::type_name::TypeName, u64>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Receipt {
        let v0 = Receipt{
            id                : 0x2::object::new(arg5),
            vault_id          : arg0,
            shares            : arg1,
            reward_indices    : arg2,
            unclaimed_rewards : arg3,
            last_deposit_ms   : arg4,
        };
        let v1 = ReceiptCreated{
            receipt_id : 0x2::object::uid_to_address(&v0.id),
            vault_id   : arg0,
        };
        0x2::event::emit<ReceiptCreated>(v1);
        v0
    }

    public(friend) fun decrease_share(arg0: &mut Receipt, arg1: u256) {
        arg0.shares = arg0.shares - arg1;
    }

    public fun get_receipt_reward(arg0: &Receipt, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.unclaimed_rewards, arg1)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.unclaimed_rewards, arg1)
        } else {
            0
        }
    }

    public fun get_receipt_rewards(arg0: &Receipt, arg1: vector<0x1::type_name::TypeName>) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::length<0x1::type_name::TypeName>(&arg1);
        while (v1 > 0) {
            0x1::vector::push_back<u64>(&mut v0, get_receipt_reward(arg0, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1, v1 - 1)));
            v1 = v1 - 1;
        };
        0x1::vector::reverse<u64>(&mut v0);
        v0
    }

    public fun last_deposit_ms(arg0: &Receipt) : u64 {
        arg0.last_deposit_ms
    }

    public fun receipt_id(arg0: &Receipt) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun reset_unclaimed_rewards<T0>(arg0: &mut Receipt) : u64 {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.unclaimed_rewards, 0x1::type_name::get<T0>());
        *v0 = 0;
        *v0
    }

    public(friend) fun reward_indices(arg0: &Receipt) : &0x2::table::Table<0x1::type_name::TypeName, u256> {
        &arg0.reward_indices
    }

    public(friend) fun reward_indices_mut(arg0: &mut Receipt) : &mut 0x2::table::Table<0x1::type_name::TypeName, u256> {
        &mut arg0.reward_indices
    }

    public(friend) fun set_last_deposit_ms(arg0: &mut Receipt, arg1: u64) {
        arg0.last_deposit_ms = arg1;
    }

    public fun shares(arg0: &Receipt) : u256 {
        arg0.shares
    }

    public(friend) fun unclaimed_rewards(arg0: &Receipt) : &0x2::table::Table<0x1::type_name::TypeName, u64> {
        &arg0.unclaimed_rewards
    }

    public(friend) fun unclaimed_rewards_mut(arg0: &mut Receipt) : &mut 0x2::table::Table<0x1::type_name::TypeName, u64> {
        &mut arg0.unclaimed_rewards
    }

    public(friend) fun update_reward(arg0: &mut Receipt, arg1: 0x1::type_name::TypeName, arg2: u256) : u64 {
        let v0 = &mut arg0.reward_indices;
        if (!0x2::table::contains<0x1::type_name::TypeName, u256>(v0, arg1)) {
            0x2::table::add<0x1::type_name::TypeName, u256>(v0, arg1, 0);
        };
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.unclaimed_rewards, arg1)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.unclaimed_rewards, arg1, 0);
        };
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u256>(v0, arg1);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.unclaimed_rewards, arg1);
        let v3 = (0x7741c478a91176bd6ed6a112f09d48cb21131165e862cc45293949eb3c2c0ad4::vault_utils::from_decimals(0x7741c478a91176bd6ed6a112f09d48cb21131165e862cc45293949eb3c2c0ad4::vault_utils::mul_d(arg2 - *v1, arg0.shares)) as u64);
        *v1 = arg2;
        *v2 = *v2 + v3;
        let v4 = ReceiptUpdated{
            receipt_id       : 0x2::object::uid_to_address(&arg0.id),
            vault_id         : arg0.vault_id,
            new_reward       : v3,
            unclaimed_reward : *v2,
        };
        0x2::event::emit<ReceiptUpdated>(v4);
        v3
    }

    public fun vault_id(arg0: &Receipt) : address {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

