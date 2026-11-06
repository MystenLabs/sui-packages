module 0x39cfcfe852fd8e80a88c3b47ce2269777dc9c69bd60d5364da0952ac7ae39cd2::settle {
    struct APP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        registrar: address,
        agent: address,
        paused: bool,
    }

    struct Mandate has key {
        id: 0x2::object::UID,
        funder: address,
        group: 0x1::string::String,
        creditors: 0x2::vec_set::VecSet<address>,
        max_per_debt: u64,
        objection_window_ms: u64,
    }

    struct Debt<phantom T0> has key {
        id: 0x2::object::UID,
        mandate: 0x2::object::ID,
        group: 0x1::string::String,
        reference: 0x1::string::String,
        debtor: address,
        creditor: address,
        amount: u64,
        recorded_at_ms: u64,
        status: u8,
    }

    struct MandateOpened has copy, drop {
        mandate: 0x2::object::ID,
        funder: address,
        group: 0x1::string::String,
        creditors: vector<address>,
        max_per_debt: u64,
        objection_window_ms: u64,
    }

    struct MandateClosed has copy, drop {
        mandate: 0x2::object::ID,
        funder: address,
    }

    struct DebtRecorded has copy, drop {
        debt: 0x2::object::ID,
        mandate: 0x2::object::ID,
        reference: 0x1::string::String,
        debtor: address,
        creditor: address,
        amount: u64,
        pullable_at_ms: u64,
    }

    struct DebtSettled has copy, drop {
        debt: 0x2::object::ID,
        reference: 0x1::string::String,
        debtor: address,
        creditor: address,
        amount: u64,
        status: u8,
    }

    struct DebtCancelled has copy, drop {
        debt: 0x2::object::ID,
        reference: 0x1::string::String,
        by: address,
    }

    public fun settle<T0>(arg0: &Config, arg1: &Mandate, arg2: &mut Debt<T0>, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 13906835419884552203);
        assert!(arg2.status == 0, 13906835424180043795);
        assert!(arg2.mandate == 0x2::object::id<Mandate>(arg1), 13906835428475142165);
        assert!(0x2::vec_set::contains<address>(&arg1.creditors, &arg2.creditor), 13906835432769585165);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg2.recorded_at_ms + arg1.objection_window_ms, 13906835445655273497);
        let v0 = 0x2::allowance::allowance_settings<0x2::balance::Balance<T0>>(arg3);
        assert!(0x2::allowance::funder(v0) == arg1.funder, 13906835458540044311);
        assert!(*0x2::allowance::name(v0) == arg1.group, 13906835462835535903);
        let v1 = 0x2::allowance::app_balance_spend<T0, APP>(arg3, 0x2::allowance::spend_permit<APP>(0x1::internal::permit<APP>()), arg4, arg5, arg6);
        assert!(0x2::balance::value<T0>(&v1) == arg2.amount, 13906835501489979419);
        0x2::balance::send_funds<T0>(v1, arg2.creditor);
        arg2.status = 1;
        let v2 = DebtSettled{
            debt      : 0x2::object::id<Debt<T0>>(arg2),
            reference : arg2.reference,
            debtor    : arg2.debtor,
            creditor  : arg2.creditor,
            amount    : arg2.amount,
            status    : 1,
        };
        0x2::event::emit<DebtSettled>(v2);
    }

    public fun cancel_debt<T0>(arg0: &Config, arg1: &mut Debt<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.debtor || v0 == arg0.registrar, 13906835643224031261);
        assert!(arg1.status == 0, 13906835647518343187);
        arg1.status = 3;
        let v1 = DebtCancelled{
            debt      : 0x2::object::id<Debt<T0>>(arg1),
            reference : arg1.reference,
            by        : v0,
        };
        0x2::event::emit<DebtCancelled>(v1);
    }

    public fun close_mandate(arg0: Mandate, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.funder == 0x2::tx_context::sender(arg1), 13906835162185859073);
        let Mandate {
            id                  : v0,
            funder              : v1,
            group               : _,
            creditors           : _,
            max_per_debt        : _,
            objection_window_ms : _,
        } = arg0;
        let v6 = v0;
        let v7 = MandateClosed{
            mandate : 0x2::object::uid_to_inner(&v6),
            funder  : v1,
        };
        0x2::event::emit<MandateClosed>(v7);
        0x2::object::delete(v6);
    }

    public fun debt_amount<T0>(arg0: &Debt<T0>) : u64 {
        arg0.amount
    }

    public fun debt_parties<T0>(arg0: &Debt<T0>) : (address, address) {
        (arg0.debtor, arg0.creditor)
    }

    public fun debt_status<T0>(arg0: &Debt<T0>) : u8 {
        arg0.status
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id        : 0x2::object::new(arg0),
            registrar : 0x2::tx_context::sender(arg0),
            agent     : 0x2::tx_context::sender(arg0),
            paused    : false,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun mandate_creditors(arg0: &Mandate) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.creditors)
    }

    public fun mandate_funder(arg0: &Mandate) : address {
        arg0.funder
    }

    public fun mandate_group(arg0: &Mandate) : 0x1::string::String {
        arg0.group
    }

    public fun mark_settled_externally<T0>(arg0: &Config, arg1: &mut Debt<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.registrar, 13906835574503243785);
        assert!(arg1.status == 0, 13906835578798866451);
        arg1.status = 2;
        let v0 = DebtSettled{
            debt      : 0x2::object::id<Debt<T0>>(arg1),
            reference : arg1.reference,
            debtor    : arg1.debtor,
            creditor  : arg1.creditor,
            amount    : arg1.amount,
            status    : 2,
        };
        0x2::event::emit<DebtSettled>(v0);
    }

    public fun open_mandate<T0>(arg0: &Config, arg1: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<T0>>, arg2: vector<address>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<T0>>(&arg1);
        let v1 = 0x2::allowance::funder(v0);
        assert!(v1 == 0x2::tx_context::sender(arg5), 13906835011862003713);
        let v2 = 0x2::allowance::spender(v0);
        assert!(0x1::option::contains<address>(&v2, &arg0.agent), 13906835016157102083);
        assert!(!0x1::vector::is_empty<address>(&arg2), 13906835020452200453);
        assert!(!0x1::vector::contains<address>(&arg2, &v1), 13906835024747298823);
        assert!(arg3 > 0, 13906835029042921489);
        0x2::allowance::issue<0x2::balance::Balance<T0>, APP>(arg1, 0x2::allowance::settings_permit<APP>(0x1::internal::permit<APP>()), arg5);
        let v3 = Mandate{
            id                  : 0x2::object::new(arg5),
            funder              : v1,
            group               : *0x2::allowance::name(v0),
            creditors           : 0x2::vec_set::from_keys<address>(arg2),
            max_per_debt        : arg3,
            objection_window_ms : arg4,
        };
        let v4 = MandateOpened{
            mandate             : 0x2::object::id<Mandate>(&v3),
            funder              : v1,
            group               : v3.group,
            creditors           : *0x2::vec_set::keys<address>(&v3.creditors),
            max_per_debt        : arg3,
            objection_window_ms : arg4,
        };
        0x2::event::emit<MandateOpened>(v4);
        0x2::transfer::share_object<Mandate>(v3);
    }

    public fun pullable_at_ms<T0>(arg0: &Debt<T0>, arg1: &Mandate) : u64 {
        arg0.recorded_at_ms + arg1.objection_window_ms
    }

    public fun record_debt<T0>(arg0: &Config, arg1: &Mandate, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.registrar, 13906835239495794697);
        assert!(!arg0.paused, 13906835243790893067);
        assert!(arg4 > 0, 13906835248086253585);
        assert!(arg4 <= arg1.max_per_debt, 13906835252381089807);
        assert!(0x2::vec_set::contains<address>(&arg1.creditors, &arg3), 13906835256675926029);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = Debt<T0>{
            id             : 0x2::object::new(arg6),
            mandate        : 0x2::object::id<Mandate>(arg1),
            group          : arg1.group,
            reference      : arg2,
            debtor         : arg1.funder,
            creditor       : arg3,
            amount         : arg4,
            recorded_at_ms : v0,
            status         : 0,
        };
        let v2 = DebtRecorded{
            debt           : 0x2::object::id<Debt<T0>>(&v1),
            mandate        : 0x2::object::id<Mandate>(arg1),
            reference      : v1.reference,
            debtor         : v1.debtor,
            creditor       : arg3,
            amount         : arg4,
            pullable_at_ms : v0 + arg1.objection_window_ms,
        };
        0x2::event::emit<DebtRecorded>(v2);
        0x2::transfer::share_object<Debt<T0>>(v1);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: address) {
        arg1.registrar = arg2;
        arg1.agent = arg3;
    }

    public fun status_cancelled() : u8 {
        3
    }

    public fun status_open() : u8 {
        0
    }

    public fun status_settled_by_allowance() : u8 {
        1
    }

    public fun status_settled_externally() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

