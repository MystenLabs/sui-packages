module 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::builder_code {
    struct BuilderCodeKey has copy, drop, store {
        pos0: address,
        pos1: u64,
    }

    struct BuilderCode has key {
        id: 0x2::object::UID,
        owner: address,
        index: u64,
    }

    fun assert_owner(arg0: &BuilderCode, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
    }

    public fun claim_all_builder_fees(arg0: &mut BuilderCode, arg1: &0x2::accumulator::AccumulatorRoot, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert_owner(arg0, arg2);
        let v0 = claimable_builder_fees(arg1, arg0);
        if (v0 == 0) {
            return 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), arg2)
        };
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::builder_code_events::emit_builder_fees_claimed(id(arg0), arg0.owner, v0);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::redeem_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::withdraw_funds_from_object<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.id, v0)), arg2)
    }

    public fun claimable_builder_fees(arg0: &0x2::accumulator::AccumulatorRoot, arg1: &BuilderCode) : u64 {
        0x2::balance::settled_funds_value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 0x2::object::uid_to_address(&arg1.id))
    }

    public(friend) fun create_and_share(arg0: &mut 0x2::object::UID, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = BuilderCodeKey{
            pos0 : v0,
            pos1 : arg1,
        };
        let v2 = BuilderCode{
            id    : 0x2::derived_object::claim<BuilderCodeKey>(arg0, v1),
            owner : v0,
            index : arg1,
        };
        let v3 = id(&v2);
        0x2::transfer::share_object<BuilderCode>(v2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::builder_code_events::emit_builder_code_created(v3, v0, arg1);
        v3
    }

    public fun id(arg0: &BuilderCode) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun index(arg0: &BuilderCode) : u64 {
        arg0.index
    }

    public fun owner(arg0: &BuilderCode) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v7
}

