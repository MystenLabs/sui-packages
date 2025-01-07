module 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::operator {
    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    public entry fun create_round<T0>(arg0: &OperatorCap, arg1: &0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::Version, arg2: &mut 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::state::State, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::assert_current_version(arg1);
        0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::state::add<0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::round::RoundKey<T0>, 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::round::RoundInfo<T0>>(arg2, 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::round::new_round_key<T0>(), 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::round::new<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public entry fun distribute_ticket<T0>(arg0: &OperatorCap, arg1: &0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::Version, arg2: &mut 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::state::State, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::assert_current_version(arg1);
        let v0 = 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::ticket::new_ticket_key<T0>(arg3);
        if (0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::state::contain<0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::ticket::TicketKey<T0>, 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::ticket::Ticket<T0>>(arg2, v0)) {
            return
        };
        0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::state::add<0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::ticket::TicketKey<T0>, 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::ticket::Ticket<T0>>(arg2, v0, 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::ticket::new<T0>(arg4));
    }

    public entry fun distribute_tickets<T0>(arg0: &OperatorCap, arg1: &0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::Version, arg2: &mut 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::state::State, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::assert_current_version(arg1);
        let v0 = 0;
        loop {
            if (v0 >= 0x1::vector::length<address>(&arg3)) {
                break
            };
            let v1 = 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::ticket::new_ticket_key<T0>(*0x1::vector::borrow<address>(&arg3, v0));
            if (0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::state::contain<0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::ticket::TicketKey<T0>, 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::ticket::Ticket<T0>>(arg2, v1)) {
                continue
            };
            0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::state::add<0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::ticket::TicketKey<T0>, 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::ticket::Ticket<T0>>(arg2, v1, 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::ticket::new<T0>(arg4));
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, @0x9389fc0b53610f38292b5eaccab3a5cb4be4cd9a08ebb7598b990ee57550d535);
    }

    public entry fun mint_nft_to_address(arg0: &OperatorCap, arg1: &0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::Version, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::assert_current_version(arg1);
        0x2::transfer::public_transfer<0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::pandorian::Pandorian>(0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::pandorian::mint_nft(arg2, arg3, arg4, arg5, arg6, arg8), arg7);
    }

    public entry fun mint_nft_to_custodian(arg0: &OperatorCap, arg1: &0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::Version, arg2: &mut 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::custodian::Custodian, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<0x1::ascii::String>, arg7: vector<0x1::ascii::String>, arg8: &mut 0x2::tx_context::TxContext) {
        0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::assert_current_version(arg1);
        0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::custodian::add_nft(arg2, 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::pandorian::mint_nft(arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public(friend) fun new_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap>(v0, arg0);
    }

    public entry fun update_configuration(arg0: &OperatorCap, arg1: &0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::Version, arg2: &mut 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::configuration::Configuration, arg3: u64, arg4: u64) {
        0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::assert_current_version(arg1);
        0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::configuration::update(arg2, arg3, arg4);
    }

    public entry fun update_round<T0>(arg0: &OperatorCap, arg1: &0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::Version, arg2: &mut 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::state::State, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::version::assert_current_version(arg1);
        0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::round::update<T0>(0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::state::borrow_mut<0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::round::RoundKey<T0>, 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::round::RoundInfo<T0>>(arg2, 0xb91abd548e4680195affeabfaf19c0e75fc756f33c4ebaa3cad6083812c04bd3::round::new_round_key<T0>()), arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

