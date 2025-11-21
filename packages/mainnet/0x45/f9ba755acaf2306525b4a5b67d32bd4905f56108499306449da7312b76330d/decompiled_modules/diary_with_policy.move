module 0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::diary_with_policy {
    public entry fun mint_entry_with_policy(arg0: &mut 0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::diary::Journal, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<u8>, arg10: u64, arg11: bool, arg12: &mut 0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::seal_access_policies::PolicyRegistry, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg14);
        assert!(v0 == 0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::diary::get_journal_owner(arg0), 0);
        let v1 = 0x2::clock::timestamp_ms(arg13);
        let v2 = v1 / 86400000;
        0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::diary::increment_journal_count(arg0);
        let v3 = 0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::diary::create_entry_nft(0x2::object::id<0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::diary::Journal>(arg0), v1, v2, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg14);
        let v4 = 0x2::object::id<0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::diary::EntryNFT>(&v3);
        0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::diary::add_entry_ref(arg0, 0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::diary::get_journal_count_for_policy(arg0), 0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::diary::create_entry_ref(v4, v2));
        0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::diary::emit_mint_event(v0, v2, arg1);
        0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::diary::transfer_entry_nft(v3, v0);
        0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::seal_access_policies::create_policy(v4, v0, arg11, arg12, arg14);
    }

    // decompiled from Move bytecode v6
}

