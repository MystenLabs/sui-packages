module 0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::achievementLib {
    public entry fun configureAchievement(arg0: &0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::accessControlLib::UserRolesCollection, arg1: &mut 0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::nftLib::AchievementCollection, arg2: &0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::userLib::User, arg3: u32, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: u8, arg9: vector<u8>, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: &mut 0x2::tx_context::TxContext) {
        0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::accessControlLib::checkHasRole(arg0, 0x2::object::id<0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::userLib::User>(arg2), 0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::accessControlLib::get_action_role_admin(), 0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::commonLib::getZeroId());
        0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::nftLib::configureAchievement(arg1, 0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::commonLib::getZeroId(), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun configureCommunityAchievement(arg0: &0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::accessControlLib::UserRolesCollection, arg1: &mut 0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::nftLib::AchievementCollection, arg2: &0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::userLib::User, arg3: &0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::communityLib::Community, arg4: u32, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<u8>, arg9: u8, arg10: vector<u8>, arg11: vector<0x1::string::String>, arg12: vector<0x1::string::String>, arg13: &mut 0x2::tx_context::TxContext) {
        0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::accessControlLib::checkHasRole(arg0, 0x2::object::id<0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::userLib::User>(arg2), 0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::accessControlLib::get_action_role_admin_or_community_admin(), 0x2::object::id<0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::communityLib::Community>(arg3));
        0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::communityLib::onlyNotFrozenCommunity(arg3);
        0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::nftLib::configureAchievement(arg1, 0x2::object::id<0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::communityLib::Community>(arg3), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun mintUserNFT(arg0: &mut 0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::nftLib::AchievementCollection, arg1: &0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::userLib::User, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::nftLib::mint(arg0, 0x2::object::id<0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::userLib::User>(arg1), arg2, arg3);
    }

    public entry fun unlockManualNft(arg0: &0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::accessControlLib::UserRolesCollection, arg1: &mut 0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::nftLib::AchievementCollection, arg2: &0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::userLib::User, arg3: 0x2::object::ID, arg4: u64) {
        0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::accessControlLib::checkHasRole(arg0, 0x2::object::id<0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::userLib::User>(arg2), 0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::accessControlLib::get_action_role_admin(), 0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::commonLib::getZeroId());
        0xa58720753002c555b873aada75365ee8042bc7ce67b13e4478636c68ceece0fc::nftLib::unlockManualNft(arg1, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

