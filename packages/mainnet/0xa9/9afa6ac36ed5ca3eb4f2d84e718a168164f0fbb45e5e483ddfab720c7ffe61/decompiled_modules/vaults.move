module 0xa99afa6ac36ed5ca3eb4f2d84e718a168164f0fbb45e5e483ddfab720c7ffe61::vaults {
    struct Vault has key {
        id: 0x2::object::UID,
        whitelisted: 0x2::vec_set::VecSet<address>,
        cap: 0x2::object::ID,
    }

    struct VaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun balance<T0>(arg0: &Vault) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg0.id, v0)) {
            return 0
        };
        let v1 = BalanceKey<T0>{dummy_field: false};
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v1))
    }

    entry fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = internal_new(arg0);
        0x2::transfer::share_object<Vault>(v0);
        0x2::transfer::public_transfer<VaultCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun internal_new(arg0: &mut 0x2::tx_context::TxContext) : (Vault, VaultCap) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = Vault{
            id          : v0,
            whitelisted : 0x2::vec_set::empty<address>(),
            cap         : 0x2::object::uid_to_inner(&v1),
        };
        let v3 = VaultCap{
            id       : v1,
            vault_id : 0x2::object::uid_to_inner(&v0),
        };
        (v2, v3)
    }

    fun is_valid_for(arg0: &VaultCap, arg1: &Vault) : bool {
        arg1.cap == 0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun is_whitelisted(arg0: &Vault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelisted, &arg1)
    }

    public fun merge_receiving<T0>(arg0: &mut Vault, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg0.id, v0)) {
            let v1 = BalanceKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1)));
        } else {
            let v2 = BalanceKey<T0>{dummy_field: false};
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1)));
        };
    }

    public fun remove_address(arg0: &mut Vault, arg1: &VaultCap, arg2: address) {
        assert!(is_valid_for(arg1, arg0), 13835339848086585347);
        0x2::vec_set::remove<address>(&mut arg0.whitelisted, &arg2);
    }

    public fun remove_self(arg0: &mut Vault, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.whitelisted, &v0), 13835058398879547393);
        let v1 = 0x2::tx_context::sender(arg1);
        0x2::vec_set::remove<address>(&mut arg0.whitelisted, &v1);
    }

    public fun whitelist_address(arg0: &mut Vault, arg1: &VaultCap, arg2: address) {
        assert!(is_valid_for(arg1, arg0), 13835339822316781571);
        0x2::vec_set::insert<address>(&mut arg0.whitelisted, arg2);
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_whitelisted(arg0, 0x2::tx_context::sender(arg2)), 13835058265735561217);
        assert!(balance<T0>(arg0) >= arg1, 13835621219984211973);
        let v0 = BalanceKey<T0>{dummy_field: false};
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

