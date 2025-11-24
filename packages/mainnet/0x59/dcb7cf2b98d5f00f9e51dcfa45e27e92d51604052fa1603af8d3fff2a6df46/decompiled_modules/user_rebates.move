module 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::user_rebates {
    struct ReferralCodeGeneratedEvent has copy, drop {
        app: 0x2::object::ID,
        who: address,
        code: 0x1::string::String,
    }

    struct ReferralRebateClaimedEvent has copy, drop {
        app: 0x2::object::ID,
        who: address,
        rebate_amount: u64,
        rebate_coin: 0x1::type_name::TypeName,
    }

    entry fun generate_referral_code(arg0: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        generate_referral_code_inner(arg0, arg1, arg2);
    }

    public fun get_referral_code(arg0: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg1: address) : 0x1::string::String {
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::referral::get_referral_code(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::referral(arg0), arg1)
    }

    public fun has_referral_code(arg0: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg1: address) : bool {
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::referral::has_referral_code(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::referral(arg0), arg1)
    }

    public fun can_generate_referral_code(arg0: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg1: address) : bool {
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::referral::is_qualified_to_create_referral_code(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::referral(arg0), arg1)
    }

    public fun claim_referral_rebates<T0>(arg0: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::referral::claim_rebates<T0>(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::referral_mut(arg0), arg1);
        let v1 = ReferralRebateClaimedEvent{
            app           : 0x2::object::id<0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp>(arg0),
            who           : 0x2::tx_context::sender(arg1),
            rebate_amount : 0x2::coin::value<T0>(&v0),
            rebate_coin   : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ReferralRebateClaimedEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun generate_referral_code_inner(arg0: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::referral_mut(arg0);
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::referral::generate_referral_code(v0, arg1, arg2);
        let v1 = ReferralCodeGeneratedEvent{
            app  : 0x2::object::id<0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp>(arg0),
            who  : 0x2::tx_context::sender(arg2),
            code : 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::referral::get_referral_code(v0, 0x2::tx_context::sender(arg2)),
        };
        0x2::event::emit<ReferralCodeGeneratedEvent>(v1);
    }

    public fun get_linked_code(arg0: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg1: address) : 0x1::option::Option<0x1::string::String> {
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::referral::get_linked_referral_code(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::referral(arg0), arg1)
    }

    public fun get_referral_rebates(arg0: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg1: address) : (vector<0x1::type_name::TypeName>, vector<u64>) {
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::referral::list_rebates(0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::referral(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

