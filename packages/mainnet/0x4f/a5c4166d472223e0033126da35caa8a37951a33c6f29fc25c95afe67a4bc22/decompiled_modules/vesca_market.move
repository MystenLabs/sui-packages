module 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market {
    struct Ordernft has store, key {
        id: 0x2::object::UID,
    }

    struct ListMarket<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        vested_tokens: 0x2::object_table::ObjectTable<address, T0>,
        prices: 0x2::table::Table<address, u64>,
    }

    struct OfferMarket has store, key {
        id: 0x2::object::UID,
        coin_table: 0x2::object_table::ObjectTable<address, 0x2::coin::Coin<0x2::sui::SUI>>,
        offer_list: 0x2::table::Table<address, address>,
    }

    struct MarketAdmin has key {
        id: 0x2::object::UID,
    }

    public(friend) fun add_price_to_listmarket<T0: store + key>(arg0: &mut ListMarket<T0>, arg1: address, arg2: u64) {
        0x2::table::add<address, u64>(&mut arg0.prices, arg1, arg2);
    }

    public(friend) fun cancel_offer_in_offermarket(arg0: &mut OfferMarket, arg1: address) : (0x2::coin::Coin<0x2::sui::SUI>, address) {
        (0x2::object_table::remove<address, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.coin_table, arg1), 0x2::table::remove<address, address>(&mut arg0.offer_list, arg1))
    }

    public(friend) fun change_price_in_listmarket<T0: store + key>(arg0: &mut ListMarket<T0>, arg1: address, arg2: u64) {
        *0x2::table::borrow_mut<address, u64>(&mut arg0.prices, arg1) = arg2;
    }

    public entry fun create_market<T0: store + key>(arg0: &MarketAdmin, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ListMarket<T0>{
            id            : 0x2::object::new(arg1),
            vested_tokens : 0x2::object_table::new<address, T0>(arg1),
            prices        : 0x2::table::new<address, u64>(arg1),
        };
        let v1 = OfferMarket{
            id         : 0x2::object::new(arg1),
            coin_table : 0x2::object_table::new<address, 0x2::coin::Coin<0x2::sui::SUI>>(arg1),
            offer_list : 0x2::table::new<address, address>(arg1),
        };
        0x2::transfer::public_share_object<ListMarket<T0>>(v0);
        0x2::transfer::public_share_object<OfferMarket>(v1);
    }

    public(friend) fun create_order_nft(arg0: &mut 0x2::tx_context::TxContext) : Ordernft {
        Ordernft{id: 0x2::object::new(arg0)}
    }

    public(friend) fun delete_ordernft(arg0: Ordernft) {
        let Ordernft { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun delete_price_in_listmarket<T0: store + key>(arg0: &mut ListMarket<T0>, arg1: address) {
        0x2::table::remove<address, u64>(&mut arg0.prices, arg1);
    }

    public(friend) fun get_price_in_listmarket<T0: store + key>(arg0: &ListMarket<T0>, arg1: address) : &u64 {
        0x2::table::borrow<address, u64>(&arg0.prices, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MarketAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun list_order_in_listmarket<T0: store + key>(arg0: &mut ListMarket<T0>, arg1: address, arg2: T0) {
        0x2::object_table::add<address, T0>(&mut arg0.vested_tokens, arg1, arg2);
    }

    public(friend) fun make_offer_in_offermarket(arg0: &mut OfferMarket, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address) {
        0x2::object_table::add<address, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.coin_table, arg1, arg2);
        0x2::table::add<address, address>(&mut arg0.offer_list, arg1, arg3);
    }

    public(friend) fun unlist_order_in_listmarket<T0: store + key>(arg0: &mut ListMarket<T0>, arg1: address) : T0 {
        0x2::object_table::remove<address, T0>(&mut arg0.vested_tokens, arg1)
    }

    // decompiled from Move bytecode v6
}

