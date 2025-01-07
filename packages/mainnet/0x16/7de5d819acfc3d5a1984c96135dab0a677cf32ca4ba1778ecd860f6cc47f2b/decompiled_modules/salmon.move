module 0x167de5d819acfc3d5a1984c96135dab0a677cf32ca4ba1778ecd860f6cc47f2b::salmon {
    struct SALMON has drop {
        dummy_field: bool,
    }

    struct TreasuryCapability has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<SALMON>,
    }

    struct PrizePool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<SALMON>,
        owner: address,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
    }

    public entry fun burn(arg0: &mut TreasuryCapability, arg1: 0x2::coin::Coin<SALMON>) {
        0x2::coin::burn<SALMON>(&mut arg0.cap, arg1);
        let v0 = BurnEvent{amount: 0x2::coin::value<SALMON>(&arg1)};
        0x2::event::emit<BurnEvent>(v0);
    }

    public entry fun transfer(arg0: &mut TreasuryCapability, arg1: &mut 0x2::coin::Coin<SALMON>, arg2: address, arg3: u64, arg4: &mut PrizePool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 0x2::coin::total_supply<SALMON>(&arg0.cap) * 5 / 1000, 0);
        let v0 = arg3 * 2 / 100;
        let v1 = arg3 * 1 / 100;
        0x2::coin::put<SALMON>(&mut arg4.balance, 0x2::coin::split<SALMON>(arg1, v0, arg5));
        0x2::coin::burn<SALMON>(&mut arg0.cap, 0x2::coin::split<SALMON>(arg1, v1, arg5));
        let v2 = BurnEvent{amount: v1};
        0x2::event::emit<BurnEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SALMON>>(0x2::coin::split<SALMON>(arg1, arg3 - v0 - v1, arg5), arg2);
    }

    public fun get_prize_pool_balance(arg0: &PrizePool) : u64 {
        0x2::balance::value<SALMON>(&arg0.balance)
    }

    fun init(arg0: SALMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALMON>(arg0, 9, b"SILLY", b"Silly Salmon", b"The splashiest meme token on the SUI network!", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = TreasuryCapability{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        let v3 = PrizePool{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<SALMON>(),
            owner   : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALMON>>(v1);
        0x2::transfer::share_object<TreasuryCapability>(v2);
        0x2::transfer::share_object<PrizePool>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<SALMON>>(0x2::coin::mint<SALMON>(&mut v2.cap, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun withdraw_prize(arg0: &mut PrizePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SALMON>>(0x2::coin::take<SALMON>(&mut arg0.balance, arg1, arg2), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

