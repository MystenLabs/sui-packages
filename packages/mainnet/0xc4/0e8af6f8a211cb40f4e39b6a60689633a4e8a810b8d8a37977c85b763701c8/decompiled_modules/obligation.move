module 0xc40e8af6f8a211cb40f4e39b6a60689633a4e8a810b8d8a37977c85b763701c8::obligation {
    public(friend) fun open_obligation(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: address, arg2: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg4: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg0, arg7);
        let v3 = v1;
        let v4 = v0;
        0xc40e8af6f8a211cb40f4e39b6a60689633a4e8a810b8d8a37977c85b763701c8::borrow_incentive::stake_scallop_obligation(arg2, arg3, arg4, &v3, &mut v4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(v3, arg1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg0, v4, v2);
    }

    // decompiled from Move bytecode v6
}

