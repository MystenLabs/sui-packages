module 0x7d5aa284379b6edd79909e4c37901346f6ea7cb56a3ad7c0477c534f4c79b0e7::safe {
    struct Safe<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        allowed_safes: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct OwnerCapability<phantom T0> has store, key {
        id: 0x2::object::UID,
        safe_id: 0x2::object::ID,
    }

    struct TransferCapability<phantom T0> has store, key {
        id: 0x2::object::UID,
        safe_id: 0x2::object::ID,
        amount: u64,
    }

    public fun balance<T0>(arg0: &Safe<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    fun check_capability_validity<T0>(arg0: &Safe<T0>, arg1: &TransferCapability<T0>) {
        assert!(0x2::object::id<Safe<T0>>(arg0) == arg1.safe_id, 0);
        let v0 = 0x2::object::id<TransferCapability<T0>>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_safes, &v0), 2);
    }

    fun check_owner_capability_validity<T0>(arg0: &Safe<T0>, arg1: &OwnerCapability<T0>) {
        assert!(0x2::object::id<Safe<T0>>(arg0) == arg1.safe_id, 1);
    }

    public entry fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_<T0>(0x2::coin::into_balance<T0>(arg0), arg1);
        0x2::transfer::public_transfer<OwnerCapability<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : OwnerCapability<T0> {
        let v0 = Safe<T0>{
            id            : 0x2::object::new(arg1),
            balance       : arg0,
            allowed_safes : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        let v1 = OwnerCapability<T0>{
            id      : 0x2::object::new(arg1),
            safe_id : 0x2::object::id<Safe<T0>>(&v0),
        };
        0x2::transfer::share_object<Safe<T0>>(v0);
        v1
    }

    fun create_capability_<T0>(arg0: &mut Safe<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : TransferCapability<T0> {
        let v0 = 0x2::object::new(arg2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_safes, 0x2::object::uid_to_inner(&v0));
        TransferCapability<T0>{
            id      : v0,
            safe_id : 0x2::object::uid_to_inner(&arg0.id),
            amount  : arg1,
        }
    }

    public entry fun create_empty<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_<T0>(0x2::balance::zero<T0>(), arg0);
        0x2::transfer::public_transfer<OwnerCapability<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_new_cap<T0>(arg0: &mut Safe<T0>, arg1: &OwnerCapability<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_owner_capability_validity<T0>(arg0, arg1);
        let v0 = create_capability_<T0>(arg0, arg2, arg3);
        0x2::transfer::public_transfer<TransferCapability<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun create_transfer_capability<T0>(arg0: &mut Safe<T0>, arg1: &OwnerCapability<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : TransferCapability<T0> {
        check_owner_capability_validity<T0>(arg0, arg1);
        create_capability_<T0>(arg0, arg2, arg3)
    }

    public fun debit<T0>(arg0: &mut Safe<T0>, arg1: &mut TransferCapability<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_capability_validity<T0>(arg0, arg1);
        assert!(arg1.amount >= arg2, 3);
        arg1.amount = arg1.amount - arg2;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3)
    }

    public entry fun debit_transfer<T0>(arg0: &mut Safe<T0>, arg1: &mut TransferCapability<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_capability_validity<T0>(arg0, arg1);
        assert!(arg1.amount >= arg2, 3);
        arg1.amount = arg1.amount - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun deposit<T0>(arg0: &mut Safe<T0>, arg1: 0x2::coin::Coin<T0>) {
        deposit_<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun deposit_<T0>(arg0: &mut Safe<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public entry fun deposit_check_threshold<T0>(arg0: &mut Safe<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 4);
        deposit_<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun revoke_transfer_capability<T0>(arg0: &mut Safe<T0>, arg1: &OwnerCapability<T0>, arg2: 0x2::object::ID) {
        check_owner_capability_validity<T0>(arg0, arg1);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_safes, &arg2);
    }

    public entry fun self_revoke_transfer_capability<T0>(arg0: &mut Safe<T0>, arg1: &TransferCapability<T0>) {
        check_capability_validity<T0>(arg0, arg1);
        let v0 = 0x2::object::id<TransferCapability<T0>>(arg1);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_safes, &v0);
    }

    public entry fun withdraw<T0>(arg0: &mut Safe<T0>, arg1: &OwnerCapability<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(withdraw_<T0>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun withdraw_<T0>(arg0: &mut Safe<T0>, arg1: &OwnerCapability<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        check_owner_capability_validity<T0>(arg0, arg1);
        0x2::balance::split<T0>(&mut arg0.balance, arg2)
    }

    // decompiled from Move bytecode v6
}

