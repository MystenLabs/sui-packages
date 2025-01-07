module 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::event {
    struct LaunchpadCreatedEvent has copy, drop {
        launchpad: 0x2::object::ID,
        conf: 0x2::object::ID,
        liquidity: 0x2::object::ID,
        recommended_policies: 0x2::object::ID,
    }

    struct NextDaoCanProbablyBeLaunchedEvent has copy, drop {
        dummy_field: bool,
    }

    struct DefaultPolicyAddedEvent has copy, drop {
        policy_type_name: 0x1::ascii::String,
        policy_conf: 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf,
    }

    struct DefaultPolicyRemovedEvent has copy, drop {
        policy_type_name: 0x1::ascii::String,
    }

    struct DaoCreatedEvent has copy, drop {
        dao: 0x2::object::ID,
        constitution: 0x2::object::ID,
        xyz_coin_type: 0x1::string::String,
        conf: 0x2::object::ID,
        liquidity: 0x2::object::ID,
        supported_policies: 0x2::object::ID,
        agents: 0x2::object::ID,
        proposals: 0x2::object::ID,
        plbc_midpoint: u64,
    }

    struct ProposalVoteEndedEvent has copy, drop {
        dao: 0x2::object::ID,
        was_proposal_accepted: bool,
        yes_votes: u64,
        no_votes: u64,
        abstained: u64,
    }

    struct ProposalVoteScheduledEvent has copy, drop {
        dao: 0x2::object::ID,
        next_proposing_agent_index: u64,
        next_proposal_vote_in_ms: u64,
        next_proposal_vote_at_ms: u64,
    }

    struct AppendToLogbookEvent has copy, drop {
        dao: 0x2::object::ID,
        message: 0x1::string::String,
    }

    struct ConstitutionUpdatedEvent has copy, drop {
        dao: 0x2::object::ID,
    }

    struct SmartAgentAddedEvent has copy, drop {
        dao: 0x2::object::ID,
        cap: 0x2::object::ID,
        message_for_agent: 0x1::string::String,
        agent_index: u64,
    }

    struct PolicyAddedEvent has copy, drop {
        dao: 0x2::object::ID,
        policy_type_name: 0x1::ascii::String,
        policy_conf: 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf,
    }

    struct PolicyRemovedEvent has copy, drop {
        dao: 0x2::object::ID,
        policy_type_name: 0x1::ascii::String,
    }

    struct SetAgentMessageEvent has copy, drop {
        dao: 0x2::object::ID,
        agent_index: u64,
        message: 0x1::string::String,
    }

    struct AdminCapCreatedEvent has copy, drop {
        cap: 0x2::object::ID,
    }

    struct BOATPoolCreatedEvent has copy, drop {
        boat_type: 0x1::ascii::String,
        treasury_cap: 0x2::object::ID,
        coin_metadata: 0x2::object::ID,
        boat_pool: 0x2::object::ID,
        bonding_curves: 0x2::object::ID,
    }

    public(friend) fun emit_admin_cap_created(arg0: 0x2::object::ID) {
        let v0 = AdminCapCreatedEvent{cap: arg0};
        0x2::event::emit<AdminCapCreatedEvent>(v0);
    }

    public(friend) fun emit_append_to_logbook(arg0: 0x2::object::ID, arg1: 0x1::string::String) {
        let v0 = AppendToLogbookEvent{
            dao     : arg0,
            message : arg1,
        };
        0x2::event::emit<AppendToLogbookEvent>(v0);
    }

    public(friend) fun emit_boat_pool_created(arg0: 0x1::ascii::String, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID) {
        let v0 = BOATPoolCreatedEvent{
            boat_type      : arg0,
            treasury_cap   : arg1,
            coin_metadata  : arg2,
            boat_pool      : arg3,
            bonding_curves : arg4,
        };
        0x2::event::emit<BOATPoolCreatedEvent>(v0);
    }

    public(friend) fun emit_constitution_updated(arg0: 0x2::object::ID) {
        let v0 = ConstitutionUpdatedEvent{dao: arg0};
        0x2::event::emit<ConstitutionUpdatedEvent>(v0);
    }

    public(friend) fun emit_dao_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: u64) {
        let v0 = DaoCreatedEvent{
            dao                : arg0,
            constitution       : arg1,
            xyz_coin_type      : arg2,
            conf               : arg3,
            liquidity          : arg4,
            supported_policies : arg5,
            agents             : arg6,
            proposals          : arg7,
            plbc_midpoint      : arg8,
        };
        0x2::event::emit<DaoCreatedEvent>(v0);
    }

    public(friend) fun emit_default_policy_added(arg0: 0x1::ascii::String, arg1: 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf) {
        let v0 = DefaultPolicyAddedEvent{
            policy_type_name : arg0,
            policy_conf      : arg1,
        };
        0x2::event::emit<DefaultPolicyAddedEvent>(v0);
    }

    public(friend) fun emit_default_policy_removed(arg0: 0x1::ascii::String) {
        let v0 = DefaultPolicyRemovedEvent{policy_type_name: arg0};
        0x2::event::emit<DefaultPolicyRemovedEvent>(v0);
    }

    public(friend) fun emit_launchpad_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = LaunchpadCreatedEvent{
            launchpad            : arg0,
            conf                 : arg1,
            liquidity            : arg2,
            recommended_policies : arg3,
        };
        0x2::event::emit<LaunchpadCreatedEvent>(v0);
    }

    public(friend) fun emit_next_dao_can_probably_be_launched() {
        let v0 = NextDaoCanProbablyBeLaunchedEvent{dummy_field: false};
        0x2::event::emit<NextDaoCanProbablyBeLaunchedEvent>(v0);
    }

    public(friend) fun emit_policy_added(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf) {
        let v0 = PolicyAddedEvent{
            dao              : arg0,
            policy_type_name : arg1,
            policy_conf      : arg2,
        };
        0x2::event::emit<PolicyAddedEvent>(v0);
    }

    public(friend) fun emit_policy_removed(arg0: 0x2::object::ID, arg1: 0x1::ascii::String) {
        let v0 = PolicyRemovedEvent{
            dao              : arg0,
            policy_type_name : arg1,
        };
        0x2::event::emit<PolicyRemovedEvent>(v0);
    }

    public(friend) fun emit_proposal_vote_ended(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ProposalVoteEndedEvent{
            dao                   : arg0,
            was_proposal_accepted : arg1,
            yes_votes             : arg2,
            no_votes              : arg3,
            abstained             : arg4,
        };
        0x2::event::emit<ProposalVoteEndedEvent>(v0);
    }

    public(friend) fun emit_proposal_vote_scheduled(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = ProposalVoteScheduledEvent{
            dao                        : arg0,
            next_proposing_agent_index : arg1,
            next_proposal_vote_in_ms   : arg2,
            next_proposal_vote_at_ms   : arg3,
        };
        0x2::event::emit<ProposalVoteScheduledEvent>(v0);
    }

    public(friend) fun emit_set_agent_message(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String) {
        let v0 = SetAgentMessageEvent{
            dao         : arg0,
            agent_index : arg1,
            message     : arg2,
        };
        0x2::event::emit<SetAgentMessageEvent>(v0);
    }

    public(friend) fun emit_smart_agent_added(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u64) {
        let v0 = SmartAgentAddedEvent{
            dao               : arg0,
            cap               : arg1,
            message_for_agent : arg2,
            agent_index       : arg3,
        };
        0x2::event::emit<SmartAgentAddedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

