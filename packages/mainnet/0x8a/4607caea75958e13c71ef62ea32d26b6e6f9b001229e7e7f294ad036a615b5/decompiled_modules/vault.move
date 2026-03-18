module 0x8a4607caea75958e13c71ef62ea32d26b6e6f9b001229e7e7f294ad036a615b5::vault {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        members: 0x2::vec_set::VecSet<address>,
    }

    struct FlashLoan {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun borrow<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoan) {
        let v0 = withdraw_balance<T0>(arg0, arg1);
        let v1 = FlashLoan{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg1,
        };
        (0x2::coin::from_balance<T0>(v0, arg2), v1)
    }

    public fun add_member(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.members, arg2);
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    fun deposit_balance<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        } else if (0x2::balance::value<T0>(&arg1) > 0) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun get_balance<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, 0x2::tx_context::sender(arg0));
        let v2 = Vault{
            id      : 0x2::object::new(arg0),
            members : v1,
        };
        0x2::transfer::share_object<Vault>(v2);
    }

    public fun is_member(arg0: &Vault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.members, &arg1)
    }

    public fun receive_deposit<T0>(arg0: &mut Vault, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        deposit<T0>(arg0, v0);
    }

    public fun repay<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoan, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let FlashLoan {
            vault_id  : v1,
            coin_type : v2,
            amount    : v3,
        } = arg2;
        assert!(v1 == 0x2::object::uid_to_inner(&arg0.id), 4);
        assert!(v2 == 0x1::type_name::with_defining_ids<T0>(), 3);
        let v4 = if (0x2::vec_set::contains<address>(&arg0.members, &v0)) {
            v3
        } else {
            v3 + (v3 + 99) / 100
        };
        assert!(0x2::coin::value<T0>(&arg1) >= v4, 1);
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg3)));
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    public fun revoke_membership(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.members, &arg2);
    }

    public fun transfer_admin(arg0: AdminCap, arg1: &mut Vault, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::vec_set::contains<address>(&arg1.members, &v0)) {
            0x2::vec_set::remove<address>(&mut arg1.members, &v0);
        };
        if (!0x2::vec_set::contains<address>(&arg1.members, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.members, arg2);
        };
        0x2::transfer::transfer<AdminCap>(arg0, arg2);
    }

    public(friend) fun withdraw<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &v0), 0);
        0x2::coin::from_balance<T0>(withdraw_balance<T0>(arg0, arg1), arg2)
    }

    public fun withdraw_and_receive<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun withdraw_balance<T0>(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 1);
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0));
        };
        0x2::balance::split<T0>(v1, arg1)
    }

    // decompiled from Move bytecode v6
}

