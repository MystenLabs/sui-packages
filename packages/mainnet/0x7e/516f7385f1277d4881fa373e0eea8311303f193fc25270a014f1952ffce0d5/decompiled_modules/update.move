module 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::update {
    public entry fun updateAll(arg0: &0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::FFIO::FindFourAdminCap, arg1: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::FFIO::UserState, arg2: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::FFIO::RewardState, arg3: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::FFIO::Treasury, arg4: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::FFIO::PresaleState, arg5: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::multi_player::FFIO_Nonce, arg6: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::profile_and_rank::ProfileTable) {
        0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::FFIO::update_version(arg0, arg1, arg2, arg3, arg4);
        0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::multi_player::update_version(arg0, arg5);
        0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::profile_and_rank::update_version(arg0, arg6);
    }

    // decompiled from Move bytecode v6
}

