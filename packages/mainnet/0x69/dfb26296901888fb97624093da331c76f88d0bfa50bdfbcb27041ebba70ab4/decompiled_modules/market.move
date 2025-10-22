module 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::market {
    struct Market<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        reserves: vector<address>,
        reserve_infos: 0x2::table::Table<address, 0x1::string::String>,
        user_registry: 0x2::table::Table<address, address>,
    }

    struct NewMarketEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    public(friend) fun id<T0>(arg0: &Market<T0>) : address {
        let v0 = 0x2::object::id<Market<T0>>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public(friend) fun new<T0>(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Market<T0> {
        let v0 = Market<T0>{
            id            : 0x2::object::new(arg1),
            name          : arg0,
            reserves      : 0x1::vector::empty<address>(),
            reserve_infos : 0x2::table::new<address, 0x1::string::String>(arg1),
            user_registry : 0x2::table::new<address, address>(arg1),
        };
        let v1 = NewMarketEvent{
            id   : 0x2::object::id<Market<T0>>(&v0),
            name : v0.name,
        };
        0x2::event::emit<NewMarketEvent>(v1);
        v0
    }

    public(friend) fun add_reserve<T0, T1>(arg0: &mut Market<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>) {
        let v0 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        0x1::vector::push_back<address>(&mut arg0.reserves, v1);
        0x2::table::add<address, 0x1::string::String>(&mut arg0.reserve_infos, v1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T0>());
    }

    public(friend) fun add_user_obligation<T0>(arg0: &mut Market<T0>, arg1: address, arg2: address) {
        0x2::table::add<address, address>(&mut arg0.user_registry, arg1, arg2);
    }

    public fun public_share<T0>(arg0: Market<T0>) {
        0x2::transfer::public_share_object<Market<T0>>(arg0);
    }

    public(friend) fun remove_user_obligation<T0>(arg0: &mut Market<T0>, arg1: address) {
        0x2::table::remove<address, address>(&mut arg0.user_registry, arg1);
    }

    // decompiled from Move bytecode v6
}

