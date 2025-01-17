module 0x1268a2afbaf91538f0b9041269fe2780273eb83b642abd4fcacad7b660a3711::partner_script {
    public entry fun claim_ref_fee<T0>(arg0: &0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::config::GlobalConfig, arg1: &0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::partner::PartnerCap, arg2: &mut 0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::partner::Partner, arg3: &mut 0x2::tx_context::TxContext) {
        0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::partner::claim_ref_fee<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_partner(arg0: &0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::config::GlobalConfig, arg1: &mut 0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::partner::Partners, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::partner::create_partner(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun update_partner_ref_fee_rate(arg0: &0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::config::GlobalConfig, arg1: &mut 0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::partner::Partner, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::partner::update_ref_fee_rate(arg0, arg1, arg2, arg3);
    }

    public entry fun update_partner_time_range(arg0: &0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::config::GlobalConfig, arg1: &mut 0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::partner::Partner, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::partner::update_time_range(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

