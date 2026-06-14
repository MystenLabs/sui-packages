module 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::events {
    struct RoundOpened has copy, drop, store {
        round_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        registration_id: 0x2::object::ID,
        game_type_id: u64,
        player: address,
        player_pot: u64,
        reservation: u64,
    }

    struct RoundSettled has copy, drop, store {
        round_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        registration_id: 0x2::object::ID,
        game_type_id: u64,
        player: address,
        payout: u64,
        released: u64,
    }

    struct RoundReleased has copy, drop, store {
        round_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        reservation_dropped: u64,
    }

    struct P2PEscrowed has copy, drop, store {
        receipt_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        registration_id: 0x2::object::ID,
        game_type_id: u64,
        contributor: address,
        amount: u64,
        receipt_balance_after: u64,
    }

    struct P2PReleased has copy, drop, store {
        receipt_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        registration_id: 0x2::object::ID,
        game_type_id: u64,
        recipient: address,
        amount: u64,
        receipt_balance_after: u64,
        kind: vector<u8>,
    }

    struct AdminVaultEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        operation: vector<u8>,
        amount: u64,
        balance_before: u64,
        balance_after: u64,
        reserved_before: u64,
        reserved_after: u64,
        timestamp_ms: u64,
        operator: address,
    }

    struct HouseDeposit has copy, drop, store {
        house_lp_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        provider: address,
        assets_in: u64,
        shares_out: u128,
        total_shares_after: u128,
        house_equity_after: u64,
        locked_until_ms: u64,
        position_id: 0x2::object::ID,
    }

    struct HouseRedeem has copy, drop, store {
        house_lp_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        provider: address,
        shares_in: u128,
        assets_out: u64,
        total_shares_after: u128,
        house_equity_after: u64,
    }

    struct HouseFeeCrystallized has copy, drop, store {
        house_lp_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        fee_shares: u128,
        protocol_shares_after: u128,
        price_ray_after: u128,
    }

    struct HouseConfigChanged has copy, drop, store {
        house_lp_id: 0x2::object::ID,
        field: vector<u8>,
        old_value: u64,
        new_value: u64,
        operator: address,
    }

    public(friend) fun emit_admin(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: address) {
        let v0 = AdminVaultEvent{
            vault_id        : arg0,
            operation       : arg1,
            amount          : arg2,
            balance_before  : arg3,
            balance_after   : arg4,
            reserved_before : arg5,
            reserved_after  : arg6,
            timestamp_ms    : arg7,
            operator        : arg8,
        };
        0x2::event::emit<AdminVaultEvent>(v0);
    }

    public(friend) fun emit_house_config_changed(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: address) {
        let v0 = HouseConfigChanged{
            house_lp_id : arg0,
            field       : arg1,
            old_value   : arg2,
            new_value   : arg3,
            operator    : arg4,
        };
        0x2::event::emit<HouseConfigChanged>(v0);
    }

    public(friend) fun emit_house_deposit(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: 0x2::object::ID) {
        let v0 = HouseDeposit{
            house_lp_id        : arg0,
            vault_id           : arg1,
            provider           : arg2,
            assets_in          : arg3,
            shares_out         : arg4,
            total_shares_after : arg5,
            house_equity_after : arg6,
            locked_until_ms    : arg7,
            position_id        : arg8,
        };
        0x2::event::emit<HouseDeposit>(v0);
    }

    public(friend) fun emit_house_fee_crystallized(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: u128) {
        let v0 = HouseFeeCrystallized{
            house_lp_id           : arg0,
            vault_id              : arg1,
            fee_shares            : arg2,
            protocol_shares_after : arg3,
            price_ray_after       : arg4,
        };
        0x2::event::emit<HouseFeeCrystallized>(v0);
    }

    public(friend) fun emit_house_redeem(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u128, arg4: u64, arg5: u128, arg6: u64) {
        let v0 = HouseRedeem{
            house_lp_id        : arg0,
            vault_id           : arg1,
            provider           : arg2,
            shares_in          : arg3,
            assets_out         : arg4,
            total_shares_after : arg5,
            house_equity_after : arg6,
        };
        0x2::event::emit<HouseRedeem>(v0);
    }

    public(friend) fun emit_p2p_escrowed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: u64, arg6: u64) {
        let v0 = P2PEscrowed{
            receipt_id            : arg0,
            vault_id              : arg1,
            registration_id       : arg2,
            game_type_id          : arg3,
            contributor           : arg4,
            amount                : arg5,
            receipt_balance_after : arg6,
        };
        0x2::event::emit<P2PEscrowed>(v0);
    }

    public(friend) fun emit_p2p_released(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: vector<u8>) {
        let v0 = P2PReleased{
            receipt_id            : arg0,
            vault_id              : arg1,
            registration_id       : arg2,
            game_type_id          : arg3,
            recipient             : arg4,
            amount                : arg5,
            receipt_balance_after : arg6,
            kind                  : arg7,
        };
        0x2::event::emit<P2PReleased>(v0);
    }

    public(friend) fun emit_round_opened(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: u64, arg6: u64) {
        let v0 = RoundOpened{
            round_id        : arg0,
            vault_id        : arg1,
            registration_id : arg2,
            game_type_id    : arg3,
            player          : arg4,
            player_pot      : arg5,
            reservation     : arg6,
        };
        0x2::event::emit<RoundOpened>(v0);
    }

    public(friend) fun emit_round_released(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = RoundReleased{
            round_id            : arg0,
            vault_id            : arg1,
            reservation_dropped : arg2,
        };
        0x2::event::emit<RoundReleased>(v0);
    }

    public(friend) fun emit_round_settled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: u64, arg6: u64) {
        let v0 = RoundSettled{
            round_id        : arg0,
            vault_id        : arg1,
            registration_id : arg2,
            game_type_id    : arg3,
            player          : arg4,
            payout          : arg5,
            released        : arg6,
        };
        0x2::event::emit<RoundSettled>(v0);
    }

    // decompiled from Move bytecode v7
}

