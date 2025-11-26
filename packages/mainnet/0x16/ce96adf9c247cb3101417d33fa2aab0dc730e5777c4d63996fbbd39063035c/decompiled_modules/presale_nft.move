module 0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::presale_nft {
    struct PRESALE_NFT has drop {
        dummy_field: bool,
    }

    struct PresaleNFT has store, key {
        id: 0x2::object::UID,
        tier: u8,
        mint_number: u64,
        mint_date: u64,
        image_url: 0x2::url::Url,
        minter: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PresaleState has key {
        id: 0x2::object::UID,
        is_paused: bool,
        is_ended: bool,
        golden_minted: u64,
        silver_minted: u64,
        total_minted: u64,
        treasury: 0x2::balance::Balance<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>,
        admin: address,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        tier: u8,
        mint_number: u64,
        minter: address,
        price_paid: u64,
        timestamp: u64,
    }

    struct PresalePaused has copy, drop {
        timestamp: u64,
    }

    struct PresaleResumed has copy, drop {
        timestamp: u64,
    }

    struct PresaleEnded has copy, drop {
        timestamp: u64,
        total_golden: u64,
        total_silver: u64,
        total_minted: u64,
    }

    struct FundsWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    public entry fun burn_nft(arg0: PresaleNFT) {
        let PresaleNFT {
            id          : v0,
            tier        : _,
            mint_number : _,
            mint_date   : _,
            image_url   : _,
            minter      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun end_presale(arg0: &AdminCap, arg1: &mut PresaleState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_ended = true;
        let v0 = PresaleEnded{
            timestamp    : 0x2::clock::timestamp_ms(arg2),
            total_golden : arg1.golden_minted,
            total_silver : arg1.silver_minted,
            total_minted : arg1.total_minted,
        };
        0x2::event::emit<PresaleEnded>(v0);
    }

    public fun get_mint_date(arg0: &PresaleNFT) : u64 {
        arg0.mint_date
    }

    public fun get_mint_number(arg0: &PresaleNFT) : u64 {
        arg0.mint_number
    }

    public fun get_minter(arg0: &PresaleNFT) : address {
        arg0.minter
    }

    public fun get_presale_stats(arg0: &PresaleState) : (bool, bool, u64, u64, u64) {
        (arg0.is_paused, arg0.is_ended, arg0.golden_minted, arg0.silver_minted, arg0.total_minted)
    }

    public fun get_tier(arg0: &PresaleNFT) : u8 {
        arg0.tier
    }

    public fun get_treasury_balance(arg0: &PresaleState) : u64 {
        0x2::balance::value<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>(&arg0.treasury)
    }

    fun init(arg0: PRESALE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = PresaleState{
            id            : 0x2::object::new(arg1),
            is_paused     : false,
            is_ended      : false,
            golden_minted : 0,
            silver_minted : 0,
            total_minted  : 0,
            treasury      : 0x2::balance::zero<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>(),
            admin         : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<PresaleState>(v1);
        let v2 = 0x2::package::claim<PRESALE_NFT>(arg0, arg1);
        let v3 = 0x2::display::new<PresaleNFT>(&v2, arg1);
        0x2::display::add<PresaleNFT>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"NETSTREAM {tier} Founder NFT #{mint_number}"));
        0x2::display::add<PresaleNFT>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"NETSTREAM Presale Founder NFT - Converts to official NETSTREAM NFT at launch"));
        0x2::display::add<PresaleNFT>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<PresaleNFT>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://netstream.live"));
        0x2::display::add<PresaleNFT>(&mut v3, 0x1::string::utf8(b"tier"), 0x1::string::utf8(b"{tier}"));
        0x2::display::add<PresaleNFT>(&mut v3, 0x1::string::utf8(b"mint_number"), 0x1::string::utf8(b"{mint_number}"));
        0x2::display::add<PresaleNFT>(&mut v3, 0x1::string::utf8(b"mint_date"), 0x1::string::utf8(b"{mint_date}"));
        0x2::display::update_version<PresaleNFT>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PresaleNFT>>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_golden(arg0: &mut PresaleState, arg1: 0x2::coin::Coin<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        mint_nft(arg0, arg1, 1, 750000000, arg2, arg3, arg4);
    }

    fun mint_nft(arg0: &mut PresaleState, arg1: 0x2::coin::Coin<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>, arg2: u8, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 2);
        assert!(!arg0.is_ended, 3);
        if (arg2 == 1) {
            assert!(arg0.golden_minted < 666, 6);
        } else {
            assert!(arg0.silver_minted < 2000, 6);
        };
        assert!(0x2::coin::value<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>(&arg1) >= arg3, 4);
        0x2::balance::join<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>(&mut arg0.treasury, 0x2::coin::into_balance<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>(arg1));
        arg0.total_minted = arg0.total_minted + 1;
        let v0 = arg0.total_minted;
        if (arg2 == 1) {
            arg0.golden_minted = arg0.golden_minted + 1;
        } else {
            arg0.silver_minted = arg0.silver_minted + 1;
        };
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x2::object::new(arg6);
        let v3 = PresaleNFT{
            id          : v2,
            tier        : arg2,
            mint_number : v0,
            mint_date   : v1,
            image_url   : 0x2::url::new_unsafe_from_bytes(arg4),
            minter      : 0x2::tx_context::sender(arg6),
        };
        let v4 = NFTMinted{
            nft_id      : 0x2::object::uid_to_inner(&v2),
            tier        : arg2,
            mint_number : v0,
            minter      : 0x2::tx_context::sender(arg6),
            price_paid  : arg3,
            timestamp   : v1,
        };
        0x2::event::emit<NFTMinted>(v4);
        0x2::transfer::public_transfer<PresaleNFT>(v3, 0x2::tx_context::sender(arg6));
    }

    public entry fun mint_silver(arg0: &mut PresaleState, arg1: 0x2::coin::Coin<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        mint_nft(arg0, arg1, 2, 250000000, arg2, arg3, arg4);
    }

    public entry fun pause_presale(arg0: &AdminCap, arg1: &mut PresaleState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_paused = true;
        let v0 = PresalePaused{timestamp: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<PresalePaused>(v0);
    }

    public entry fun resume_presale(arg0: &AdminCap, arg1: &mut PresaleState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_paused = false;
        let v0 = PresaleResumed{timestamp: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<PresaleResumed>(v0);
    }

    public entry fun withdraw_all_funds(arg0: &AdminCap, arg1: &mut PresaleState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FundsWithdrawn{
            amount    : 0x2::balance::value<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>(&arg1.treasury),
            recipient : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FundsWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>>(0x2::coin::from_balance<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>(0x2::balance::withdraw_all<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>(&mut arg1.treasury), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_funds(arg0: &AdminCap, arg1: &mut PresaleState, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = FundsWithdrawn{
            amount    : arg2,
            recipient : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FundsWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>>(0x2::coin::from_balance<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>(0x2::balance::split<0x16ce96adf9c247cb3101417d33fa2aab0dc730e5777c4d63996fbbd39063035c::usdc::USDC>(&mut arg1.treasury, arg2), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

