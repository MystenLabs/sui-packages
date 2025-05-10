module 0x5e0d6f677886e4558397ceec9c13b06943e7bf133597129f916a4ab8bbd8a9b2::nexa_reward_points {
    struct NexaRewardCoinMintedEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct NexaRewardCoinReferrerMintedEvent has copy, drop {
        amount: u64,
        referrer: address,
        user: address,
    }

    struct NexaRewardCoinReferrerReferrerMintedEvent has copy, drop {
        amount: u64,
        referrer: address,
        referrer_referrer: address,
        user: address,
    }

    struct NexaRewardCoinTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    public fun initialize_treasury<T0>(arg0: &0x5e0d6f677886e4558397ceec9c13b06943e7bf133597129f916a4ab8bbd8a9b2::app::AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NexaRewardCoinTreasury<T0>{
            id           : 0x2::object::new(arg2),
            treasury_cap : arg1,
        };
        0x2::transfer::public_share_object<NexaRewardCoinTreasury<T0>>(v0);
    }

    public(friend) fun mint_and_claim_reward_points<T0>(arg0: &mut NexaRewardCoinTreasury<T0>, arg1: u64, arg2: &0x5e0d6f677886e4558397ceec9c13b06943e7bf133597129f916a4ab8bbd8a9b2::nexa_referrals::ReferralsMap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.treasury_cap;
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(v0, arg1, arg3), v1);
        let v2 = NexaRewardCoinMintedEvent{
            amount    : arg1,
            recipient : v1,
        };
        0x2::event::emit<NexaRewardCoinMintedEvent>(v2);
        let v3 = 0x5e0d6f677886e4558397ceec9c13b06943e7bf133597129f916a4ab8bbd8a9b2::nexa_referrals::get_referrer(arg2, v1);
        if (v3 != @0x0) {
            let v4 = arg1 * 30 / 100;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(v0, v4, arg3), v3);
            let v5 = NexaRewardCoinReferrerMintedEvent{
                amount   : v4,
                referrer : v3,
                user     : v1,
            };
            0x2::event::emit<NexaRewardCoinReferrerMintedEvent>(v5);
            let v6 = 0x5e0d6f677886e4558397ceec9c13b06943e7bf133597129f916a4ab8bbd8a9b2::nexa_referrals::get_referrer(arg2, v3);
            if (v6 != @0x0) {
                let v7 = v4 * 10 / 100;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(v0, v7, arg3), v6);
                let v8 = NexaRewardCoinReferrerReferrerMintedEvent{
                    amount            : v7,
                    referrer          : v3,
                    referrer_referrer : v6,
                    user              : v1,
                };
                0x2::event::emit<NexaRewardCoinReferrerReferrerMintedEvent>(v8);
            };
        };
    }

    // decompiled from Move bytecode v6
}

