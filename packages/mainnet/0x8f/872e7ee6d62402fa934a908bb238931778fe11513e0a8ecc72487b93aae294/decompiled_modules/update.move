module 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::update {
    public entry fun updateAll(arg0: &0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::FFIO::FindFourAdminCap, arg1: &mut 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::FFIO::UserState, arg2: &mut 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::FFIO::RewardState, arg3: &mut 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::FFIO::Treasury, arg4: &mut 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::FFIO::PresaleState, arg5: &mut 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::multi_player::FFIO_Nonce, arg6: &mut 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::profile_and_rank::ProfileTable) {
        0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::FFIO::update_version(arg0, arg1, arg2, arg3, arg4);
        0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::multi_player::update_version(arg0, arg5);
        0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::profile_and_rank::update_version(arg0, arg6);
    }

    // decompiled from Move bytecode v6
}

