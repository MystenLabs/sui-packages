module 0x6d7b711a5e614f99f87fdbfbf915fea0fa96af769130ac226c3cbcf07efb90f3::blacklist_rule {
    struct BlacklistRule has drop {
        dummy_field: bool,
    }

    struct Blacklist has key {
        id: 0x2::object::UID,
        managers: 0x2::vec_set::VecSet<address>,
        frozen_addresses: 0x2::vec_set::VecSet<address>,
    }

    public fun add_manager(arg0: &mut Blacklist, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun blacklist(arg0: &mut Blacklist, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: address) {
        if (!is_manager(arg0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1))) {
            err_sender_is_not_manager();
        };
        0x2::vec_set::insert<address>(&mut arg0.frozen_addresses, arg2);
    }

    public fun check<T0>(arg0: &Blacklist, arg1: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0>) {
        if (0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::memo<T0>(arg1) != 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::memo::liquidate() && is_blacklisted(arg0, 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::account<T0>(arg1))) {
            err_invalid_request();
        };
        let v0 = BlacklistRule{dummy_field: false};
        0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::add_witness<T0, BlacklistRule>(arg1, v0);
    }

    fun err_invalid_request() {
        abort 2
    }

    fun err_sender_is_not_manager() {
        abort 1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Blacklist{
            id               : 0x2::object::new(arg0),
            managers         : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            frozen_addresses : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<Blacklist>(v0);
    }

    public fun is_blacklisted(arg0: &Blacklist, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.frozen_addresses, &arg1)
    }

    public fun is_manager(arg0: &Blacklist, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.managers, &arg1)
    }

    public fun remove_manager(arg0: &mut Blacklist, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun unblacklist(arg0: &mut Blacklist, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.frozen_addresses, &arg2);
    }

    // decompiled from Move bytecode v6
}

