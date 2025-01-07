module 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct TransferRequest<phantom T0> {
        nft: 0x2::object::ID,
        originator: address,
        beneficiary: address,
        inner: 0x2::transfer_policy::TransferRequest<T0>,
        metadata: 0x2::object::UID,
    }

    struct BalanceAccessCap<phantom T0> has drop, store {
        dummy_field: bool,
    }

    struct BalanceDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OBCustomRulesDfKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : TransferRequest<T0> {
        TransferRequest<T0>{
            nft         : arg0,
            originator  : arg1,
            beneficiary : @0x0,
            inner       : 0x2::transfer_policy::new_request<T0>(arg0, arg3, arg2),
            metadata    : 0x2::object::new(arg4),
        }
    }

    public fun add_receipt<T0, T1: drop>(arg0: &mut TransferRequest<T0>, arg1: T1) {
        0x2::transfer_policy::add_receipt<T0, T1>(arg1, &mut arg0.inner);
    }

    public fun add_originbyte_rule<T0, T1: drop, T2: drop + store>(arg0: T1, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &0x2::transfer_policy::TransferPolicyCap<T0>, arg3: T2) {
        let v0 = 0x2::transfer_policy::uid_mut_as_owner<T0>(arg1, arg2);
        let v1 = OBCustomRulesDfKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<OBCustomRulesDfKey>(v0, v1)) {
            let v2 = OBCustomRulesDfKey{dummy_field: false};
            0x2::dynamic_field::add<OBCustomRulesDfKey, u8>(v0, v2, 1);
        } else {
            let v3 = OBCustomRulesDfKey{dummy_field: false};
            let v4 = 0x2::dynamic_field::borrow_mut<OBCustomRulesDfKey, u8>(v0, v3);
            *v4 = *v4 + 1;
        };
        0x2::transfer_policy::add_rule<T0, T1, T2>(arg0, arg1, arg2, arg3);
    }

    fun balance_<T0, T1>(arg0: &TransferRequest<T0>) : &0x2::balance::Balance<T1> {
        let v0 = BalanceDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<BalanceDfKey, 0x2::balance::Balance<T1>>(&arg0.metadata, v0)
    }

    fun balance_mut_<T0, T1>(arg0: &mut TransferRequest<T0>) : &mut 0x2::balance::Balance<T1> {
        let v0 = BalanceDfKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<BalanceDfKey, 0x2::balance::Balance<T1>>(&mut arg0.metadata, v0)
    }

    public fun confirm<T0, T1>(arg0: TransferRequest<T0>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        distribute_balance_to_beneficiary<T0, T1>(v0, arg2);
        let TransferRequest {
            nft         : _,
            originator  : _,
            beneficiary : _,
            inner       : v4,
            metadata    : v5,
        } = arg0;
        0x2::object::delete(v5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, v4);
    }

    public fun distribute_balance_to_beneficiary<T0, T1>(arg0: &mut TransferRequest<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = metadata_mut<T0>(arg0);
        let v1 = BalanceDfKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BalanceDfKey>(v0, v1)) {
            return
        };
        let v2 = BalanceDfKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::remove<BalanceDfKey, 0x2::balance::Balance<T1>>(v0, v2);
        if (0x2::balance::value<T1>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg1), arg0.beneficiary);
        } else {
            0x2::balance::destroy_zero<T1>(v3);
        };
    }

    public fun from_sui<T0>(arg0: 0x2::transfer_policy::TransferRequest<T0>, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : TransferRequest<T0> {
        TransferRequest<T0>{
            nft         : arg1,
            originator  : arg2,
            beneficiary : @0x0,
            inner       : arg0,
            metadata    : 0x2::object::new(arg3),
        }
    }

    public fun grant_balance_access_cap<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>) : BalanceAccessCap<T0> {
        BalanceAccessCap<T0>{dummy_field: false}
    }

    public fun init_policy<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<T0>, 0x2::transfer_policy::TransferPolicyCap<T0>) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = OBCustomRulesDfKey{dummy_field: false};
        0x2::dynamic_field::add<OBCustomRulesDfKey, u8>(0x2::transfer_policy::uid_mut_as_owner<T0>(&mut v3, &v2), v4, 0);
        (v3, v2)
    }

    public fun inner<T0>(arg0: &TransferRequest<T0>) : &0x2::transfer_policy::TransferRequest<T0> {
        &arg0.inner
    }

    public fun inner_mut<T0>(arg0: &mut TransferRequest<T0>) : &mut 0x2::transfer_policy::TransferRequest<T0> {
        &mut arg0.inner
    }

    public fun into_sui<T0>(arg0: TransferRequest<T0>, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let v0 = OBCustomRulesDfKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<OBCustomRulesDfKey>(0x2::transfer_policy::uid<T0>(arg1), v0), 3);
        let v1 = &mut arg0;
        distribute_balance_to_beneficiary<T0, 0x2::sui::SUI>(v1, arg2);
        let TransferRequest {
            nft         : _,
            originator  : _,
            beneficiary : _,
            inner       : v5,
            metadata    : v6,
        } = arg0;
        0x2::object::delete(v6);
        v5
    }

    public fun is_originbyte<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : bool {
        let v0 = OBCustomRulesDfKey{dummy_field: false};
        0x2::dynamic_field::exists_<OBCustomRulesDfKey>(0x2::transfer_policy::uid<T0>(arg0), v0)
    }

    public fun metadata<T0>(arg0: &TransferRequest<T0>) : &0x2::object::UID {
        &arg0.metadata
    }

    public fun metadata_mut<T0>(arg0: &mut TransferRequest<T0>) : &mut 0x2::object::UID {
        &mut arg0.metadata
    }

    public fun nft<T0>(arg0: &TransferRequest<T0>) : 0x2::object::ID {
        arg0.nft
    }

    public fun originator<T0>(arg0: &TransferRequest<T0>) : address {
        arg0.originator
    }

    public fun paid_in_ft<T0, T1>(arg0: &TransferRequest<T0>) : (u64, address) {
        (0x2::balance::value<T1>(balance_<T0, T1>(arg0)), arg0.beneficiary)
    }

    public fun paid_in_ft_mut<T0, T1>(arg0: &mut TransferRequest<T0>, arg1: &BalanceAccessCap<T0>) : (&mut 0x2::balance::Balance<T1>, address) {
        let v0 = arg0.beneficiary;
        (balance_mut_<T0, T1>(arg0), v0)
    }

    public fun paid_in_sui<T0>(arg0: &TransferRequest<T0>) : (u64, address) {
        paid_in_ft<T0, 0x2::sui::SUI>(arg0)
    }

    public fun paid_in_sui_mut<T0>(arg0: &mut TransferRequest<T0>, arg1: &BalanceAccessCap<T0>) : (&mut 0x2::balance::Balance<0x2::sui::SUI>, address) {
        let v0 = arg0.beneficiary;
        (balance_mut_<T0, 0x2::sui::SUI>(arg0), v0)
    }

    public fun remove_originbyte_rule<T0, T1: drop, T2: drop + store>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = OBCustomRulesDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<OBCustomRulesDfKey, u8>(0x2::transfer_policy::uid_mut_as_owner<T0>(arg0, arg1), v0);
        assert!(*v1 >= 1, 3);
        *v1 = *v1 - 1;
        0x2::transfer_policy::remove_rule<T0, T1, T2>(arg0, arg1);
    }

    public fun set_nothing_paid<T0>(arg0: &mut TransferRequest<T0>) {
        let v0 = BalanceDfKey{dummy_field: false};
        0x2::dynamic_field::add<BalanceDfKey, 0x2::balance::Balance<0x2::sui::SUI>>(metadata_mut<T0>(arg0), v0, 0x2::balance::zero<0x2::sui::SUI>());
    }

    public fun set_paid<T0, T1>(arg0: &mut TransferRequest<T0>, arg1: 0x2::balance::Balance<T1>, arg2: address) {
        arg0.beneficiary = arg2;
        let v0 = BalanceDfKey{dummy_field: false};
        0x2::dynamic_field::add<BalanceDfKey, 0x2::balance::Balance<T1>>(metadata_mut<T0>(arg0), v0, arg1);
    }

    // decompiled from Move bytecode v6
}

