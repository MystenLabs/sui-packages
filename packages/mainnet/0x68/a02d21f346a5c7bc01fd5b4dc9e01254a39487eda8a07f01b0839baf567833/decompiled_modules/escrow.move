module 0x68a02d21f346a5c7bc01fd5b4dc9e01254a39487eda8a07f01b0839baf567833::escrow {
    struct HouseCap has store, key {
        id: 0x2::object::UID,
        house: address,
    }

    struct SeatEscrow has key {
        id: 0x2::object::UID,
        table_id: vector<u8>,
        player: address,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        buy_in: u64,
        created_epoch: u64,
    }

    struct BuyInEvent has copy, drop {
        escrow: 0x2::object::ID,
        table_id: vector<u8>,
        player: address,
        amount: u64,
    }

    struct SettleEvent has copy, drop {
        escrow: 0x2::object::ID,
        table_id: vector<u8>,
        player: address,
        to_player: u64,
        to_house: u64,
    }

    struct ReclaimEvent has copy, drop {
        escrow: 0x2::object::ID,
        player: address,
        amount: u64,
    }

    public fun amount(arg0: &SeatEscrow) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public fun buy_in(arg0: vector<u8>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = SeatEscrow{
            id            : 0x2::object::new(arg2),
            table_id      : arg0,
            player        : 0x2::tx_context::sender(arg2),
            funds         : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            buy_in        : v0,
            created_epoch : 0x2::tx_context::epoch(arg2),
        };
        let v2 = BuyInEvent{
            escrow   : 0x2::object::id<SeatEscrow>(&v1),
            table_id : v1.table_id,
            player   : v1.player,
            amount   : v0,
        };
        0x2::event::emit<BuyInEvent>(v2);
        0x2::transfer::share_object<SeatEscrow>(v1);
    }

    public fun buy_in_amount(arg0: &SeatEscrow) : u64 {
        arg0.buy_in
    }

    public fun house(arg0: &HouseCap) : address {
        arg0.house
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseCap{
            id    : 0x2::object::new(arg0),
            house : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_transfer<HouseCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun player(arg0: &SeatEscrow) : address {
        arg0.player
    }

    public fun reclaim(arg0: SeatEscrow, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.player, 3);
        assert!(0x2::tx_context::epoch(arg1) >= arg0.created_epoch + 3, 2);
        let SeatEscrow {
            id            : v0,
            table_id      : _,
            player        : v2,
            funds         : v3,
            buy_in        : _,
            created_epoch : _,
        } = arg0;
        let v6 = v3;
        let v7 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg1), v2);
        let v8 = ReclaimEvent{
            escrow : 0x2::object::uid_to_inner(&v7),
            player : v2,
            amount : 0x2::balance::value<0x2::sui::SUI>(&v6),
        };
        0x2::event::emit<ReclaimEvent>(v8);
        0x2::object::delete(v7);
    }

    public fun settle(arg0: &HouseCap, arg1: SeatEscrow, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.house == 0x2::tx_context::sender(arg3), 0);
        let SeatEscrow {
            id            : v0,
            table_id      : v1,
            player        : v2,
            funds         : v3,
            buy_in        : _,
            created_epoch : _,
        } = arg1;
        let v6 = v3;
        let v7 = v0;
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&v6), 1);
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v6, arg2), arg3), v2);
        };
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&v6);
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg3), arg0.house);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
        };
        let v9 = SettleEvent{
            escrow    : 0x2::object::uid_to_inner(&v7),
            table_id  : v1,
            player    : v2,
            to_player : arg2,
            to_house  : v8,
        };
        0x2::event::emit<SettleEvent>(v9);
        0x2::object::delete(v7);
    }

    public fun table_id(arg0: &SeatEscrow) : vector<u8> {
        arg0.table_id
    }

    // decompiled from Move bytecode v7
}

