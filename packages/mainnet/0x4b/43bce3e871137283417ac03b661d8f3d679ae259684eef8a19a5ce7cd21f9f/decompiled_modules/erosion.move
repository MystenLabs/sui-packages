module 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::erosion {
    struct ErosionCleared has copy, drop {
        wallet: address,
        path: u8,
        points_cleared: u64,
        alb_paid: u64,
        nonce: u64,
        timestamp_ms: u64,
    }

    public fun purify_with_alb(arg0: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::gacha_system::UserGachaState, arg1: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::TokenTreasury, arg2: 0x2::coin::Coin<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::ALB_TOKEN>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::gacha_system::user_address(arg0) == 0x2::tx_context::sender(arg6), 1);
        assert!(arg3 > 0 && arg3 <= 100, 3);
        0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::route_alb_tax(arg1, arg2, arg6);
        let v0 = ErosionCleared{
            wallet         : 0x2::tx_context::sender(arg6),
            path           : 1,
            points_cleared : arg3,
            alb_paid       : 0x2::coin::value<0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::alb_token::ALB_TOKEN>(&arg2),
            nonce          : arg4,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ErosionCleared>(v0);
    }

    public fun purify_with_rcard(arg0: &mut 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::gacha_system::UserGachaState, arg1: 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::character_system::Character, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::gacha_system::user_address(arg0) == 0x2::tx_context::sender(arg4), 1);
        assert!(0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::character_system::get_rarity(&arg1) == 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::game_core::rarity_r(), 2);
        let (_, _) = 0x4b43bce3e871137283417ac03b661d8f3d679ae259684eef8a19a5ce7cd21f9f::character_system::burn_character(arg1, arg4);
        let v2 = ErosionCleared{
            wallet         : 0x2::tx_context::sender(arg4),
            path           : 2,
            points_cleared : 40,
            alb_paid       : 0,
            nonce          : arg2,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ErosionCleared>(v2);
    }

    // decompiled from Move bytecode v7
}

