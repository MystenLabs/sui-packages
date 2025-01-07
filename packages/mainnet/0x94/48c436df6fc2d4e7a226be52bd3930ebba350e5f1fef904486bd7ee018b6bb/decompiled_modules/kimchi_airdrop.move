module 0xb6baa75577e4bbffba70207651824606e51d38ae23aa94fb9fb700e0ecf50064::kimchi_airdrop {
    struct KimchiAirdrop has store, key {
        id: 0x2::object::UID,
        airdrop: 0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::airdrop::Airdrop<0xb6baa75577e4bbffba70207651824606e51d38ae23aa94fb9fb700e0ecf50064::kimchi::KIMCHI>,
    }

    entry fun claim_from_airdrop(arg0: &mut KimchiAirdrop, arg1: vector<vector<u8>>, arg2: &0x2::clock::Clock, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb6baa75577e4bbffba70207651824606e51d38ae23aa94fb9fb700e0ecf50064::kimchi::KIMCHI>>(0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::airdrop::get_airdrop<0xb6baa75577e4bbffba70207651824606e51d38ae23aa94fb9fb700e0ecf50064::kimchi::KIMCHI>(&mut arg0.airdrop, arg1, arg2, arg3, arg5), arg4);
    }

    entry fun create_kimchi_airdrop(arg0: &0xb6baa75577e4bbffba70207651824606e51d38ae23aa94fb9fb700e0ecf50064::treasury::TreasuryAdminCap, arg1: &mut 0xb6baa75577e4bbffba70207651824606e51d38ae23aa94fb9fb700e0ecf50064::treasury::Treasury, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = KimchiAirdrop{
            id      : 0x2::object::new(arg6),
            airdrop : 0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::airdrop::new<0xb6baa75577e4bbffba70207651824606e51d38ae23aa94fb9fb700e0ecf50064::kimchi::KIMCHI>(0xb6baa75577e4bbffba70207651824606e51d38ae23aa94fb9fb700e0ecf50064::treasury::take_from_airdrop_reserve(arg0, arg1, arg2, arg6), arg3, arg4, arg5, arg6),
        };
        0x2::transfer::share_object<KimchiAirdrop>(v0);
    }

    // decompiled from Move bytecode v6
}

