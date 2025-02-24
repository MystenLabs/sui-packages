module 0x6e3ae31a16362c563c0fef5293348d262646882a10c307f20f6be8577960f1ef::minter {
    struct EventEmissions has copy, drop {
        emission: u64,
        rebase: u64,
    }

    public entry fun set_minter_cap<T0>(arg0: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::minter::AdminCap, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::minter::Minter<T0>, arg2: 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::magma_token::MinterCap<T0>) {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::minter::set_minter_cap<T0>(arg1, arg0, arg2);
    }

    public entry fun emissions<T0>(arg0: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::minter::Minter<T0>, arg1: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::VotingEscrow<T0>) {
        let v0 = 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::minter::epoch_emissions<T0>(arg0);
        let v1 = EventEmissions{
            emission : v0,
            rebase   : 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::minter::calculate_rebase_growth(v0, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::minter::total_supply<T0>(arg0) + v0, 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::voting_escrow::total_locked<T0>(arg1)),
        };
        0x2::event::emit<EventEmissions>(v1);
    }

    // decompiled from Move bytecode v6
}

