module 0x923f7af12f2e94b104f198d8c017423890f1057df2e5e605a85bb349649eea4c::auction_lib {
    struct BidData has store {
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        highest_bidder: address,
    }

    struct Auction<T0: store + key> has key {
        id: 0x2::object::UID,
        to_sell: 0x1::option::Option<T0>,
        owner: address,
        bid_data: 0x1::option::Option<BidData>,
    }

    public fun transfer<T0: store + key>(arg0: Auction<T0>, arg1: address) {
        0x2::transfer::transfer<Auction<T0>>(arg0, arg1);
    }

    public fun share_object<T0: store + key>(arg0: Auction<T0>) {
        0x2::transfer::share_object<Auction<T0>>(arg0);
    }

    public(friend) fun auction_owner<T0: store + key>(arg0: &Auction<T0>) : address {
        arg0.owner
    }

    public(friend) fun create_auction<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : Auction<T0> {
        Auction<T0>{
            id       : 0x2::object::new(arg1),
            to_sell  : 0x1::option::some<T0>(arg0),
            owner    : 0x2::tx_context::sender(arg1),
            bid_data : 0x1::option::none<BidData>(),
        }
    }

    public fun end_and_destroy_auction<T0: store + key>(arg0: Auction<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let Auction {
            id       : v0,
            to_sell  : v1,
            owner    : v2,
            bid_data : v3,
        } = arg0;
        let v4 = v3;
        let v5 = v1;
        0x2::object::delete(v0);
        let v6 = &mut v5;
        let v7 = &mut v4;
        end_auction<T0>(v6, v2, v7, arg1);
        0x1::option::destroy_none<BidData>(v4);
        0x1::option::destroy_none<T0>(v5);
    }

    fun end_auction<T0: store + key>(arg0: &mut 0x1::option::Option<T0>, arg1: address, arg2: &mut 0x1::option::Option<BidData>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<BidData>(arg2)) {
            let BidData {
                funds          : v0,
                highest_bidder : v1,
            } = 0x1::option::extract<BidData>(arg2);
            send_balance(v0, arg1, arg3);
            0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(arg0), v1);
        } else {
            0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(arg0), arg1);
        };
    }

    public fun end_shared_auction<T0: store + key>(arg0: &mut Auction<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.to_sell;
        let v1 = &mut arg0.bid_data;
        end_auction<T0>(v0, arg0.owner, v1, arg1);
    }

    fun send_balance(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg2), arg1);
    }

    public fun update_auction<T0: store + key>(arg0: &mut Auction<T0>, arg1: address, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<BidData>(&arg0.bid_data)) {
            let v0 = BidData{
                funds          : arg2,
                highest_bidder : arg1,
            };
            0x1::option::fill<BidData>(&mut arg0.bid_data, v0);
        } else if (0x2::balance::value<0x2::sui::SUI>(&arg2) > 0x2::balance::value<0x2::sui::SUI>(&0x1::option::borrow<BidData>(&arg0.bid_data).funds)) {
            let v1 = BidData{
                funds          : arg2,
                highest_bidder : arg1,
            };
            let BidData {
                funds          : v2,
                highest_bidder : v3,
            } = 0x1::option::swap<BidData>(&mut arg0.bid_data, v1);
            send_balance(v2, v3, arg3);
        } else {
            send_balance(arg2, arg1, arg3);
        };
    }

    // decompiled from Move bytecode v6
}

