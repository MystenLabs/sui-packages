module 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reveal {
    fun compute_winner_index(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64) : u64 {
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, *arg1);
        let v1 = 0x1::hash::sha2_256(v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 8) {
            v2 = v2 + ((*0x1::vector::borrow<u8>(&v1, v3) as u64) << (((7 - v3) * 8) as u8));
            v3 = v3 + 1;
        };
        v2 % arg2
    }

    public fun run<T0>(arg0: &0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::Config, arg1: &0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::Vault<T0>, arg2: &mut 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::Reward, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: address, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::tx_context::TxContext) {
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::assert_vrf_authority(arg0, 0x2::tx_context::sender(arg10));
        let v0 = 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::id<T0>(arg1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::assert_vault(arg2, v0);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::assert_not_revealed(arg2);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::assert_not_expired(arg2);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::validate_vrf_lengths(&arg4, &arg5);
        let v1 = 0x1::hash::sha2_256(arg3);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::assert_secret_matches(arg2, &v1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::assert_vrf_valid(0x2::ecvrf::ecvrf_verify(&arg4, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::vrf_input(arg2), 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::vrf_pubkey(arg2), &arg5));
        let v2 = compute_winner_index(&arg4, &arg3, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::total_tickets(arg2));
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::assert_winner_range(arg2, arg7, arg8, v2);
        let v3 = 0x2::address::to_bytes(arg6);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg8));
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::assert_merkle_ok(0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::merkle::verify_proof(&v3, &arg9, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::merkle_root(arg2)));
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::events::emit_reveal(v0, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::id(arg2), 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::round(arg2), arg3, arg4, v2, arg6, arg7, arg8);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::mark_revealed(arg2, arg3, arg4, arg5, v2, arg6);
    }

    // decompiled from Move bytecode v7
}

