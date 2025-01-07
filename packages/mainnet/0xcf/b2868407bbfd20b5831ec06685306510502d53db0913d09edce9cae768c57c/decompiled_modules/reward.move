module 0xcfb2868407bbfd20b5831ec06685306510502d53db0913d09edce9cae768c57c::reward {
    struct ExecuteCap has key {
        id: 0x2::object::UID,
    }

    struct REWARD has drop {
        dummy_field: bool,
    }

    struct ClaimBridgeNFTEvent has copy, drop {
        item_id: 0x2::object::ID,
        recipient: address,
    }

    struct WinnerLottery has copy, drop {
        turn_lottery_id: 0x1::string::String,
        recipient: address,
        number: u64,
    }

    struct BuyTicket has copy, drop {
        turn_lottery_id: 0x1::string::String,
        ticket_number: u64,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        pool_recipient: address,
    }

    struct RewardWinnerTicket has copy, drop {
        turn_lottery_id: 0x1::string::String,
        ticket_id: 0x1::string::String,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        recipient: address,
        type: u8,
    }

    public entry fun buy_ticket<T0: drop>(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg2, arg3, arg5), arg4);
        let v0 = BuyTicket{
            turn_lottery_id : arg0,
            ticket_number   : arg1,
            amount          : arg3,
            coin_type       : 0x1::type_name::get<T0>(),
            pool_recipient  : arg4,
        };
        0x2::event::emit<BuyTicket>(v0);
    }

    public entry fun claim_bridge_nft<T0: store + key>(arg0: &mut ExecuteCap, arg1: T0, arg2: address) {
        let v0 = ClaimBridgeNFTEvent{
            item_id   : 0x2::object::id<T0>(&arg1),
            recipient : arg2,
        };
        0x2::event::emit<ClaimBridgeNFTEvent>(v0);
        simple_transfer<T0>(arg1, arg2);
    }

    fun init(arg0: REWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecuteCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ExecuteCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<REWARD>(arg0, arg1);
    }

    public entry fun reward_winner_lottery(arg0: &mut ExecuteCap, arg1: 0x1::string::String, arg2: address, arg3: u64) {
        let v0 = WinnerLottery{
            turn_lottery_id : arg1,
            recipient       : arg2,
            number          : arg3,
        };
        0x2::event::emit<WinnerLottery>(v0);
    }

    public entry fun reward_winner_ticket<T0: drop>(arg0: &mut ExecuteCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg4, arg5, arg7), arg3);
        let v0 = RewardWinnerTicket{
            turn_lottery_id : arg1,
            ticket_id       : arg2,
            amount          : arg5,
            coin_type       : 0x1::type_name::get<T0>(),
            recipient       : arg3,
            type            : arg6,
        };
        0x2::event::emit<RewardWinnerTicket>(v0);
    }

    public entry fun simple_transfer<T0: store + key>(arg0: T0, arg1: address) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

