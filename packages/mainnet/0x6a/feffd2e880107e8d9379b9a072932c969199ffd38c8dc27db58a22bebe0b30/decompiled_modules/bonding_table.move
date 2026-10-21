module 0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::bonding_table {
    struct ReferralTableCreated has copy, drop {
        table_id: 0x2::object::ID,
    }

    struct SetReferralCode has copy, drop {
        table_id: 0x2::object::ID,
        refer: address,
        code: 0x1::string::String,
    }

    struct UseReferralCode has copy, drop {
        table_id: 0x2::object::ID,
        referee: address,
        refer: address,
        code: 0x1::string::String,
    }

    struct ReferralTable has key {
        id: 0x2::object::UID,
        code_to_refer: 0x2::table::Table<0x1::string::String, address>,
        refer_to_code: 0x2::table::Table<address, 0x1::string::String>,
        referee_to_code: 0x2::table::Table<address, 0x1::string::String>,
    }

    fun assert_valid_referral_address(arg0: address) {
        if (arg0 == @0x0) {
            err_invalid_referral_address();
        };
    }

    public fun code_to_refer(arg0: &ReferralTable) : &0x2::table::Table<0x1::string::String, address> {
        &arg0.code_to_refer
    }

    fun err_invalid_referral_address() {
        abort 5
    }

    fun err_invalid_referral_code() {
        abort 2
    }

    fun err_refer_already_has_code() {
        abort 8
    }

    fun err_referral_already_set() {
        abort 7
    }

    fun err_referral_code_being_set() {
        abort 3
    }

    fun err_referral_code_not_exists() {
        abort 4
    }

    fun err_self_referral() {
        abort 6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralTable{
            id              : 0x2::object::new(arg0),
            code_to_refer   : 0x2::table::new<0x1::string::String, address>(arg0),
            refer_to_code   : 0x2::table::new<address, 0x1::string::String>(arg0),
            referee_to_code : 0x2::table::new<address, 0x1::string::String>(arg0),
        };
        let v1 = ReferralTableCreated{table_id: 0x2::object::id<ReferralTable>(&v0)};
        0x2::event::emit<ReferralTableCreated>(v1);
        0x2::transfer::share_object<ReferralTable>(v0);
    }

    public fun is_valid_referral_code(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        if (v0 < 3 || v0 > 32) {
            return false
        };
        let v1 = 0x1::string::as_bytes(arg0);
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            let v4 = *0x1::vector::borrow<u8>(v1, v2);
            let v5 = b"0";
            let v6 = if (v4 >= *0x1::vector::borrow<u8>(&v5, 0)) {
                let v7 = b"9";
                v4 <= *0x1::vector::borrow<u8>(&v7, 0)
            } else {
                false
            };
            let v8 = if (v6) {
                true
            } else {
                let v9 = b"a";
                if (v4 >= *0x1::vector::borrow<u8>(&v9, 0)) {
                    let v10 = b"z";
                    v4 <= *0x1::vector::borrow<u8>(&v10, 0)
                } else {
                    false
                }
            };
            if (!v8) {
                v3 = false;
                return v3
            };
            v2 = v2 + 1;
        };
        v3 = true;
        v3
    }

    public fun refer_to_code(arg0: &ReferralTable) : &0x2::table::Table<address, 0x1::string::String> {
        &arg0.refer_to_code
    }

    public fun referee_to_code(arg0: &ReferralTable) : &0x2::table::Table<address, 0x1::string::String> {
        &arg0.referee_to_code
    }

    public fun referral_code_exists(arg0: &ReferralTable, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, address>(code_to_refer(arg0), arg1)
    }

    public(friend) fun set_referral_code(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut ReferralTable, arg2: address, arg3: 0x1::string::String) {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        assert_valid_referral_address(arg2);
        if (!is_valid_referral_code(&arg3)) {
            err_invalid_referral_code();
        };
        if (referral_code_exists(arg1, arg3)) {
            err_referral_code_being_set();
        };
        if (0x2::table::contains<address, 0x1::string::String>(&arg1.refer_to_code, arg2)) {
            err_refer_already_has_code();
        };
        0x2::table::add<0x1::string::String, address>(&mut arg1.code_to_refer, arg3, arg2);
        0x2::table::add<address, 0x1::string::String>(&mut arg1.refer_to_code, arg2, arg3);
        let v0 = SetReferralCode{
            table_id : 0x2::object::id<ReferralTable>(arg1),
            refer    : arg2,
            code     : arg3,
        };
        0x2::event::emit<SetReferralCode>(v0);
    }

    public fun set_referral_code_(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut ReferralTable, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        set_referral_code(arg0, arg1, 0x2::tx_context::sender(arg3), arg2);
    }

    public fun try_get_refer(arg0: &ReferralTable, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.referee_to_code, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::string::String, address>(&arg0.code_to_refer, *0x2::table::borrow<address, 0x1::string::String>(&arg0.referee_to_code, arg1)))
        } else {
            0x1::option::none<address>()
        }
    }

    public(friend) fun use_referral_code(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut ReferralTable, arg2: address, arg3: 0x1::string::String) {
        0x1aa8cb1498bb84426d4b85b53774bc5c007098bc93ea3c6d016d6154d39f8c7c::package_version::assert_current(arg0);
        assert_valid_referral_address(arg2);
        if (0x2::table::contains<address, 0x1::string::String>(&arg1.referee_to_code, arg2)) {
            err_referral_already_set();
        };
        if (!referral_code_exists(arg1, arg3)) {
            err_referral_code_not_exists();
        };
        let v0 = *0x2::table::borrow<0x1::string::String, address>(&arg1.code_to_refer, arg3);
        if (v0 == arg2) {
            err_self_referral();
        };
        0x2::table::add<address, 0x1::string::String>(&mut arg1.referee_to_code, arg2, arg3);
        let v1 = UseReferralCode{
            table_id : 0x2::object::id<ReferralTable>(arg1),
            referee  : arg2,
            refer    : v0,
            code     : arg3,
        };
        0x2::event::emit<UseReferralCode>(v1);
    }

    public fun use_referral_code_(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut ReferralTable, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        use_referral_code(arg0, arg1, 0x2::tx_context::sender(arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

