module 0xec32d583ae038e6c276df7e6a1dc2cb5c73dfdc0ecb40a7f072a6bcca1f27093::bridge {
    struct OrdinalsCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        verify: 0x2::table::Table<vector<u8>, bool>,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        fee: 0x2::table::Table<vector<u8>, u64>,
        fee_addr: address,
        signers: vector<vector<u8>>,
        threshold: u64,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        verify: 0x2::table::Table<vector<u8>, bool>,
    }

    struct VersionMigrated has copy, drop {
        sender: address,
        version: u64,
    }

    struct FeeSet has copy, drop {
        sender: address,
        coin: vector<u8>,
        fee: u64,
    }

    struct Deposit has copy, drop {
        sender: address,
        coin: vector<u8>,
        value: u64,
        fee: u64,
        msg: vector<u8>,
    }

    struct Withdraw has copy, drop {
        sender: address,
        coin: vector<u8>,
        value: u64,
        fee: u64,
        recipient: address,
        msg: vector<u8>,
    }

    struct Mint has copy, drop {
        sender: address,
        coin: vector<u8>,
        value: u64,
        fee: u64,
        recipient: address,
        msg: vector<u8>,
    }

    struct Burn has copy, drop {
        sender: address,
        coin: vector<u8>,
        value: u64,
        fee: u64,
        msg: vector<u8>,
    }

    struct Paused has copy, drop {
        sender: address,
    }

    struct Unpaused has copy, drop {
        sender: address,
    }

    public entry fun burn<T0, T1>(arg0: &Config, arg1: &mut OrdinalsCap<T1>, arg2: &mut Treasury<T0>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        version_verify(arg0);
        native_verify<T0>(arg0, arg2);
        let v0 = fee<T1>(arg0);
        let v1 = split_coin<T0>(arg3, v0, arg7);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(v1));
        let v2 = split_coin<T1>(arg4, arg5, arg7);
        0x2::coin::burn<T1>(&mut arg1.treasury_cap, v2);
        let v3 = Burn{
            sender : 0x2::tx_context::sender(arg7),
            coin   : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            value  : arg5,
            fee    : v0,
            msg    : arg6,
        };
        0x2::event::emit<Burn>(v3);
    }

    public entry fun add_liquidity<T0>(arg0: &OwnerCap, arg1: &mut Config, arg2: &mut Treasury<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        version_verify(arg1);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(split_coin<T0>(arg3, arg4, arg5)));
    }

    public entry fun add_signer(arg0: &OwnerCap, arg1: &mut Config, arg2: vector<u8>, arg3: u64) {
        version_verify(arg1);
        assert!(!0x1::vector::contains<vector<u8>>(&arg1.signers, &arg2), 108);
        0x1::vector::push_back<vector<u8>>(&mut arg1.signers, arg2);
        assert!(arg3 <= 0x1::vector::length<vector<u8>>(&arg1.signers), 107);
        arg1.threshold = arg3;
    }

    public entry fun create_ordinals<T0>(arg0: &OwnerCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OrdinalsCap<T0>{
            id           : 0x2::object::new(arg3),
            max_supply   : arg2,
            treasury_cap : arg1,
            verify       : 0x2::table::new<vector<u8>, bool>(arg3),
        };
        0x2::transfer::share_object<OrdinalsCap<T0>>(v0);
    }

    public entry fun create_treasury<T0>(arg0: &OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
            verify  : 0x2::table::new<vector<u8>, bool>(arg1),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public entry fun deposit<T0, T1>(arg0: &Config, arg1: &mut Treasury<T0>, arg2: &mut Treasury<T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        version_verify(arg0);
        native_verify<T0>(arg0, arg1);
        let v0 = fee<T1>(arg0);
        let v1 = split_coin<T0>(arg3, v0, arg7);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(v1));
        let v2 = split_coin<T1>(arg4, arg5, arg7);
        0x2::balance::join<T1>(&mut arg2.balance, 0x2::coin::into_balance<T1>(v2));
        let v3 = Deposit{
            sender : 0x2::tx_context::sender(arg7),
            coin   : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            value  : arg5,
            fee    : v0,
            msg    : arg6,
        };
        0x2::event::emit<Deposit>(v3);
    }

    public fun fee<T0>(arg0: &Config) : u64 {
        *0x2::table::borrow<vector<u8>, u64>(&arg0.fee, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun fee_address(arg0: &Config) : address {
        arg0.fee_addr
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id        : 0x2::object::new(arg0),
            version   : 1,
            paused    : false,
            fee       : 0x2::table::new<vector<u8>, u64>(arg0),
            fee_addr  : @0x0,
            signers   : 0x1::vector::empty<vector<u8>>(),
            threshold : 0,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun keccak_message<T0>(arg0: u64, arg1: address, arg2: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"testnet");
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg0 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x2::hash::keccak256(&v0)
    }

    public entry fun mint<T0, T1>(arg0: &Config, arg1: &mut OrdinalsCap<T1>, arg2: &mut Treasury<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: vector<vector<u8>>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        version_verify(arg0);
        native_verify<T0>(arg0, arg2);
        let v0 = keccak_message<T1>(arg4, arg5, arg7);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.verify, v0), 111);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg0.signers)) {
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg0.signers, v2);
            let v4 = 0;
            while (v4 < 0x1::vector::length<vector<u8>>(&arg6)) {
                let v5 = *0x1::vector::borrow<vector<u8>>(&arg6, v4);
                if (0x2::ed25519::ed25519_verify(&v5, &v3, &v0)) {
                    v1 = v1 + 1;
                    break
                };
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        assert!(arg0.threshold <= v1, 110);
        0x2::table::add<vector<u8>, bool>(&mut arg1.verify, v0, true);
        let v6 = fee<T1>(arg0);
        let v7 = split_coin<T0>(arg3, v6, arg8);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(v7));
        assert!(0x2::coin::total_supply<T1>(&arg1.treasury_cap) + arg4 <= arg1.max_supply, 104);
        0x2::coin::mint_and_transfer<T1>(&mut arg1.treasury_cap, arg4, arg5, arg8);
        let v8 = Mint{
            sender    : 0x2::tx_context::sender(arg8),
            coin      : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            value     : arg4,
            fee       : v6,
            recipient : arg5,
            msg       : arg7,
        };
        0x2::event::emit<Mint>(v8);
    }

    fun native_verify<T0>(arg0: &Config, arg1: &Treasury<T0>) {
        assert!(0x2::object::uid_to_address(&arg1.id) == arg0.fee_addr, 106);
    }

    public entry fun pause(arg0: &OwnerCap, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg1);
        arg1.paused = true;
        let v0 = Paused{sender: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Paused>(v0);
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public entry fun remove_signer(arg0: &OwnerCap, arg1: &mut Config, arg2: vector<u8>, arg3: u64) {
        version_verify(arg1);
        let (v0, v1) = 0x1::vector::index_of<vector<u8>>(&arg1.signers, &arg2);
        assert!(v0, 109);
        0x1::vector::remove<vector<u8>>(&mut arg1.signers, v1);
        assert!(arg3 <= 0x1::vector::length<vector<u8>>(&arg1.signers), 107);
        arg1.threshold = arg3;
    }

    public entry fun set_fee_address<T0>(arg0: &OwnerCap, arg1: &mut Config, arg2: &Treasury<T0>) {
        arg1.fee_addr = 0x2::object::uid_to_address(&arg2.id);
    }

    public entry fun set_fee_amount<T0>(arg0: &OwnerCap, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::table::add<vector<u8>, u64>(&mut arg1.fee, v0, arg2);
        let v1 = FeeSet{
            sender : 0x2::tx_context::sender(arg3),
            coin   : v0,
            fee    : arg2,
        };
        0x2::event::emit<FeeSet>(v1);
    }

    public entry fun setup_signer(arg0: &OwnerCap, arg1: &mut Config, arg2: vector<vector<u8>>, arg3: u64) {
        version_verify(arg1);
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        assert!(arg3 <= v0, 107);
        arg1.threshold = arg3;
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<vector<u8>>(&arg2, v1);
            assert!(!0x1::vector::contains<vector<u8>>(&arg1.signers, &v2), 108);
            0x1::vector::push_back<vector<u8>>(&mut arg1.signers, v2);
            v1 = v1 + 1;
        };
    }

    public fun signer_length(arg0: &Config) : u64 {
        0x1::vector::length<vector<u8>>(&arg0.signers)
    }

    public fun split_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0 && 0x2::coin::value<T0>(&arg0) >= arg1, 105);
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
            return 0x2::coin::split<T0>(&mut arg0, arg1, arg2)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<T0>(&mut arg0, arg1, arg2)
    }

    public fun threshold(arg0: &Config) : u64 {
        arg0.threshold
    }

    public fun treasury_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun unpause(arg0: &OwnerCap, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        when_paused(arg1);
        arg1.paused = false;
        let v0 = Unpaused{sender: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Unpaused>(v0);
    }

    public entry fun version_migration(arg0: &OwnerCap, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 101);
        arg1.version = 1;
        let v0 = VersionMigrated{
            sender  : 0x2::tx_context::sender(arg2),
            version : 1,
        };
        0x2::event::emit<VersionMigrated>(v0);
    }

    fun version_verify(arg0: &Config) {
        assert!(arg0.version == 1, 100);
    }

    fun when_not_paused(arg0: &Config) {
        assert!(!arg0.paused, 102);
    }

    fun when_paused(arg0: &Config) {
        assert!(arg0.paused, 103);
    }

    public entry fun withdraw<T0, T1>(arg0: &Config, arg1: &mut Treasury<T0>, arg2: &mut Treasury<T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: vector<vector<u8>>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        version_verify(arg0);
        native_verify<T0>(arg0, arg1);
        let v0 = keccak_message<T1>(arg4, arg5, arg7);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg2.verify, v0), 111);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg0.signers)) {
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg0.signers, v2);
            let v4 = 0;
            while (v4 < 0x1::vector::length<vector<u8>>(&arg6)) {
                let v5 = *0x1::vector::borrow<vector<u8>>(&arg6, v4);
                if (0x2::ed25519::ed25519_verify(&v5, &v3, &v0)) {
                    v1 = v1 + 1;
                    break
                };
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        assert!(arg0.threshold <= v1, 110);
        0x2::table::add<vector<u8>, bool>(&mut arg2.verify, v0, true);
        let v6 = fee<T1>(arg0);
        let v7 = split_coin<T0>(arg3, v6, arg8);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(v7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2.balance, arg4), arg8), arg5);
        let v8 = Withdraw{
            sender    : 0x2::tx_context::sender(arg8),
            coin      : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            value     : arg4,
            fee       : v6,
            recipient : arg5,
            msg       : arg7,
        };
        0x2::event::emit<Withdraw>(v8);
    }

    public entry fun withdraw_assets<T0>(arg0: &OwnerCap, arg1: &mut Treasury<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            arg2 = 0x2::balance::value<T0>(&arg1.balance);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

