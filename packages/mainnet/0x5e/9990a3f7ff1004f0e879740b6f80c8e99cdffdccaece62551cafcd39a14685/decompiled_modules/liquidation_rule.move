module 0x5e9990a3f7ff1004f0e879740b6f80c8e99cdffdccaece62551cafcd39a14685::liquidation_rule {
    struct LiquidationRule has drop {
        dummy_field: bool,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        liquidators: 0x2::vec_set::VecSet<address>,
    }

    public fun add_liquidator(arg0: &mut Whitelist, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.liquidators, arg2);
    }

    fun err_invalid_liquidator() {
        abort 0
    }

    fun err_invalid_request() {
        abort 1
    }

    public fun fulfill_request<T0>(arg0: &Whitelist, arg1: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg2: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg3: &0x2::clock::Clock, arg4: 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::response::UpdateResponse<T0>) {
        let v0 = 0x2::tx_context::sender(arg5);
        if (!0x2::vec_set::contains<address>(&arg0.liquidators, &v0)) {
            err_invalid_liquidator();
        };
        if (0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::memo<T0>(&arg4) != 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::memo::liquidate()) {
            err_invalid_request();
        };
        let v1 = 0x1::option::none<0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>>();
        0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::update_position<T0>(arg1, arg2, arg3, &v1, arg4, arg5)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Whitelist{
            id          : 0x2::object::new(arg0),
            liquidators : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<Whitelist>(v0);
    }

    public fun liquidate<T0>(arg0: &Whitelist, arg1: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg2: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg3: &0x2::clock::Clock, arg4: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg5: address, arg6: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg7: &mut 0x2::tx_context::TxContext) : 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0> {
        let v0 = 0x2::tx_context::sender(arg7);
        if (!0x2::vec_set::contains<address>(&arg0.liquidators, &v0)) {
            err_invalid_liquidator();
        };
        let v1 = LiquidationRule{dummy_field: false};
        0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::liquidate<T0, LiquidationRule>(arg1, arg2, arg3, arg4, arg5, arg6, v1, arg7)
    }

    public fun remove_liquidator(arg0: &mut Whitelist, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.liquidators, &arg2);
    }

    // decompiled from Move bytecode v6
}

