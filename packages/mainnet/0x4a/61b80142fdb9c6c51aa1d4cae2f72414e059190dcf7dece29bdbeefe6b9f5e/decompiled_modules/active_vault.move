module 0x4a61b80142fdb9c6c51aa1d4cae2f72414e059190dcf7dece29bdbeefe6b9f5e::active_vault {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
    }

    struct ActiveVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct ActiveVaultCreated has copy, drop {
        sender: address,
        vault: address,
    }

    struct Deposited has copy, drop {
        user: address,
        amount: u64,
        vault_id: address,
    }

    struct Withdrawn has copy, drop {
        admin: address,
        recipient: address,
        amount: u64,
        vault_id: address,
    }

    public fun create_vault<T0>(arg0: &OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ActiveVault<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        let v1 = ActiveVaultCreated{
            sender : 0x2::tx_context::sender(arg1),
            vault  : 0x2::object::id_address<ActiveVault<T0>>(&v0),
        };
        0x2::event::emit<ActiveVaultCreated>(v1);
        0x2::transfer::share_object<ActiveVault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut ActiveVault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = Deposited{
            user     : 0x2::tx_context::sender(arg2),
            amount   : 0x2::balance::value<T0>(&arg1),
            vault_id : 0x2::object::id_address<ActiveVault<T0>>(arg0),
        };
        0x2::event::emit<Deposited>(v0);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Config>(v1);
    }

    public fun vault_balance<T0>(arg0: &ActiveVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun withdraw<T0>(arg0: &mut ActiveVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = Withdrawn{
            admin     : 0x2::tx_context::sender(arg2),
            recipient : 0x2::tx_context::sender(arg2),
            amount    : v0,
            vault_id  : 0x2::object::id_address<ActiveVault<T0>>(arg0),
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2)
    }

    // decompiled from Move bytecode v6
}

