module 0x108cc911a9ea0e310af0c257edb9797191c7b498c2e802085b831502e8193111::bounty_escrow {
    struct BOUNTY_ESCROW has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BountyRegistry has key {
        id: 0x2::object::UID,
        total_bounties: u64,
        total_volume: u64,
        total_paid_out: u64,
    }

    struct BountyEscrow has store, key {
        id: 0x2::object::UID,
        bounty_id: 0x1::string::String,
        creator: address,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        total_amount: u64,
        total_paid: u64,
        max_streamers: u8,
        status: u8,
        created_at: u64,
    }

    struct BountyCreated has copy, drop {
        bounty_id: 0x1::string::String,
        escrow_id: 0x2::object::ID,
        creator: address,
        total_amount: u64,
        max_streamers: u8,
        timestamp: u64,
    }

    struct PaymentReleased has copy, drop {
        bounty_id: 0x1::string::String,
        escrow_id: 0x2::object::ID,
        streamer: address,
        amount: u64,
        timestamp: u64,
    }

    struct BountyCancelled has copy, drop {
        bounty_id: 0x1::string::String,
        escrow_id: 0x2::object::ID,
        creator: address,
        refund_amount: u64,
        timestamp: u64,
    }

    struct BountyCompleted has copy, drop {
        bounty_id: 0x1::string::String,
        escrow_id: 0x2::object::ID,
        total_paid: u64,
        timestamp: u64,
    }

    public fun cancel_bounty(arg0: &mut BountyEscrow, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        assert!(arg0.status == 0, 2);
        arg0.status = 2;
        let v0 = BountyCancelled{
            bounty_id     : arg0.bounty_id,
            escrow_id     : 0x2::object::uid_to_inner(&arg0.id),
            creator       : arg0.creator,
            refund_amount : 0x2::balance::value<0x2::sui::SUI>(&arg0.funds),
            timestamp     : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<BountyCancelled>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.funds), arg2), arg0.creator);
    }

    public fun complete_bounty(arg0: &mut BountyEscrow, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        assert!(arg0.status == 0, 3);
        arg0.status = 1;
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.funds) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.funds), arg2), arg0.creator);
        };
        let v0 = BountyCompleted{
            bounty_id  : arg0.bounty_id,
            escrow_id  : 0x2::object::uid_to_inner(&arg0.id),
            total_paid : arg0.total_paid,
            timestamp  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<BountyCompleted>(v0);
    }

    public fun create_bounty(arg0: &mut BountyRegistry, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 4);
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = BountyEscrow{
            id            : v1,
            bounty_id     : arg1,
            creator       : 0x2::tx_context::sender(arg5),
            funds         : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            total_amount  : v0,
            total_paid    : 0,
            max_streamers : arg3,
            status        : 0,
            created_at    : 0x2::clock::timestamp_ms(arg4),
        };
        arg0.total_bounties = arg0.total_bounties + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v4 = BountyCreated{
            bounty_id     : v3.bounty_id,
            escrow_id     : v2,
            creator       : 0x2::tx_context::sender(arg5),
            total_amount  : v0,
            max_streamers : arg3,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BountyCreated>(v4);
        0x2::transfer::share_object<BountyEscrow>(v3);
        v2
    }

    public fun get_bounty_id(arg0: &BountyEscrow) : 0x1::string::String {
        arg0.bounty_id
    }

    public fun get_creator(arg0: &BountyEscrow) : address {
        arg0.creator
    }

    public fun get_max_streamers(arg0: &BountyEscrow) : u8 {
        arg0.max_streamers
    }

    public fun get_remaining_balance(arg0: &BountyEscrow) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public fun get_status(arg0: &BountyEscrow) : u8 {
        arg0.status
    }

    public fun get_total_amount(arg0: &BountyEscrow) : u64 {
        arg0.total_amount
    }

    public fun get_total_bounties(arg0: &BountyRegistry) : u64 {
        arg0.total_bounties
    }

    public fun get_total_paid(arg0: &BountyEscrow) : u64 {
        arg0.total_paid
    }

    public fun get_total_paid_out(arg0: &BountyRegistry) : u64 {
        arg0.total_paid_out
    }

    public fun get_total_volume(arg0: &BountyRegistry) : u64 {
        arg0.total_volume
    }

    fun init(arg0: BOUNTY_ESCROW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = BountyRegistry{
            id             : 0x2::object::new(arg1),
            total_bounties : 0,
            total_volume   : 0,
            total_paid_out : 0,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<BountyRegistry>(v1);
    }

    public fun is_active(arg0: &BountyEscrow) : bool {
        arg0.status == 0
    }

    public fun is_cancelled(arg0: &BountyEscrow) : bool {
        arg0.status == 2
    }

    public fun is_completed(arg0: &BountyEscrow) : bool {
        arg0.status == 1
    }

    public fun release_payment(arg0: &mut BountyRegistry, arg1: &mut BountyEscrow, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.creator, 1);
        assert!(arg1.status == 0, 2);
        assert!(arg2 != @0x0, 5);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.funds), 6);
        arg1.total_paid = arg1.total_paid + arg3;
        arg0.total_paid_out = arg0.total_paid_out + arg3;
        let v0 = PaymentReleased{
            bounty_id : arg1.bounty_id,
            escrow_id : 0x2::object::uid_to_inner(&arg1.id),
            streamer  : arg2,
            amount    : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PaymentReleased>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.funds, arg3), arg5), arg2);
    }

    // decompiled from Move bytecode v6
}

