module 0xed5f41a6fbee72f2bc040275fd12c7c51ee5fcd28d4389f7d6977851bad675b5::pre_market {
    struct PRE_MARKET has drop {
        dummy_field: bool,
    }

    struct Market has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        active: bool,
        end_timestamp_ms: 0x1::option::Option<u64>,
        balance: 0x2::balance::Balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>,
    }

    struct Offer has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        filled: bool,
        creator: address,
    }

    public fun create_offer(arg0: 0x2::object::ID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Offer{
            id        : 0x2::object::new(arg2),
            market_id : arg0,
            filled    : false,
            creator   : arg1,
        };
        0x2::transfer::share_object<Offer>(v0);
    }

    fun init(arg0: PRE_MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PRE_MARKET>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = Market{
            id               : 0x2::object::new(arg1),
            name             : 0x1::string::utf8(b"Market"),
            active           : false,
            end_timestamp_ms : 0x1::option::none<u64>(),
            balance          : 0x2::balance::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(),
        };
        0x2::transfer::share_object<Market>(v0);
    }

    entry fun top_up_market(arg0: &mut Market, arg1: 0x2::coin::Coin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.balance, 0x2::coin::into_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg1));
    }

    entry fun widthdaw_market(arg0: &mut Market, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0x2::coin::from_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0x2::balance::withdraw_all<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.balance), arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

