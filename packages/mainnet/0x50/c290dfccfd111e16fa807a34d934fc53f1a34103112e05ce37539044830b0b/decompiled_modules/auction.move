module 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction {
    entry fun bid(arg0: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::AuctionRegistry, arg3: &mut 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Auction, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::bid(0x2::object::id<0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD>(arg0), arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun bid_free(arg0: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::AuctionRegistry, arg3: &mut 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Auction, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::bid(0x2::object::id<0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD>(arg0), arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun claim_auction_reward<T0: store + key, T1: drop>(arg0: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: &mut 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::AuctionRegistry, arg3: 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::SealBid, arg4: 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Invoice, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Auction, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::claim_auction_reward<T0, T1>(0x2::object::id<0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun claim_auction_reward_free<T0: store + key, T1: drop>(arg0: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: &mut 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::AuctionRegistry, arg3: 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::SealBid, arg4: 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Invoice, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Auction, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::claim_auction_reward<T0, T1>(0x2::object::id<0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun clean_all_auctions(arg0: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_authority::AuctionOperatorCap, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: &mut 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::AuctionRegistry, arg3: 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Auction) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::clean_all_auctions(arg3, arg2);
    }

    entry fun create_auction<T0: store + key, T1: drop>(arg0: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_authority::AuctionOperatorCap, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: &mut 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::AuctionRegistry, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: T0, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::create_auction<T0>(arg0, arg2, arg3, arg4, arg5, arg6, 0x1::type_name::get<T1>(), arg7, arg8, arg9, arg10, arg11, arg12);
    }

    entry fun invalidate_auction<T0: store + key>(arg0: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_authority::AuctionOperatorCap, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: &mut 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::AuctionRegistry, arg3: &mut 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Auction, arg4: &mut 0x2::tx_context::TxContext) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::invalidate_auction<T0>(arg2, arg3, arg4);
    }

    entry fun set_winner(arg0: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_authority::AuctionOperatorCap, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: &mut 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Auction, arg3: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::InvoiceRegistry, arg4: vector<address>, arg5: vector<0x2::object::ID>, arg6: vector<u8>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::set_winner(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    entry fun settle_bond(arg0: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::SealBid, arg3: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::AuctionRegistry, arg4: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Auction, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::settle_bond(0x2::object::id<0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD>(arg0), arg2, arg3, arg4, arg5, arg6);
    }

    entry fun settle_bond_free(arg0: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::SealBid, arg3: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::AuctionRegistry, arg4: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Auction, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::settle_bond(0x2::object::id<0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD>(arg0), arg2, arg3, arg4, arg5, arg6);
    }

    entry fun settle_bond_winner(arg0: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::SealBid, arg3: 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Invoice, arg4: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::InvoiceRegistry, arg5: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::AuctionRegistry, arg6: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Auction, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::settle_bond_winner(0x2::object::id<0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun settle_bond_winner_free(arg0: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::SealBid, arg3: 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Invoice, arg4: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::InvoiceRegistry, arg5: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::AuctionRegistry, arg6: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Auction, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::settle_bond_winner(0x2::object::id<0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun update_auction_status(arg0: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_authority::AuctionOperatorCap, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::AuctionRegistry, arg3: &mut 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::Auction, arg4: bool, arg5: &0x2::clock::Clock) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::update_auction_status(arg2, arg3, arg4, arg5);
    }

    entry fun update_registry(arg0: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_authority::AuctionOperatorCap, arg1: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::Version, arg2: &mut 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::AuctionRegistry, arg3: address, arg4: u64, arg5: address) {
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_version::validate_version(arg1);
        0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core::update_registry(arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

