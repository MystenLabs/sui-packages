module 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::event {
    struct NewFactory<phantom T0> has copy, drop {
        factory_id: 0x2::object::ID,
        factory_cap: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
        limit: u64,
    }

    struct MintYourStable<phantom T0> has copy, drop {
        factory_id: 0x2::object::ID,
        stable_coin_type: 0x1::type_name::TypeName,
        minted_amount: u64,
        charged_buck: u64,
        minted_st_sbuck_amount: u64,
        factory_supply: u64,
        factory_underlying_balance: u64,
    }

    struct BurnYourStable<phantom T0> has copy, drop {
        factory_id: 0x2::object::ID,
        stable_coin_type: 0x1::type_name::TypeName,
        your_stable_amount: u64,
        withdrawal_buck: u64,
        burned_st_sbuck_amount: u64,
        factory_supply: u64,
        factory_underlying_balance: u64,
    }

    struct MintYourStableWithExtension<phantom T0> has copy, drop {
        factory_id: 0x2::object::ID,
        extension_type: 0x1::type_name::TypeName,
        your_stable_amount: u64,
        extension_supply: u64,
    }

    struct BurnYourStableWithExtension<phantom T0> has copy, drop {
        factory_id: 0x2::object::ID,
        extension_type: 0x1::type_name::TypeName,
        your_stable_amount: u64,
        extension_supply: u64,
    }

    struct ClaimReward<phantom T0> has copy, drop {
        factory: 0x2::object::ID,
        st_sbuck_reward: u64,
        sender: address,
    }

    struct SetBasicLimit<phantom T0> has copy, drop {
        factory: 0x2::object::ID,
        limit: u64,
    }

    struct SetExtensionLimit<phantom T0> has copy, drop {
        factory: 0x2::object::ID,
        extension: 0x1::type_name::TypeName,
        limit: u64,
    }

    struct UpdateMetadata<phantom T0> has copy, drop {
        factory: 0x2::object::ID,
        metadata: 0x2::object::ID,
        name: 0x1::option::Option<0x1::string::String>,
        symbol: 0x1::option::Option<0x1::ascii::String>,
        description: 0x1::option::Option<0x1::string::String>,
        icon_url: 0x1::option::Option<0x1::ascii::String>,
    }

    struct CreateQueueTicket<phantom T0> has copy, drop {
        stable_coin_type: 0x1::type_name::TypeName,
        max_amount: u64,
        buck_balance: u64,
        tid: u64,
        time_to_redeem: u64,
        recipient: address,
    }

    struct Redeem<phantom T0> has copy, drop {
        stable_coin_type: 0x1::type_name::TypeName,
        buck_balance: u64,
        stable_coin_amount: u64,
        tid: u64,
        time_to_redeem: u64,
        timestamp: u64,
    }

    struct SetRedeemer<phantom T0> has copy, drop {
        queue: 0x2::object::ID,
        redeemer: 0x1::option::Option<address>,
    }

    public(friend) fun emit_burn_your_stable_event<T0>(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = BurnYourStable<T0>{
            factory_id                 : arg0,
            stable_coin_type           : arg1,
            your_stable_amount         : arg2,
            withdrawal_buck            : arg4,
            burned_st_sbuck_amount     : arg3,
            factory_supply             : arg5,
            factory_underlying_balance : arg6,
        };
        0x2::event::emit<BurnYourStable<T0>>(v0);
    }

    public(friend) fun emit_burn_your_stable_with_extension_event<T0>(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = BurnYourStableWithExtension<T0>{
            factory_id         : arg0,
            extension_type     : arg1,
            your_stable_amount : arg2,
            extension_supply   : arg3,
        };
        0x2::event::emit<BurnYourStableWithExtension<T0>>(v0);
    }

    public(friend) fun emit_claim_reward_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = ClaimReward<T0>{
            factory         : arg0,
            st_sbuck_reward : arg1,
            sender          : arg2,
        };
        0x2::event::emit<ClaimReward<T0>>(v0);
    }

    public(friend) fun emit_create_queue_ticket_event<T0>(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address) {
        let v0 = CreateQueueTicket<T0>{
            stable_coin_type : arg0,
            max_amount       : arg1,
            buck_balance     : arg2,
            tid              : arg3,
            time_to_redeem   : arg4,
            recipient        : arg5,
        };
        0x2::event::emit<CreateQueueTicket<T0>>(v0);
    }

    public(friend) fun emit_mint_your_stable_event<T0>(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = MintYourStable<T0>{
            factory_id                 : arg0,
            stable_coin_type           : arg1,
            minted_amount              : arg2,
            charged_buck               : arg3,
            minted_st_sbuck_amount     : arg4,
            factory_supply             : arg5,
            factory_underlying_balance : arg6,
        };
        0x2::event::emit<MintYourStable<T0>>(v0);
    }

    public(friend) fun emit_mint_your_stable_with_extension_event<T0>(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = MintYourStableWithExtension<T0>{
            factory_id         : arg0,
            extension_type     : arg1,
            your_stable_amount : arg2,
            extension_supply   : arg3,
        };
        0x2::event::emit<MintYourStableWithExtension<T0>>(v0);
    }

    public(friend) fun emit_new_factory_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u8, arg4: u64) {
        let v0 = NewFactory<T0>{
            factory_id  : arg0,
            factory_cap : arg1,
            coin_type   : arg2,
            decimals    : arg3,
            limit       : arg4,
        };
        0x2::event::emit<NewFactory<T0>>(v0);
    }

    public(friend) fun emit_redeem_event<T0>(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = Redeem<T0>{
            stable_coin_type   : arg0,
            buck_balance       : arg1,
            stable_coin_amount : arg2,
            tid                : arg3,
            time_to_redeem     : arg4,
            timestamp          : arg5,
        };
        0x2::event::emit<Redeem<T0>>(v0);
    }

    public(friend) fun emit_set_redeemer<T0>(arg0: 0x2::object::ID, arg1: 0x1::option::Option<address>) {
        let v0 = SetRedeemer<T0>{
            queue    : arg0,
            redeemer : arg1,
        };
        0x2::event::emit<SetRedeemer<T0>>(v0);
    }

    public(friend) fun set_basic_limit<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = SetBasicLimit<T0>{
            factory : arg0,
            limit   : arg1,
        };
        0x2::event::emit<SetBasicLimit<T0>>(v0);
    }

    public(friend) fun set_extension_limit<T0>(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = SetExtensionLimit<T0>{
            factory   : arg0,
            extension : arg1,
            limit     : arg2,
        };
        0x2::event::emit<SetExtensionLimit<T0>>(v0);
    }

    public(friend) fun update_metadata<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::ascii::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::ascii::String>) {
        let v0 = UpdateMetadata<T0>{
            factory     : arg0,
            metadata    : arg1,
            name        : arg2,
            symbol      : arg3,
            description : arg4,
            icon_url    : arg5,
        };
        0x2::event::emit<UpdateMetadata<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

