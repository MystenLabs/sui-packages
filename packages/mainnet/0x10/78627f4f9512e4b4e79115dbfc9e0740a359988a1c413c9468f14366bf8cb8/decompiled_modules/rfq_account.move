module 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::rfq_account {
    struct EventNewRfqAccount has copy, drop {
        rfq_account_id: 0x2::object::ID,
        rfq_account_cap_id: 0x2::object::ID,
    }

    struct Rfq<phantom T0, phantom T1> has copy, drop {
        trade_id: u128,
        output_type: 0x1::type_name::TypeName,
        input_type: 0x1::type_name::TypeName,
        protected_margin_account_id: 0x2::object::ID,
        nonce: u128,
        input_amount: u64,
        output_amount: u64,
        output_floor: u64,
        expiry_time_ms: u64,
    }

    struct Account has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        nonces: 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::table_set::TableSet<u128>,
    }

    struct AccountCap has store, key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
    }

    public fun account_cap_rfq_account_id(arg0: &AccountCap) : 0x2::object::ID {
        arg0.account_id
    }

    fun assert_cap_for_account(arg0: &AccountCap, arg1: &Account) {
        assert!(arg0.account_id == 0x2::object::uid_to_inner(&arg1.id), 0);
    }

    public(friend) fun calc_output_by_quote(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg1 * arg3 / arg0;
        assert!(v0 <= arg1, 4);
        assert!(v0 >= arg2, 5);
        v0
    }

    public fun create(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : AccountCap {
        let v0 = Account{
            id         : 0x2::object::new(arg1),
            public_key : arg0,
            nonces     : 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::table_set::new<u128>(arg1),
        };
        let v1 = AccountCap{
            id         : 0x2::object::new(arg1),
            account_id : 0x2::object::uid_to_inner(&v0.id),
        };
        let v2 = EventNewRfqAccount{
            rfq_account_id     : 0x2::object::uid_to_inner(&v0.id),
            rfq_account_cap_id : 0x2::object::uid_to_inner(&v1.id),
        };
        0x2::event::emit<EventNewRfqAccount>(v2);
        0x2::transfer::share_object<Account>(v0);
        v1
    }

    public fun destroy(arg0: Account, arg1: AccountCap) {
        assert_cap_for_account(&arg1, &arg0);
        let AccountCap {
            id         : v0,
            account_id : _,
        } = arg1;
        0x2::object::delete(v0);
        let Account {
            id         : v2,
            public_key : _,
            nonces     : v4,
        } = arg0;
        0x2::object::delete(v2);
        0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::table_set::drop<u128>(v4);
    }

    public(friend) fun verify_signature<T0, T1>(arg0: &mut Account, arg1: u128, arg2: 0x2::object::ID, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock) {
        assert!(!0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::table_set::contains<u128>(&arg0.nonces, arg3), 3);
        0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::table_set::add<u128>(&mut arg0.nonces, arg3);
        let v0 = Rfq<T0, T1>{
            trade_id                    : arg1,
            output_type                 : 0x1::type_name::get<T1>(),
            input_type                  : 0x1::type_name::get<T0>(),
            protected_margin_account_id : arg2,
            nonce                       : arg3,
            input_amount                : arg4,
            output_amount               : arg5,
            output_floor                : arg6,
            expiry_time_ms              : arg7,
        };
        assert!(v0.expiry_time_ms > 0x2::clock::timestamp_ms(arg9), 1);
        let v1 = 0x1::bcs::to_bytes<Rfq<T0, T1>>(&v0);
        assert!(0x2::ed25519::ed25519_verify(&arg8, &arg0.public_key, &v1), 2);
    }

    // decompiled from Move bytecode v6
}

