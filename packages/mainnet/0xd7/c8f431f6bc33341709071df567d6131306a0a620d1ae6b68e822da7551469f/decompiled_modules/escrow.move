module 0x2fdd0d55cc103ff1038e03a4b6090e3f5247c723e0d28da07b0595bdecd513cb::escrow {
    struct BackendCap has store, key {
        id: 0x2::object::UID,
    }

    struct SurveyEscrow<phantom T0> has key {
        id: 0x2::object::UID,
        survey_key: vector<u8>,
        creator: address,
        funds: 0x2::balance::Balance<T0>,
        total_funded: u64,
        distributed: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        escrow_id: 0x2::object::ID,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        survey_key: vector<u8>,
        creator: address,
        amount: u64,
    }

    struct EscrowToppedUp has copy, drop {
        escrow_id: 0x2::object::ID,
        amount: u64,
        new_total_funded: u64,
    }

    struct RewardReleased has copy, drop {
        escrow_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        remaining: u64,
    }

    struct EscrowClosed has copy, drop {
        escrow_id: 0x2::object::ID,
        refunded_to: address,
        refund_amount: u64,
        distributed: u64,
    }

    public fun close_escrow<T0>(arg0: &mut SurveyEscrow<T0>, arg1: AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let AdminCap {
            id        : v0,
            escrow_id : v1,
        } = arg1;
        assert!(v1 == 0x2::object::id<SurveyEscrow<T0>>(arg0), 2);
        0x2::object::delete(v0);
        let v2 = 0x2::balance::value<T0>(&arg0.funds);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v2), arg2), arg0.creator);
        let v3 = EscrowClosed{
            escrow_id     : 0x2::object::id<SurveyEscrow<T0>>(arg0),
            refunded_to   : arg0.creator,
            refund_amount : v2,
            distributed   : arg0.distributed,
        };
        0x2::event::emit<EscrowClosed>(v3);
    }

    public fun create_escrow<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 3);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = SurveyEscrow<T0>{
            id           : 0x2::object::new(arg2),
            survey_key   : arg1,
            creator      : v1,
            funds        : 0x2::coin::into_balance<T0>(arg0),
            total_funded : v0,
            distributed  : 0,
        };
        let v3 = 0x2::object::id<SurveyEscrow<T0>>(&v2);
        let v4 = EscrowCreated{
            escrow_id  : v3,
            survey_key : v2.survey_key,
            creator    : v1,
            amount     : v0,
        };
        0x2::event::emit<EscrowCreated>(v4);
        let v5 = AdminCap{
            id        : 0x2::object::new(arg2),
            escrow_id : v3,
        };
        0x2::transfer::share_object<SurveyEscrow<T0>>(v2);
        v5
    }

    public fun create_escrow_and_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create_escrow<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun creator<T0>(arg0: &SurveyEscrow<T0>) : address {
        arg0.creator
    }

    public fun distributed<T0>(arg0: &SurveyEscrow<T0>) : u64 {
        arg0.distributed
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BackendCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<BackendCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun release_reward<T0>(arg0: &BackendCap, arg1: &mut SurveyEscrow<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 3);
        assert!(0x2::balance::value<T0>(&arg1.funds) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.funds, arg3), arg4), arg2);
        arg1.distributed = arg1.distributed + arg3;
        let v0 = RewardReleased{
            escrow_id : 0x2::object::id<SurveyEscrow<T0>>(arg1),
            recipient : arg2,
            amount    : arg3,
            remaining : 0x2::balance::value<T0>(&arg1.funds),
        };
        0x2::event::emit<RewardReleased>(v0);
    }

    public fun remaining<T0>(arg0: &SurveyEscrow<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun survey_key<T0>(arg0: &SurveyEscrow<T0>) : vector<u8> {
        arg0.survey_key
    }

    public fun top_up<T0>(arg0: &mut SurveyEscrow<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_funded = arg0.total_funded + v0;
        let v1 = EscrowToppedUp{
            escrow_id        : 0x2::object::id<SurveyEscrow<T0>>(arg0),
            amount           : v0,
            new_total_funded : arg0.total_funded,
        };
        0x2::event::emit<EscrowToppedUp>(v1);
    }

    public fun total_funded<T0>(arg0: &SurveyEscrow<T0>) : u64 {
        arg0.total_funded
    }

    // decompiled from Move bytecode v7
}

