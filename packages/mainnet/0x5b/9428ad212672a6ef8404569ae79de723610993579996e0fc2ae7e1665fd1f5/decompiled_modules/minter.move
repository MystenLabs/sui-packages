module 0x5b9428ad212672a6ef8404569ae79de723610993579996e0fc2ae7e1665fd1f5::minter {
    struct EventEmissions has copy, drop {
        emission: u64,
        rebase: u64,
        total_supply: u64,
        total_locked: u64,
    }

    public entry fun emissions<T0>(arg0: &0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::minter::Minter<T0>, arg1: &0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::voting_escrow::VotingEscrow<T0>) {
        let v0 = 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::minter::epoch_emissions<T0>(arg0);
        let v1 = 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::voting_escrow::total_locked<T0>(arg1);
        let v2 = 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::minter::total_supply<T0>(arg0);
        let v3 = EventEmissions{
            emission     : v0,
            rebase       : 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::minter::calculate_rebase_growth(v0, v2 + v0, v1),
            total_supply : v2,
            total_locked : v1,
        };
        0x2::event::emit<EventEmissions>(v3);
    }

    public entry fun set_minter_cap<T0>(arg0: &0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::minter::AdminCap, arg1: &mut 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::minter::Minter<T0>, arg2: 0x5df88eb4e78f647daf4a5326ea529fe6d94612062effed4a6804d7511d268261::magma::MinterCap<T0>) {
        0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::minter::set_minter_cap<T0>(arg1, arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

