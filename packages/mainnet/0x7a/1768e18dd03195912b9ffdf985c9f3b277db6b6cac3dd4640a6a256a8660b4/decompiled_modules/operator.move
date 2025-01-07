module 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::operator {
    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    public entry fun burn_token(arg0: &OperatorCap, arg1: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg2: &mut 0x2::coin::TreasuryCap<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::pan::PAN>, arg3: 0x2::coin::Coin<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::pan::PAN>) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg1);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::pan::burn(arg2, arg3);
    }

    public entry fun create_kiosk(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::kiosk::set_allow_extensions(&mut v3, &v2, true);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public entry fun create_ob_kiosk(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::create_for_address(arg0, arg1);
    }

    public entry fun create_round<T0>(arg0: &OperatorCap, arg1: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg2: &mut 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::State, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg1);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::add<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::RoundKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::RoundInfo<T0>>(arg2, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::new_round_key<T0>(), 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::new<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public entry fun distribute_ticket<T0>(arg0: &OperatorCap, arg1: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg2: &mut 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::State, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg1);
        let v0 = 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::new_ticket_key<T0>(arg3);
        if (0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::contain<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::TicketKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::Ticket<T0>>(arg2, v0)) {
            return
        };
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::add<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::TicketKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::Ticket<T0>>(arg2, v0, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::new<T0>(arg4));
    }

    public entry fun distribute_tickets<T0>(arg0: &OperatorCap, arg1: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg2: &mut 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::State, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg1);
        let v0 = 0;
        loop {
            if (v0 >= 0x1::vector::length<address>(&arg3)) {
                break
            };
            let v1 = 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::new_ticket_key<T0>(*0x1::vector::borrow<address>(&arg3, v0));
            if (0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::contain<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::TicketKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::Ticket<T0>>(arg2, v1)) {
                continue
            };
            0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::add<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::TicketKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::Ticket<T0>>(arg2, v1, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::ticket::new<T0>(arg4));
            v0 = v0 + 1;
        };
    }

    public entry fun mint_nft_to_address(arg0: &OperatorCap, arg1: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<0x1::ascii::String>, arg7: vector<0x1::ascii::String>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg1);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::pandorian::Pandorian>(arg2, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::pandorian::mint_nft(arg3, arg4, arg5, arg6, arg7, arg9), arg9);
    }

    public entry fun mint_nft_to_custodian(arg0: &OperatorCap, arg1: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg2: &mut 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::custodian::Custodian, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<0x1::ascii::String>, arg7: vector<0x1::ascii::String>, arg8: &mut 0x2::tx_context::TxContext) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg1);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::custodian::add_nft(arg2, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::pandorian::mint_nft(arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public entry fun mint_token_to_address(arg0: &OperatorCap, arg1: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg2: &mut 0x2::coin::TreasuryCap<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::pan::PAN>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg1);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::pan::mint(arg2, arg3, arg4, arg5);
    }

    public(friend) fun new_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap>(v0, arg0);
    }

    public entry fun reset_total_minted<T0>(arg0: &OperatorCap, arg1: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg2: &mut 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::State) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg1);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::reset_total_minted<T0>(0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::borrow_mut<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::RoundKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::RoundInfo<T0>>(arg2, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::new_round_key<T0>()));
    }

    public entry fun update_round<T0>(arg0: &OperatorCap, arg1: &0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::Version, arg2: &mut 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::State, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::version::assert_current_version(arg1);
        0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::update<T0>(0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::state::borrow_mut<0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::RoundKey<T0>, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::RoundInfo<T0>>(arg2, 0x7a1768e18dd03195912b9ffdf985c9f3b277db6b6cac3dd4640a6a256a8660b4::round::new_round_key<T0>()), arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

