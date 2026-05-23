module 0xf049735288589be6a21e49f2ec9d9cea21c9a8c68cdda9fb7c03271f7954ee53::gnv_vesting {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventClaimed has copy, drop {
        beneficiary: address,
        amount: u64,
        total_claimed: u64,
    }

    struct EventBeneficiaryProposed has copy, drop {
        old_beneficiary: address,
        new_beneficiary: address,
        unlock_ms: u64,
    }

    struct EventBeneficiaryConfirmed has copy, drop {
        old_beneficiary: address,
        new_beneficiary: address,
    }

    struct EventTGESet has copy, drop {
        tge_timestamp_ms: u64,
    }

    struct VestingState has key {
        id: 0x2::object::UID,
        total_amount: u64,
        claimed: u64,
        tge_amount: u64,
        tge_timestamp_ms: u64,
        beneficiary: address,
        balance: 0x2::balance::Balance<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>,
        pending_beneficiary: 0x1::option::Option<address>,
        beneficiary_unlock_ms: u64,
    }

    public fun admin_force_tge(arg0: &AdminCap, arg1: &mut VestingState, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.tge_timestamp_ms == 0 || v0 < arg1.tge_timestamp_ms, 11);
        assert!(arg2 > v0, 8);
        arg1.tge_timestamp_ms = arg2;
        let v1 = EventTGESet{tge_timestamp_ms: arg2};
        0x2::event::emit<EventTGESet>(v1);
    }

    public fun beneficiary(arg0: &VestingState) : address {
        arg0.beneficiary
    }

    public fun beneficiary_unlock_ms(arg0: &VestingState) : u64 {
        arg0.beneficiary_unlock_ms
    }

    public fun calc_claimable(arg0: &VestingState, arg1: u64) : u64 {
        if (arg0.tge_timestamp_ms == 0 || arg1 < arg0.tge_timestamp_ms) {
            return 0
        };
        let v0 = arg1 - arg0.tge_timestamp_ms;
        let v1 = if (v0 >= 15778800000 + 47336400000) {
            arg0.total_amount
        } else if (v0 < 15778800000) {
            arg0.tge_amount
        } else {
            arg0.tge_amount + ((((arg0.total_amount - arg0.tge_amount) as u128) * ((v0 - 15778800000) as u128) / (47336400000 as u128)) as u64)
        };
        if (v1 > arg0.claimed) {
            v1 - arg0.claimed
        } else {
            0
        }
    }

    public entry fun cancel_pending_beneficiary(arg0: &AdminCap, arg1: &mut VestingState) {
        assert!(0x1::option::is_some<address>(&arg1.pending_beneficiary), 6);
        0x1::option::extract<address>(&mut arg1.pending_beneficiary);
        arg1.beneficiary_unlock_ms = 0;
    }

    public entry fun claim(arg0: &mut VestingState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 2);
        let v0 = calc_claimable(arg0, 0x2::clock::timestamp_ms(arg1));
        assert!(v0 > 0, 4);
        arg0.claimed = arg0.claimed + v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>>(0x2::coin::from_balance<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(0x2::balance::split<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&mut arg0.balance, v0), arg2), arg0.beneficiary);
        let v1 = EventClaimed{
            beneficiary   : arg0.beneficiary,
            amount        : v0,
            total_claimed : arg0.claimed,
        };
        0x2::event::emit<EventClaimed>(v1);
    }

    public fun claimed(arg0: &VestingState) : u64 {
        arg0.claimed
    }

    public entry fun confirm_beneficiary(arg0: &AdminCap, arg1: &mut VestingState, arg2: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<address>(&arg1.pending_beneficiary), 6);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.beneficiary_unlock_ms, 7);
        let v0 = 0x1::option::extract<address>(&mut arg1.pending_beneficiary);
        arg1.beneficiary = v0;
        arg1.beneficiary_unlock_ms = 0;
        let v1 = EventBeneficiaryConfirmed{
            old_beneficiary : arg1.beneficiary,
            new_beneficiary : v0,
        };
        0x2::event::emit<EventBeneficiaryConfirmed>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize(arg0: &AdminCap, arg1: 0x2::coin::Coin<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&arg1);
        assert!(v0 > 0, 5);
        let v1 = VestingState{
            id                    : 0x2::object::new(arg4),
            total_amount          : v0,
            claimed               : 0,
            tge_amount            : v0 / 10000 * 1000,
            tge_timestamp_ms      : arg3,
            beneficiary           : arg2,
            balance               : 0x2::coin::into_balance<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(arg1),
            pending_beneficiary   : 0x1::option::none<address>(),
            beneficiary_unlock_ms : 0,
        };
        0x2::transfer::share_object<VestingState>(v1);
    }

    public fun pending_beneficiary(arg0: &VestingState) : 0x1::option::Option<address> {
        arg0.pending_beneficiary
    }

    public entry fun propose_beneficiary(arg0: &AdminCap, arg1: &mut VestingState, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(0x1::option::is_none<address>(&arg1.pending_beneficiary), 9);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 604800000;
        arg1.pending_beneficiary = 0x1::option::some<address>(arg2);
        arg1.beneficiary_unlock_ms = v0;
        let v1 = EventBeneficiaryProposed{
            old_beneficiary : arg1.beneficiary,
            new_beneficiary : arg2,
            unlock_ms       : v0,
        };
        0x2::event::emit<EventBeneficiaryProposed>(v1);
    }

    public fun set_tge(arg0: &AdminCap, arg1: &mut VestingState, arg2: u64) {
        assert!(arg1.tge_timestamp_ms == 0, 10);
        arg1.tge_timestamp_ms = arg2;
        let v0 = EventTGESet{tge_timestamp_ms: arg2};
        0x2::event::emit<EventTGESet>(v0);
    }

    public fun tge_timestamp_ms(arg0: &VestingState) : u64 {
        arg0.tge_timestamp_ms
    }

    public fun total_amount(arg0: &VestingState) : u64 {
        arg0.total_amount
    }

    // decompiled from Move bytecode v7
}

