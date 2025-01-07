module 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::operator {
    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    public entry fun create_round<T0>(arg0: &OperatorCap, arg1: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::Version, arg2: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::State, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::assert_current_version(arg1);
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::add<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundInfo<T0>>(arg2, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::new_round_key<T0>(), 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::new<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public entry fun distribute_ticket<T0>(arg0: &OperatorCap, arg1: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::Version, arg2: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::State, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::assert_current_version(arg1);
        let v0 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::new_ticket_key<T0>(arg3);
        if (0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::contain<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::TicketKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::Ticket<T0>>(arg2, v0)) {
            return
        };
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::add<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::TicketKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::Ticket<T0>>(arg2, v0, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::new<T0>(arg4));
    }

    public entry fun distribute_tickets<T0>(arg0: &OperatorCap, arg1: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::Version, arg2: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::State, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::assert_current_version(arg1);
        let v0 = 0;
        loop {
            if (v0 >= 0x1::vector::length<address>(&arg3)) {
                break
            };
            let v1 = 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::new_ticket_key<T0>(*0x1::vector::borrow<address>(&arg3, v0));
            if (0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::contain<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::TicketKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::Ticket<T0>>(arg2, v1)) {
                continue
            };
            0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::add<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::TicketKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::Ticket<T0>>(arg2, v1, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::ticket::new<T0>(arg4));
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, @0x9389fc0b53610f38292b5eaccab3a5cb4be4cd9a08ebb7598b990ee57550d535);
    }

    public entry fun mint_nft_to_address(arg0: &OperatorCap, arg1: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::Version, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::assert_current_version(arg1);
        0x2::transfer::public_transfer<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian::Pandorian>(0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian::mint_nft(arg2, arg3, arg4, arg5, arg6, arg8), arg7);
    }

    public entry fun mint_nft_to_custodian(arg0: &OperatorCap, arg1: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::Version, arg2: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::custodian::Custodian, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<0x1::ascii::String>, arg7: vector<0x1::ascii::String>, arg8: &mut 0x2::tx_context::TxContext) {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::assert_current_version(arg1);
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::custodian::add_nft(arg2, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::pandorian::mint_nft(arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public(friend) fun new_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap>(v0, arg0);
    }

    public entry fun update_round<T0>(arg0: &OperatorCap, arg1: &0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::Version, arg2: &mut 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::State, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::version::assert_current_version(arg1);
        0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::update<T0>(0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::state::borrow_mut<0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundKey<T0>, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::RoundInfo<T0>>(arg2, 0x2ddade053528a59efd0494bd876bccfb245166b59540cc1ed67d6e42ecc2b12c::round::new_round_key<T0>()), arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

