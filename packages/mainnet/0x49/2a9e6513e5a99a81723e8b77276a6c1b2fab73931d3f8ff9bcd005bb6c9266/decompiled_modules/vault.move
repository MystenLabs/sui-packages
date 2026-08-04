module 0x492a9e6513e5a99a81723e8b77276a6c1b2fab73931d3f8ff9bcd005bb6c9266::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        records: 0x2::table::Table<RecordKey, u64>,
        total_deposited: u64,
    }

    struct RecordKey has copy, drop, store {
        sender: address,
        evm_address: 0x1::string::String,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
        evm_address: 0x1::string::String,
        amount: u64,
        total_for_pair: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    public fun balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun create_vault<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id              : 0x2::object::new(arg1),
            balance         : 0x2::balance::zero<T0>(),
            records         : 0x2::table::new<RecordKey, u64>(arg1),
            total_deposited : 0,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = validate_and_normalize_evm(arg2);
        let v2 = 0x2::tx_context::sender(arg3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_deposited = arg0.total_deposited + v0;
        let v3 = RecordKey{
            sender      : v2,
            evm_address : v1,
        };
        if (0x2::table::contains<RecordKey, u64>(&arg0.records, v3)) {
            let v4 = 0x2::table::borrow_mut<RecordKey, u64>(&mut arg0.records, v3);
            *v4 = *v4 + v0;
        } else {
            0x2::table::add<RecordKey, u64>(&mut arg0.records, v3, v0);
        };
        let v5 = DepositEvent{
            vault_id       : 0x2::object::id<Vault<T0>>(arg0),
            sender         : v2,
            evm_address    : v1,
            amount         : v0,
            total_for_pair : *0x2::table::borrow<RecordKey, u64>(&arg0.records, v3),
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    public fun deposited_of<T0>(arg0: &Vault<T0>, arg1: address, arg2: 0x1::string::String) : u64 {
        let v0 = RecordKey{
            sender      : arg1,
            evm_address : validate_and_normalize_evm(arg2),
        };
        if (0x2::table::contains<RecordKey, u64>(&arg0.records, v0)) {
            *0x2::table::borrow<RecordKey, u64>(&arg0.records, v0)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun total_deposited<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_deposited
    }

    public(friend) fun validate_and_normalize_evm(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::into_bytes(arg0);
        assert!(0x1::vector::length<u8>(&v0) == 42, 0);
        assert!(*0x1::vector::borrow<u8>(&v0, 0) == 48 && *0x1::vector::borrow<u8>(&v0, 1) == 120, 0);
        let v1 = b"0x";
        let v2 = 2;
        while (v2 < 42) {
            let v3 = *0x1::vector::borrow<u8>(&v0, v2);
            let v4 = if (v3 >= 65 && v3 <= 70) {
                v3 + 32
            } else {
                v3
            };
            assert!(v4 >= 48 && v4 <= 57 || v4 >= 97 && v4 <= 102, 0);
            0x1::vector::push_back<u8>(&mut v1, v4);
            v2 = v2 + 1;
        };
        0x1::string::utf8(v1)
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), arg3);
        let v0 = WithdrawEvent{
            vault_id  : 0x2::object::id<Vault<T0>>(arg1),
            recipient : arg3,
            amount    : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

