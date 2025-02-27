module 0xe9c807d16de49321832873a8e07c8ead2ff795bd1704f8f936978aeb63be3be7::minter {
    struct EventEmissions has copy, drop {
        emission: u64,
        rebase: u64,
        total_supply: u64,
        total_locked: u64,
    }

    public entry fun set_minter_cap<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::AdminCap, arg1: &mut 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::Minter<T0>, arg2: 0x7161c6c6bb65f852797c8f7f5c4f8d57adaf796e1b840921f9e23fabeadfd54e::magma::MinterCap<T0>) {
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::set_minter_cap<T0>(arg1, arg0, arg2);
    }

    public entry fun emissions<T0>(arg0: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::Minter<T0>, arg1: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>) {
        let v0 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::epoch_emissions<T0>(arg0);
        let v1 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::total_locked<T0>(arg1);
        let v2 = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::total_supply<T0>(arg0);
        let v3 = EventEmissions{
            emission     : v0,
            rebase       : 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::calculate_rebase_growth(v0, v2 + v0, v1),
            total_supply : v2,
            total_locked : v1,
        };
        0x2::event::emit<EventEmissions>(v3);
    }

    // decompiled from Move bytecode v6
}

