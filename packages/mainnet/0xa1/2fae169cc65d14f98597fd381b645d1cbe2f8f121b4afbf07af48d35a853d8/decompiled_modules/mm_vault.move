module 0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::mm_vault {
    struct MMRegistry has store, key {
        id: 0x2::object::UID,
        mms: 0x2::table::Table<0x2::object::ID, 0x1::string::String>,
    }

    struct MMVault has store, key {
        id: 0x2::object::UID,
        cap_id: 0x2::object::ID,
        signer: address,
        balances: 0x2::bag::Bag,
    }

    struct MMVaultCap has store, key {
        id: 0x2::object::UID,
    }

    struct CreateMMVaultEvent has copy, drop {
        name: 0x1::string::String,
        mm_vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        owner: address,
    }

    struct DepositEvent has copy, drop {
        mm_vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        mm_vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        withdraw_amount: u64,
    }

    struct UpdateSignerEvent has copy, drop {
        mm_vault_id: 0x2::object::ID,
        new_signer: address,
    }

    public(friend) fun swap<T0, T1>(arg0: &mut MMVault, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::Versioned, arg8: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::check_version(arg7);
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<T1>(), 13906835196546646033);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x1::string::into_bytes(arg1);
        0x1::vector::append<u8>(&mut v1, 0x2::object::id_bytes<MMVault>(arg0));
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v2));
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg5));
        let v4 = 0x2::tx_context::sender(arg8);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&v4));
        let (v5, v6) = verify_internal(v1, &arg6);
        check_signer(arg0, v6);
        assert!(v5, 13906835252380303363);
        let v7 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v7)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v7), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v7, 0x2::coin::into_balance<T0>(arg2));
        };
        let v8 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v8), 13906835299625336841);
        let v9 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v8);
        assert!(0x2::balance::value<T1>(v9) >= arg3, 13906835308215271433);
        0x2::balance::split<T1>(v9, arg3)
    }

    public fun balance_of<T0>(arg0: &MMVault) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun check_cap(arg0: &MMVault, arg1: &MMVaultCap) {
        assert!(arg0.cap_id == 0x2::object::id<MMVaultCap>(arg1), 13906835514373439493);
    }

    public fun check_signer(arg0: &MMVault, arg1: address) {
        assert!(arg0.signer == arg1, 13906835531553832973);
    }

    public fun create_vault(arg0: &mut MMRegistry, arg1: 0x1::string::String, arg2: address, arg3: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::admin_cap::AdminCap, arg4: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::check_version(arg4);
        assert!(0x1::string::length(&arg1) > 0, 13906834646790701071);
        let v0 = MMVaultCap{id: 0x2::object::new(arg5)};
        let v1 = 0x2::object::id<MMVaultCap>(&v0);
        let v2 = MMVault{
            id       : 0x2::object::new(arg5),
            cap_id   : v1,
            signer   : arg2,
            balances : 0x2::bag::new(arg5),
        };
        let v3 = 0x2::object::id<MMVault>(&v2);
        0x2::table::add<0x2::object::ID, 0x1::string::String>(&mut arg0.mms, v3, arg1);
        0x2::transfer::public_share_object<MMVault>(v2);
        0x2::transfer::public_transfer<MMVaultCap>(v0, arg2);
        let v4 = CreateMMVaultEvent{
            name        : arg1,
            mm_vault_id : v3,
            cap_id      : v1,
            owner       : arg2,
        };
        0x2::event::emit<CreateMMVaultEvent>(v4);
        v3
    }

    public fun deposit<T0>(arg0: &mut MMVault, arg1: 0x2::coin::Coin<T0>, arg2: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::Versioned) {
        0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::check_version(arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 13906834805703573505);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(arg1));
        };
        let v2 = DepositEvent{
            mm_vault_id : 0x2::object::id<MMVault>(arg0),
            coin_type   : v0,
            amount      : v1,
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public fun get_signer(arg0: &MMVault) : address {
        arg0.signer
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MMRegistry{
            id  : 0x2::object::new(arg0),
            mms : 0x2::table::new<0x2::object::ID, 0x1::string::String>(arg0),
        };
        0x2::transfer::public_share_object<MMRegistry>(v0);
    }

    public fun parse_signature(arg0: vector<u8>) : (address, vector<u8>, vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg0) >= 97, 13906835424178995203);
        assert!(*0x1::vector::borrow<u8>(&arg0, 0) == 0, 13906835432769454091);
        let v0 = x"00";
        let v1 = b"";
        let v2 = 0x1::vector::length<u8>(&arg0);
        let v3 = 1;
        while (v3 < v2) {
            if (v3 <= v2 - 32 - 1) {
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0, v3));
            } else {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v3));
            };
            v3 = v3 + 1;
        };
        0x1::vector::remove<u8>(&mut v0, 0);
        (0x2::address::from_bytes(0x2::hash::blake2b256(&v0)), v0, v1)
    }

    public fun update_signer(arg0: &mut MMVault, arg1: address, arg2: &MMVaultCap, arg3: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::Versioned) {
        0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::check_version(arg3);
        check_cap(arg0, arg2);
        arg0.signer = arg1;
        let v0 = UpdateSignerEvent{
            mm_vault_id : 0x2::object::id<MMVault>(arg0),
            new_signer  : arg1,
        };
        0x2::event::emit<UpdateSignerEvent>(v0);
    }

    public fun verify_internal(arg0: vector<u8>, arg1: &0x1::string::String) : (bool, address) {
        let (v0, v1, v2) = parse_signature(0x2::hex::decode(*0x1::string::as_bytes(arg1)));
        let v3 = v2;
        let v4 = v1;
        (0x2::ed25519::ed25519_verify(&v3, &v4, &arg0), v0)
    }

    public fun withdraw<T0>(arg0: &mut MMVault, arg1: u64, arg2: &MMVaultCap, arg3: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::check_version(arg3);
        check_cap(arg0, arg2);
        assert!(arg1 > 0, 13906834917372723201);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 13906834930258018311);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        let v2 = if (0x2::balance::value<T0>(v1) > arg1) {
            arg1
        } else {
            0x2::balance::value<T0>(v1)
        };
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, v2), arg4);
        let v4 = WithdrawEvent{
            mm_vault_id     : 0x2::object::id<MMVault>(arg0),
            coin_type       : v0,
            amount          : arg1,
            withdraw_amount : v2,
        };
        0x2::event::emit<WithdrawEvent>(v4);
        v3
    }

    public fun withdraw_and_transfer<T0>(arg0: &mut MMVault, arg1: u64, arg2: &MMVaultCap, arg3: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

