module 0xb0ffa99b4b91e301ed7acb4482e5091e0ff4c3c8beba467ae65e980d188fa7ac::pull {
    public fun seq_verify_oracle_proof(arg0: u8, arg1: &0xc08b55462b9c1aa732f9f36d1f83c4b770353e5aaf54515b7c391e85e5edc29e::sequencer::Indexer, arg2: &0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator_v2::DkgState, arg3: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::price_data_pull_v2::MerkleRootHash, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        if (0xc08b55462b9c1aa732f9f36d1f83c4b770353e5aaf54515b7c391e85e5edc29e::sequencer::check(arg1, arg0)) {
            0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::price_data_pull_v2::verify_oracle_proof(arg2, arg3, arg4, arg5, arg6, arg7);
        };
    }

    // decompiled from Move bytecode v6
}

