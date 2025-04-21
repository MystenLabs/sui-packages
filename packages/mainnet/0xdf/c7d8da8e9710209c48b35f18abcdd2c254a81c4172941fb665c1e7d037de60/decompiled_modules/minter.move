module 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::minter {
    struct EventEmissions has copy, drop {
        emission: u64,
        rebase: u64,
        total_supply: u64,
        total_locked: u64,
    }

    public entry fun set_minter_cap<T0>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::AdminCap, arg1: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::Minter<T0>, arg2: 0x7161c6c6bb65f852797c8f7f5c4f8d57adaf796e1b840921f9e23fabeadfd54e::magma::MinterCap<T0>) {
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::set_minter_cap<T0>(arg1, arg0, arg2);
    }

    public entry fun emissions<T0>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::Minter<T0>, arg1: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T0>) {
        let v0 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::epoch_emissions<T0>(arg0);
        let v1 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::total_locked<T0>(arg1);
        let v2 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::total_supply<T0>(arg0);
        let v3 = EventEmissions{
            emission     : v0,
            rebase       : 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::calculate_rebase_growth(v0, v2 + v0, v1),
            total_supply : v2,
            total_locked : v1,
        };
        0x2::event::emit<EventEmissions>(v3);
    }

    // decompiled from Move bytecode v6
}

