module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::candidate_inscription_put_up_v2 {
    public fun candidate_amount(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUpV2) : u64 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_put_up_v2_candidate_amount(arg0)
    }

    public fun candidate_content(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUpV2) : 0x1::string::String {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_put_up_v2_candidate_content(arg0)
    }

    public fun candidate_difference(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUpV2) : u64 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_put_up_v2_candidate_difference(arg0)
    }

    public fun candidate_hash(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUpV2) : vector<u8> {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_put_up_v2_candidate_hash(arg0)
    }

    public fun candidate_inscriber(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUpV2) : address {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_put_up_v2_candidate_inscriber(arg0)
    }

    public fun candidate_inscription_id(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUpV2) : 0x2::object::ID {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_put_up_v2_candidate_inscription_id(arg0)
    }

    public fun candidate_nonce(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUpV2) : u128 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_put_up_v2_candidate_nonce(arg0)
    }

    public fun candidate_timestamp(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUpV2) : u64 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_put_up_v2_candidate_timestamp(arg0)
    }

    public fun id(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUpV2) : 0x2::object::ID {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_put_up_v2_id(arg0)
    }

    public fun round(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUpV2) : u64 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_put_up_v2_round(arg0)
    }

    public fun slot_number(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUpV2) : u8 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_put_up_v2_slot_number(arg0)
    }

    public fun successful(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUpV2) : bool {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_put_up_v2_successful(arg0)
    }

    // decompiled from Move bytecode v6
}

