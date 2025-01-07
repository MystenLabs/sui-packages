module 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::bid {
    struct Bid<phantom T0> has store, key {
        id: 0x2::object::UID,
        item_id: 0x2::object::ID,
        bidder: address,
        funds: 0x2::coin::Coin<T0>,
    }

    struct BidMarketplace has key {
        id: 0x2::object::UID,
        beneficiary: address,
        fee: u64,
    }

    public entry fun accept_bid<T0: store + key, T1>(arg0: &BidMarketplace, arg1: T0, arg2: &mut Bid<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<T0>(&arg1) == arg2.item_id, 0);
        let v0 = 0x2::coin::value<T1>(&arg2.funds);
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::bid_event::bid_complete_event(0x2::object::id<T0>(&arg1), 0x2::object::id<Bid<T1>>(arg2), 0x2::tx_context::sender(arg3), v0);
        0x2::transfer::public_transfer<T0>(arg1, arg2.bidder);
        let v1 = v0 * arg0.fee / 10000;
        0x2::pay::split_and_transfer<T1>(&mut arg2.funds, v1, arg0.beneficiary, arg3);
        0x2::pay::split_and_transfer<T1>(&mut arg2.funds, v0 - v1, 0x2::tx_context::sender(arg3), arg3);
    }

    public entry fun accept_bid_from_market<T0: store + key, T1>(arg0: &BidMarketplace, arg1: &mut 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::market::Marketplace<T1>, arg2: 0x2::object::ID, arg3: &mut Bid<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::market::delist<T0, T1>(arg1, arg2, arg4);
        accept_bid<T0, T1>(arg0, v0, arg3, arg4);
    }

    public entry fun add_bid_price<T0>(arg0: &mut Bid<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.bidder == 0x2::tx_context::sender(arg2), 4);
        0x2::pay::join<T0>(&mut arg0.funds, arg1);
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::bid_event::change_bid_price_event(0x2::object::id<Bid<T0>>(arg0), arg0.item_id, 0x2::tx_context::sender(arg2), 0x2::coin::value<T0>(&arg0.funds));
    }

    public entry fun cancel_bid<T0>(arg0: &mut Bid<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.bidder == 0x2::tx_context::sender(arg1), 4);
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::bid_event::bid_cancel_event(arg0.item_id, 0x2::object::id<Bid<T0>>(arg0), 0x2::tx_context::sender(arg1));
        0x2::pay::split_and_transfer<T0>(&mut arg0.funds, 0x2::coin::value<T0>(&arg0.funds), 0x2::tx_context::sender(arg1), arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BidMarketplace{
            id          : 0x2::object::new(arg0),
            beneficiary : 0x2::tx_context::sender(arg0),
            fee         : 0,
        };
        0x2::transfer::share_object<BidMarketplace>(v0);
    }

    public entry fun modify_ob_market(arg0: &mut BidMarketplace, arg1: address, arg2: u64) {
        assert!(arg2 < 10000, 6);
        arg0.fee = arg2;
        arg0.beneficiary = arg1;
    }

    public entry fun new_bid<T0>(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Bid<T0>{
            id      : 0x2::object::new(arg2),
            item_id : arg0,
            bidder  : 0x2::tx_context::sender(arg2),
            funds   : arg1,
        };
        0x2::transfer::public_share_object<Bid<T0>>(v0);
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::bid_event::new_bid_event(0x2::object::id<Bid<T0>>(&v0), arg0, 0x2::tx_context::sender(arg2), 0x2::coin::value<T0>(&arg1));
    }

    public entry fun reduce_bid_price<T0>(arg0: &mut Bid<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.bidder == v0, 4);
        0x2::pay::split_and_transfer<T0>(&mut arg0.funds, arg1, v0, arg2);
        0x9fd90ae353953fb1215e4bf70e0399042bdd5f4540abb9e61ca464cf17e6c93f::bid_event::change_bid_price_event(0x2::object::id<Bid<T0>>(arg0), arg0.item_id, v0, 0x2::coin::value<T0>(&arg0.funds));
    }

    // decompiled from Move bytecode v6
}

