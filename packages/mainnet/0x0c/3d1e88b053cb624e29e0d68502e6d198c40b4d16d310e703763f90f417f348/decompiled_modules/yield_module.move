module 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::yield_module {
    entry fun claim_yield<T0>(arg0: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::phronis_amm::Pool<T0, 0x2::sui::SUI>, arg1: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::locked_lp::LockedPhronisPosition<T0>, arg2: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::nft::SuiArtNFT, arg3: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::Launch<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::nft::nft_launch_id(arg2) == 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::id<T0>(arg3), 300);
        0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::locked_lp::do_collect<T0>(arg0, arg1, arg3, arg4);
        let v0 = claimable_yield<T0>(arg2, arg3);
        assert!(v0 > 0, 301);
        0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::nft::add_yield_claimed(arg2, v0);
        let v1 = 0x2::tx_context::sender(arg4);
        0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::events::emit_yield_claimed(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::nft::nft_id(arg2), 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::id<T0>(arg3), v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::withdraw_yield<T0>(arg3, v0, arg4), v1);
    }

    public fun claimable_yield<T0>(arg0: &0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::nft::SuiArtNFT, arg1: &0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::Launch<T0>) : u64 {
        if (0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::nft::nft_launch_id(arg0) != 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::id<T0>(arg1)) {
            return 0
        };
        let v0 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::total_token_allocation<T0>(arg1);
        if (v0 == 0) {
            return 0
        };
        let v1 = ((((0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::cumulative_fees_sui<T0>(arg1) * 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::holder_lp_share_bps() / 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::bps_denominator()) as u128) * (0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::nft::token_allocation(arg0) as u128) / (v0 as u128)) as u64);
        let v2 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::nft::yield_claimed(arg0);
        if (v1 > v2) {
            v1 - v2
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

