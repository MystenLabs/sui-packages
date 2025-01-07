module 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::achievementLib {
    public entry fun configureAchievement(arg0: &0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::accessControlLib::UserRolesCollection, arg1: &mut 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::nftLib::AchievementCollection, arg2: &0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::User, arg3: u32, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: u8, arg9: vector<u8>, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: &mut 0x2::tx_context::TxContext) {
        0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::accessControlLib::checkHasRole(arg0, 0x2::object::id<0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::User>(arg2), 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::accessControlLib::get_action_role_admin(), 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::commonLib::getZeroId());
        0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::nftLib::configureAchievement(arg1, 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::commonLib::getZeroId(), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun configureCommunityAchievement(arg0: &0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::accessControlLib::UserRolesCollection, arg1: &mut 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::nftLib::AchievementCollection, arg2: &0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::User, arg3: &0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::communityLib::Community, arg4: u32, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<u8>, arg9: u8, arg10: vector<u8>, arg11: vector<0x1::string::String>, arg12: vector<0x1::string::String>, arg13: &mut 0x2::tx_context::TxContext) {
        0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::accessControlLib::checkHasRole(arg0, 0x2::object::id<0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::User>(arg2), 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::accessControlLib::get_action_role_admin_or_community_admin(), 0x2::object::id<0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::communityLib::Community>(arg3));
        0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::communityLib::onlyNotFrozenCommunity(arg3);
        0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::nftLib::configureAchievement(arg1, 0x2::object::id<0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::communityLib::Community>(arg3), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun mintUserNFT(arg0: &mut 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::nftLib::AchievementCollection, arg1: &0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::User, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::nftLib::mint(arg0, 0x2::object::id<0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::User>(arg1), arg2, arg3);
    }

    public entry fun unlockManualNft(arg0: &0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::accessControlLib::UserRolesCollection, arg1: &mut 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::nftLib::AchievementCollection, arg2: &0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::User, arg3: 0x2::object::ID, arg4: u64) {
        0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::accessControlLib::checkHasRole(arg0, 0x2::object::id<0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::userLib::User>(arg2), 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::accessControlLib::get_action_role_admin(), 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::commonLib::getZeroId());
        0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::nftLib::unlockManualNft(arg1, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

