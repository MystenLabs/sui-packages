module 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::referral_table {
    struct SetReferralCode has copy, drop {
        refer: address,
        code: 0x1::string::String,
    }

    struct UseReferralCode has copy, drop {
        referee: address,
        code: 0x1::string::String,
    }

    struct ReferralTable has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u16>,
        code_to_refer: 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::KeyedBigVector,
        referee_to_code: 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::KeyedBigVector,
    }

    public fun add_version(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut ReferralTable, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg1.versions, &arg2)) {
            0x2::vec_set::insert<u16>(&mut arg1.versions, arg2);
        };
    }

    public fun allow_version(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut ReferralTable, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg1.versions, &arg2)) {
            0x2::vec_set::insert<u16>(&mut arg1.versions, arg2);
        };
    }

    fun assert_valid_package_version(arg0: &ReferralTable) {
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::version::package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.versions, &v0)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_invalid_version();
        };
    }

    public fun assert_version(arg0: &ReferralTable) {
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::version::package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.versions, &v0)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_invalid_version();
        };
    }

    public fun code_to_refer(arg0: &ReferralTable) : &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::KeyedBigVector {
        &arg0.code_to_refer
    }

    public fun disallow_version(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut ReferralTable, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg1.versions, &arg2)) {
            0x2::vec_set::remove<u16>(&mut arg1.versions, &arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralTable{
            id              : 0x2::object::new(arg0),
            versions        : 0x2::vec_set::singleton<u16>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::version::package_version()),
            code_to_refer   : 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::new<0x1::string::String, address>(256, arg0),
            referee_to_code : 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::new<address, 0x1::string::String>(256, arg0),
        };
        0x2::transfer::share_object<ReferralTable>(v0);
    }

    public fun is_valid_referral_code(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v3 = *0x1::vector::borrow<u8>(v0, v1);
            let v4 = b"0";
            let v5 = if (v3 >= *0x1::vector::borrow<u8>(&v4, 0)) {
                let v6 = b"9";
                v3 <= *0x1::vector::borrow<u8>(&v6, 0)
            } else {
                false
            };
            let v7 = if (v5) {
                true
            } else {
                let v8 = b"a";
                if (v3 >= *0x1::vector::borrow<u8>(&v8, 0)) {
                    let v9 = b"z";
                    v3 <= *0x1::vector::borrow<u8>(&v9, 0)
                } else {
                    false
                }
            };
            if (!v7) {
                v2 = false;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = true;
        v2
    }

    public fun referee_to_code(arg0: &ReferralTable) : &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::KeyedBigVector {
        &arg0.referee_to_code
    }

    public fun referral_code_exists(arg0: &ReferralTable, arg1: 0x1::string::String) : bool {
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x1::string::String>(code_to_refer(arg0), arg1)
    }

    public fun remove_version(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut ReferralTable, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg1.versions, &arg2)) {
            0x2::vec_set::remove<u16>(&mut arg1.versions, &arg2);
        };
    }

    public fun set_referral_code(arg0: &mut ReferralTable, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x1::string::String) {
        assert_valid_package_version(arg0);
        if (!is_valid_referral_code(&arg2)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_invalid_referral_code();
        };
        if (referral_code_exists(arg0, arg2)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_referral_code_being_set();
        };
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::push_back<0x1::string::String, address>(&mut arg0.code_to_refer, arg2, v0);
        let v1 = SetReferralCode{
            refer : v0,
            code  : arg2,
        };
        0x2::event::emit<SetReferralCode>(v1);
    }

    public fun try_get_refer(arg0: &ReferralTable, arg1: address) : 0x1::option::Option<address> {
        if (0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<address>(&arg0.referee_to_code, arg1)) {
            0x1::option::some<address>(*0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<0x1::string::String, address>(&arg0.code_to_refer, *0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<address, 0x1::string::String>(&arg0.referee_to_code, arg1)))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun use_referral_code(arg0: &mut ReferralTable, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x1::string::String) {
        assert_valid_package_version(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<address>(&arg0.referee_to_code, v0)) {
            return
        };
        if (!referral_code_exists(arg0, arg2)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_referral_code_not_exists();
        };
        if (&v0 == 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<0x1::string::String, address>(&arg0.code_to_refer, arg2)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_self_referral();
        };
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::push_back<address, 0x1::string::String>(&mut arg0.referee_to_code, v0, arg2);
        let v1 = UseReferralCode{
            referee : v0,
            code    : arg2,
        };
        0x2::event::emit<UseReferralCode>(v1);
    }

    // decompiled from Move bytecode v7
}

