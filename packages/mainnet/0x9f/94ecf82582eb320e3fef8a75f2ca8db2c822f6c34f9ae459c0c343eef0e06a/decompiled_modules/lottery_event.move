module 0x9f94ecf82582eb320e3fef8a75f2ca8db2c822f6c34f9ae459c0c343eef0e06a::lottery_event {
    struct UserBuyTicket has copy, drop {
        lottery_id: 0x2::object::ID,
        lottery_no: u64,
        user: address,
        amount: u64,
    }

    struct GenerateTicket has copy, drop {
        lottery_id: 0x2::object::ID,
        lottery_no: u64,
        ticket_id: 0x2::object::ID,
        user: address,
    }

    struct InvalidTicketNumber has copy, drop {
        lottery_id: 0x2::object::ID,
        lottery_no: u64,
        ticket_id: 0x2::object::ID,
        ticket_nos: vector<0x1::string::String>,
        user: address,
        refund_amount: u64,
    }

    struct WinTicket has copy, drop {
        lottery_id: 0x2::object::ID,
        lottery_no: u64,
        reward: u256,
        reward_coin_type: 0x1::ascii::String,
        ticket_id: 0x2::object::ID,
        ticket_no: 0x1::string::String,
    }

    struct LotteryStart has copy, drop {
        lottery_id: 0x2::object::ID,
        lottery_no: u64,
        user_count: u64,
    }

    struct RewardClaimable has copy, drop {
        asset_coin_type: 0x1::ascii::String,
        reward_coin_type: 0x1::ascii::String,
        user_claimable_reward: u256,
        user_claimed_reward: u256,
    }

    public(friend) fun emit_generate_ticket(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: address) {
        let v0 = GenerateTicket{
            lottery_id : arg0,
            lottery_no : arg1,
            ticket_id  : arg2,
            user       : arg3,
        };
        0x2::event::emit<GenerateTicket>(v0);
    }

    public(friend) fun emit_lottery_start(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = LotteryStart{
            lottery_id : arg0,
            lottery_no : arg1,
            user_count : arg2,
        };
        0x2::event::emit<LotteryStart>(v0);
    }

    public(friend) fun emit_reward_claimable(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: u256, arg3: u256) {
        let v0 = RewardClaimable{
            asset_coin_type       : arg0,
            reward_coin_type      : arg1,
            user_claimable_reward : arg2,
            user_claimed_reward   : arg3,
        };
        0x2::event::emit<RewardClaimable>(v0);
    }

    public(friend) fun emit_ticket_number_invalid(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: vector<0x1::string::String>, arg4: address, arg5: u64) {
        let v0 = InvalidTicketNumber{
            lottery_id    : arg0,
            lottery_no    : arg1,
            ticket_id     : arg2,
            ticket_nos    : arg3,
            user          : arg4,
            refund_amount : arg5,
        };
        0x2::event::emit<InvalidTicketNumber>(v0);
    }

    public(friend) fun emit_user_buy_ticket(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64) {
        let v0 = UserBuyTicket{
            lottery_id : arg0,
            lottery_no : arg1,
            user       : arg2,
            amount     : arg3,
        };
        0x2::event::emit<UserBuyTicket>(v0);
    }

    public(friend) fun emit_win_ticket(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: 0x1::ascii::String, arg4: 0x2::object::ID, arg5: 0x1::string::String) {
        let v0 = WinTicket{
            lottery_id       : arg0,
            lottery_no       : arg1,
            reward           : arg2,
            reward_coin_type : arg3,
            ticket_id        : arg4,
            ticket_no        : arg5,
        };
        0x2::event::emit<WinTicket>(v0);
    }

    // decompiled from Move bytecode v6
}

