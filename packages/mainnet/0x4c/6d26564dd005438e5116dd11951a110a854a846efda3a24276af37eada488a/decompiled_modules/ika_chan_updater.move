module 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_updater {
    struct Updater has store, key {
        id: 0x2::object::UID,
        reserved_one_of_ones: 0x2::table_vec::TableVec<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>,
        nfts: 0x2::table_vec::TableVec<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>,
        already_updated_ones: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct NFTUpdated has copy, drop {
        id: 0x2::object::ID,
    }

    public fun add_nft(arg0: &mut Updater, arg1: 0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata) {
        0x2::table_vec::push_back<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>(&mut arg0.nfts, arg1);
    }

    public fun add_reserved_one_of_one(arg0: &mut Updater, arg1: 0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata) {
        0x2::table_vec::push_back<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>(&mut arg0.reserved_one_of_ones, arg1);
    }

    public fun create_updater(arg0: &0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::squid_forge::SquidForgeAdminCap, arg1: &mut 0x2::tx_context::TxContext) : Updater {
        Updater{
            id                   : 0x2::object::new(arg1),
            reserved_one_of_ones : 0x2::table_vec::empty<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>(arg1),
            nfts                 : 0x2::table_vec::empty<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>(arg1),
            already_updated_ones : 0x2::table::new<0x2::object::ID, bool>(arg1),
        }
    }

    fun get_random_number_by_length(arg0: &0x2::random::Random, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        if (arg1 == 1) {
            return 0
        };
        0x2::random::generate_u64_in_range(&mut v0, 0, arg1 - 1)
    }

    public fun update_the_nft(arg0: &mut Updater, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::MfSquidMaiden>, arg4: 0x2::object::ID, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.already_updated_ones, arg4), 13906834337552138239);
        let v0 = 0x2::kiosk::borrow_mut<0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_nft::IkaChanNft>(arg1, arg2, arg4);
        let v1 = *0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_nft::metadata_hash(0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_nft::metadata(v0));
        0x1::string::append(&mut v1, 0x1::string::utf8(b"-revealed"));
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_nft::update_hash_in_metadata(v0, v1);
        let v2 = NFTUpdated{id: 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_nft::id(v0)};
        0x2::event::emit<NFTUpdated>(v2);
        let v3 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::rarity_value_mythic();
        let v4 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_nft::metadata_rarity(0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_nft::metadata(v0)) == &v3 && 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_nft::metadata_evolution_stage(0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_nft::metadata(v0)) == 5;
        let v5 = if (v4) {
            0x2::table_vec::length<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>(&arg0.reserved_one_of_ones)
        } else {
            0x2::table_vec::length<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>(&arg0.nfts)
        };
        let v6 = if (v4) {
            let v7 = get_random_number_by_length(arg5, v5, arg6);
            0x2::table_vec::swap_remove<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>(&mut arg0.reserved_one_of_ones, v7)
        } else {
            let v8 = get_random_number_by_length(arg5, v5, arg6);
            0x2::table_vec::swap_remove<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>(&mut arg0.nfts, v8)
        };
        0x2::kiosk::lock<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::MfSquidMaiden>(arg1, arg2, arg3, 0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::new(v6, arg6));
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.already_updated_ones, arg4, true);
    }

    public fun wipe_nfts(arg0: &mut Updater) {
        let v0 = 0;
        while (v0 < 800 && 0x2::table_vec::length<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>(&arg0.nfts) > 0) {
            0x2::table_vec::pop_back<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>(&mut arg0.nfts);
            v0 = v0 + 1;
        };
    }

    public fun wipe_one_of_ones(arg0: &mut Updater) {
        let v0 = 0;
        while (v0 < 800 && 0x2::table_vec::length<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>(&arg0.reserved_one_of_ones) > 0) {
            0x2::table_vec::pop_back<0x3533437eabe66f05207aec78857efad86f42c2be84e2bbd63692c7c37fd349fb::mf_squid_maiden::UMetadata>(&mut arg0.reserved_one_of_ones);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

