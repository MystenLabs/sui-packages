module 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account {
    struct EventNewRfqAccount has copy, drop {
        rfq_account_id: 0x2::object::ID,
        rfq_account_cap_id: 0x2::object::ID,
    }

    struct Rfq<phantom T0, phantom T1> has copy, drop {
        trade_id: u128,
        output_type: 0x1::type_name::TypeName,
        input_type: 0x1::type_name::TypeName,
        protected_margin_account_id: 0x2::object::ID,
        nonce_lane_id: 0x2::object::ID,
        nonce: u64,
        input_amount: u64,
        output_amount: u64,
        expiry_time_ms: u64,
    }

    struct NonceLane has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct Account has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        nonce_lanes: 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::table_set::TableSet<0x2::object::ID>,
    }

    struct AccountCap has store, key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
    }

    public fun account_cap_rfq_account_id(arg0: &AccountCap) : 0x2::object::ID {
        arg0.account_id
    }

    public fun add_nonce_lane(arg0: &mut Account, arg1: &AccountCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_cap_for_account(arg1, arg0);
        let v0 = NonceLane{
            id    : 0x2::object::new(arg2),
            value : 0,
        };
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::table_set::add<0x2::object::ID>(&mut arg0.nonce_lanes, 0x2::object::uid_to_inner(&v0.id));
        0x2::transfer::share_object<NonceLane>(v0);
    }

    fun assert_cap_for_account(arg0: &AccountCap, arg1: &Account) {
        assert!(arg0.account_id == 0x2::object::uid_to_inner(&arg1.id), 0);
    }

    public fun create(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : AccountCap {
        let v0 = Account{
            id          : 0x2::object::new(arg1),
            public_key  : arg0,
            nonce_lanes : 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::table_set::new<0x2::object::ID>(arg1),
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
        let v3 = &mut v0;
        add_nonce_lane(v3, &v1, arg1);
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
            id          : v2,
            public_key  : _,
            nonce_lanes : v4,
        } = arg0;
        0x2::object::delete(v2);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::table_set::drop<0x2::object::ID>(v4);
    }

    public fun nonce_lane_value(arg0: &NonceLane) : u64 {
        arg0.value
    }

    public fun remove_nonce_lane(arg0: &mut Account, arg1: NonceLane, arg2: &AccountCap) {
        assert_cap_for_account(arg2, arg0);
        let NonceLane {
            id    : v0,
            value : _,
        } = arg1;
        let v2 = v0;
        assert!(0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::table_set::contains<0x2::object::ID>(&arg0.nonce_lanes, 0x2::object::uid_to_inner(&v2)), 0);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::table_set::remove<0x2::object::ID>(&mut arg0.nonce_lanes, 0x2::object::uid_to_inner(&v2));
        0x2::object::delete(v2);
    }

    public(friend) fun verify_signature<T0, T1>(arg0: &Account, arg1: u128, arg2: 0x2::object::ID, arg3: &mut NonceLane, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        let v0 = Rfq<T0, T1>{
            trade_id                    : arg1,
            output_type                 : 0x1::type_name::get<T1>(),
            input_type                  : 0x1::type_name::get<T0>(),
            protected_margin_account_id : arg2,
            nonce_lane_id               : 0x2::object::uid_to_inner(&arg3.id),
            nonce                       : arg3.value,
            input_amount                : arg5,
            output_amount               : arg4,
            expiry_time_ms              : arg6,
        };
        assert!(v0.expiry_time_ms > 0x2::clock::timestamp_ms(arg8), 1);
        let v1 = 0x1::bcs::to_bytes<Rfq<T0, T1>>(&v0);
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg0.public_key, &v1), 2);
        arg3.value = arg3.value + 1;
    }

    // decompiled from Move bytecode v6
}

