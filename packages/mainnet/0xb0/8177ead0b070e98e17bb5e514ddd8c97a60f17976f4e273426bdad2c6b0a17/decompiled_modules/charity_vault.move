module 0xb08177ead0b070e98e17bb5e514ddd8c97a60f17976f4e273426bdad2c6b0a17::charity_vault {
    struct CharityVault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        total_donated: u64,
        total_withdrawn: u64,
    }

    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DonationEvent has copy, drop {
        donor: address,
        amount: u64,
    }

    struct WithdrawalEvent has copy, drop {
        admin: address,
        amount: u64,
        reason: 0x1::string::String,
    }

    public fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CharityVault<T0>{
            id              : 0x2::object::new(arg0),
            balance         : 0x2::balance::zero<T0>(),
            total_donated   : 0,
            total_withdrawn : 0,
        };
        0x2::transfer::share_object<CharityVault<T0>>(v0);
    }

    public fun donate<T0>(arg0: &mut CharityVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_donated = arg0.total_donated + v0;
        let v1 = DonationEvent{
            donor  : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<DonationEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<VaultAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun withdraw<T0>(arg0: &VaultAdminCap, arg1: &mut CharityVault<T0>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 0);
        arg1.total_withdrawn = arg1.total_withdrawn + arg2;
        let v0 = WithdrawalEvent{
            admin  : 0x2::tx_context::sender(arg4),
            amount : arg2,
            reason : 0x1::string::utf8(arg3),
        };
        0x2::event::emit<WithdrawalEvent>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4)
    }

    // decompiled from Move bytecode v7
}

