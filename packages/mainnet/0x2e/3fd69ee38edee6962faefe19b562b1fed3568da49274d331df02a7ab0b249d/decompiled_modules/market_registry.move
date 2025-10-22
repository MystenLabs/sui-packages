module 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::market_registry {
    struct MarketRegistry has store, key {
        id: 0x2::object::UID,
        markets: vector<address>,
        market_infos: 0x2::table::Table<address, 0x1::string::String>,
    }

    public(friend) fun add_market<T0>(arg0: &mut MarketRegistry, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::market::Market<T0>) {
        let v0 = 0x2::object::id<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::market::Market<T0>>(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        0x1::vector::push_back<address>(&mut arg0.markets, v1);
        0x2::table::add<address, 0x1::string::String>(&mut arg0.market_infos, v1, 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::utils::get_type<T0>());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketRegistry{
            id           : 0x2::object::new(arg0),
            markets      : 0x1::vector::empty<address>(),
            market_infos : 0x2::table::new<address, 0x1::string::String>(arg0),
        };
        0x2::transfer::public_share_object<MarketRegistry>(v0);
    }

    // decompiled from Move bytecode v6
}

