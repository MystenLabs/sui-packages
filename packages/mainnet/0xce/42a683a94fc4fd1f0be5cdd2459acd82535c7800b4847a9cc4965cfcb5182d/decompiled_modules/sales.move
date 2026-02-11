module 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::sales {
    struct ForeverReceipt has key {
        id: 0x2::object::UID,
        buyer: address,
        video_id: 0x2::object::ID,
        creator: address,
        purchased_ms: u64,
    }

    struct RentalReceipt has key {
        id: 0x2::object::UID,
        buyer: address,
        video_id: 0x2::object::ID,
        creator: address,
        start_ms: u64,
        expires_ms: u64,
    }

    struct VideoPurchased has copy, drop {
        buyer: address,
        video_id: 0x2::object::ID,
        price_paid: u64,
        platform_fee: u64,
    }

    struct VideoRented has copy, drop {
        buyer: address,
        video_id: 0x2::object::ID,
        price_paid: u64,
        expires_ms: u64,
    }

    entry fun buy_forever(arg0: &0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformConfig, arg1: &mut 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformTreasury, arg2: &mut 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_treasury::CreatorTreasury, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::is_paused(arg0), 1);
        assert!(arg5 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= arg5, 2);
        let v1 = arg5 * 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::sales_fee_bps(arg0) / 10000;
        let v2 = 0x2::coin::split<0x2::sui::SUI>(&mut arg6, arg5, arg8);
        if (0x2::coin::value<0x2::sui::SUI>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg6);
        };
        if (v1 > 0) {
            0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::deposit_usde(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut v2, v1, arg8));
        };
        0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_treasury::deposit_usde(arg2, v2);
        let v3 = ForeverReceipt{
            id           : 0x2::object::new(arg8),
            buyer        : v0,
            video_id     : arg3,
            creator      : arg4,
            purchased_ms : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::transfer::transfer<ForeverReceipt>(v3, v0);
        let v4 = VideoPurchased{
            buyer        : v0,
            video_id     : arg3,
            price_paid   : arg5,
            platform_fee : v1,
        };
        0x2::event::emit<VideoPurchased>(v4);
    }

    entry fun rent_video(arg0: &0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformConfig, arg1: &mut 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformTreasury, arg2: &mut 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_treasury::CreatorTreasury, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::is_paused(arg0), 1);
        assert!(arg5 > 0 && arg6 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= arg5, 2);
        let v1 = arg5 * 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::sales_fee_bps(arg0) / 10000;
        let v2 = 0x2::coin::split<0x2::sui::SUI>(&mut arg7, arg5, arg9);
        if (0x2::coin::value<0x2::sui::SUI>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg7);
        };
        if (v1 > 0) {
            0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::deposit_usde(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut v2, v1, arg9));
        };
        0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_treasury::deposit_usde(arg2, v2);
        let v3 = 0x2::clock::timestamp_ms(arg8);
        let v4 = v3 + arg6;
        let v5 = RentalReceipt{
            id         : 0x2::object::new(arg9),
            buyer      : v0,
            video_id   : arg3,
            creator    : arg4,
            start_ms   : v3,
            expires_ms : v4,
        };
        0x2::transfer::transfer<RentalReceipt>(v5, v0);
        let v6 = VideoRented{
            buyer      : v0,
            video_id   : arg3,
            price_paid : arg5,
            expires_ms : v4,
        };
        0x2::event::emit<VideoRented>(v6);
    }

    // decompiled from Move bytecode v6
}

