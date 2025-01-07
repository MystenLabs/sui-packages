module 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_referral {
    struct BorrowReferral<phantom T0, T1> {
        id: 0x2::object::UID,
        borrow_fee_discount: u64,
        referral_share: u64,
        borrowed: u64,
        referral_fee: 0x2::balance::Balance<T0>,
        witness: T1,
    }

    struct BorrowReferralCfgKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthorizedWitnessList has key {
        id: 0x2::object::UID,
        witness_list: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun add_referral_cfg<T0, T1: drop, T2: drop + store>(arg0: &mut BorrowReferral<T0, T1>, arg1: T2) {
        let v0 = BorrowReferralCfgKey<T2>{dummy_field: false};
        0x2::dynamic_field::add<BorrowReferralCfgKey<T2>, T2>(&mut arg0.id, v0, arg1);
    }

    public(friend) fun add_witness<T0: drop>(arg0: &mut AuthorizedWitnessList) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.witness_list, &v0) == false) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.witness_list, v0);
        };
    }

    public fun assert_authorized_witness<T0: drop>(arg0: &AuthorizedWitnessList) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.witness_list, &v0), 711);
    }

    public fun borrow_fee_discount<T0, T1>(arg0: &BorrowReferral<T0, T1>) : u64 {
        arg0.borrow_fee_discount
    }

    public fun borrowed<T0, T1>(arg0: &BorrowReferral<T0, T1>) : u64 {
        arg0.borrowed
    }

    public fun calc_discounted_borrow_fee<T0, T1: drop>(arg0: &BorrowReferral<T0, T1>, arg1: u64) : u64 {
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg1, arg0.borrow_fee_discount, 100)
    }

    public fun calc_referral_fee<T0, T1: drop>(arg0: &BorrowReferral<T0, T1>, arg1: u64) : u64 {
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg1, arg0.referral_share, 100)
    }

    public fun create_borrow_referral<T0, T1: drop>(arg0: T1, arg1: &AuthorizedWitnessList, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : BorrowReferral<T0, T1> {
        assert_authorized_witness<T1>(arg1);
        assert!(arg2 + arg3 < 100, 712);
        BorrowReferral<T0, T1>{
            id                  : 0x2::object::new(arg4),
            borrow_fee_discount : arg2,
            referral_share      : arg3,
            borrowed            : 0,
            referral_fee        : 0x2::balance::zero<T0>(),
            witness             : arg0,
        }
    }

    public(friend) fun create_witness_list(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthorizedWitnessList{
            id           : 0x2::object::new(arg0),
            witness_list : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<AuthorizedWitnessList>(v0);
    }

    public fun destroy_borrow_referral<T0, T1: drop>(arg0: T1, arg1: BorrowReferral<T0, T1>) : 0x2::balance::Balance<T0> {
        let BorrowReferral {
            id                  : v0,
            borrow_fee_discount : _,
            referral_share      : _,
            borrowed            : _,
            referral_fee        : v4,
            witness             : _,
        } = arg1;
        0x2::object::delete(v0);
        v4
    }

    public fun fee_rate_base() : u64 {
        100
    }

    public fun get_referral_cfg<T0, T1: drop, T2: drop + store>(arg0: &BorrowReferral<T0, T1>) : &T2 {
        let v0 = BorrowReferralCfgKey<T2>{dummy_field: false};
        0x2::dynamic_field::borrow<BorrowReferralCfgKey<T2>, T2>(&arg0.id, v0)
    }

    public fun increase_borrowed<T0, T1: drop>(arg0: &mut BorrowReferral<T0, T1>, arg1: u64) {
        arg0.borrowed = arg0.borrowed + arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthorizedWitnessList{
            id           : 0x2::object::new(arg0),
            witness_list : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<AuthorizedWitnessList>(v0);
    }

    public fun put_referral_fee<T0, T1: drop>(arg0: &mut BorrowReferral<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.referral_fee, arg1);
    }

    public fun referral_share<T0, T1>(arg0: &BorrowReferral<T0, T1>) : u64 {
        arg0.referral_share
    }

    public(friend) fun remove_witness<T0: drop>(arg0: &mut AuthorizedWitnessList) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.witness_list, &v0) == true) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.witness_list, &v0);
        };
    }

    // decompiled from Move bytecode v6
}

