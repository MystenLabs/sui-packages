module 0xd0d8185301b83b58b3c0c81c2a95844a717e9f47d5758c041ff24c3b8caa79d8::aic {
    struct AIC has drop {
        dummy_field: bool,
    }

    struct AicNFT has store, key {
        id: 0x2::object::UID,
        nft_type: u64,
        nft_name: 0x1::string::String,
        nft_desc: 0x1::string::String,
        nft_url: 0x2::url::Url,
        amount: u64,
        rarity: u64,
        attribute: 0x1::string::String,
        mint_time: u64,
    }

    struct AicPlatform has key {
        id: 0x2::object::UID,
        owner: address,
        is_amm_initialized: bool,
        token_balance: 0x2::balance::Balance<AIC>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        mining_token_balance: 0x2::balance::Balance<AIC>,
        mining_sign_owner: address,
        is_closed: bool,
        draw_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        draw_sign_owner: address,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<AIC>>,
        nft_table: 0x2::table::Table<0x2::object::ID, AicNFT>,
        type_index: 0x2::table::Table<u64, vector<0x2::object::ID>>,
        nft_sign_owner: address,
        nft_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AMMPool has key {
        id: 0x2::object::UID,
        owner: address,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        token_reserve: 0x2::balance::Balance<AIC>,
    }

    struct Invested has copy, drop {
        buyer: address,
        sui_amount: u64,
        pool_contribution: u64,
    }

    struct WithdrawForPlatformSUI has copy, drop {
        sui_amount: u64,
    }

    struct WithdrawForPlatformToken has copy, drop {
        token_amount: u64,
    }

    struct DestroyForPool has copy, drop {
        sui_amount: u64,
        token_amount: u64,
    }

    struct AMMSwap has copy, drop {
        transAddress: address,
        sui_amount: u64,
        token_amount: u64,
        burn_amount: u64,
        nft_amount: u64,
        is_buy: bool,
    }

    struct TokenPayment has copy, drop {
        buyer: address,
        token_amount: u64,
    }

    struct TransferAccounts has copy, drop {
        nowAddress: address,
        sendAddress: address,
        token_amount: u64,
    }

    struct NFTBatchMinted has copy, drop {
        nft_type: u64,
        quantity: u64,
    }

    struct NFTRewarded has copy, drop {
        rewarder: address,
        sendAddress: address,
        nft_type: u64,
        nft_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct BuyNft has copy, drop {
        sendAddress: address,
        nft_type: u64,
        nft_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct NFTTransferred has copy, drop {
        sender: address,
        sendAddress: address,
        timestamp: u64,
    }

    public entry fun mint(arg0: u64, arg1: &mut AicPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        0x2::balance::join<AIC>(&mut arg1.mining_token_balance, 0x2::coin::into_balance<AIC>(0x2::coin::mint<AIC>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<AIC>>(&mut arg1.treasury_cap), arg0, arg2)));
        0x2::balance::join<AIC>(&mut arg1.token_balance, 0x2::balance::split<AIC>(&mut arg1.mining_token_balance, 10000000000000000));
    }

    public entry fun batch_mint_nfts(arg0: u64, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: vector<u8>, arg8: &mut AicPlatform, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg8.owner, 0);
        assert!(arg2 > 0, 11);
        if (!0x2::table::contains<u64, vector<0x2::object::ID>>(&arg8.type_index, arg0)) {
            0x2::table::add<u64, vector<0x2::object::ID>>(&mut arg8.type_index, arg0, 0x1::vector::empty<0x2::object::ID>());
        };
        let v0 = 0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg8.type_index, arg0);
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = AicNFT{
                id        : 0x2::object::new(arg9),
                nft_type  : arg0,
                nft_name  : 0x1::string::utf8(arg3),
                nft_desc  : 0x1::string::utf8(arg4),
                nft_url   : 0x2::url::new_unsafe_from_bytes(arg5),
                amount    : arg1,
                rarity    : arg6,
                attribute : 0x1::string::utf8(arg7),
                mint_time : 0x2::tx_context::epoch(arg9),
            };
            let v3 = 0x2::object::uid_to_inner(&v2.id);
            0x2::table::add<0x2::object::ID, AicNFT>(&mut arg8.nft_table, v3, v2);
            0x1::vector::push_back<0x2::object::ID>(v0, v3);
            v1 = v1 + 1;
        };
        let v4 = NFTBatchMinted{
            nft_type : arg0,
            quantity : arg2,
        };
        0x2::event::emit<NFTBatchMinted>(v4);
    }

    public entry fun buy_nft(arg0: u64, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut AicPlatform, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 3);
        assert!(0x2::table::contains<u64, vector<0x2::object::ID>>(&arg2.type_index, arg0), 12);
        let v2 = 0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg2.type_index, arg0);
        assert!(0x1::vector::length<0x2::object::ID>(v2) > 0, 13);
        let v3 = *0x1::vector::borrow<0x2::object::ID>(v2, 0);
        let v4 = 0x2::table::remove<0x2::object::ID, AicNFT>(&mut arg2.nft_table, v3);
        assert!(v1 == v4.amount, 14);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.nft_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::transfer::public_transfer<AicNFT>(v4, v0);
        0x1::vector::remove<0x2::object::ID>(v2, 0);
        let v5 = BuyNft{
            sendAddress : v0,
            nft_type    : arg0,
            nft_id      : v3,
            timestamp   : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<BuyNft>(v5);
    }

    public entry fun buy_tokens_from_amm(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut AicPlatform, arg3: &mut AMMPool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_closed, 9);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2.is_amm_initialized, 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 >= 100, 3);
        let v2 = calculate_token_out(v1, 0x2::balance::value<0x2::sui::SUI>(&arg3.sui_reserve), 0x2::balance::value<AIC>(&arg3.token_reserve));
        assert!(0x2::balance::value<AIC>(&arg3.token_reserve) >= v2, 5);
        let v3 = calculate_tax(v2, 200);
        let v4 = calculate_tax(v2, 300);
        let v5 = v2 - v3 - v4;
        assert!(v5 >= arg1, 7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v6 = 0x2::balance::split<AIC>(&mut arg3.token_reserve, v2);
        if (v4 > 0) {
            0x2::balance::join<AIC>(&mut arg2.token_balance, 0x2::balance::split<AIC>(&mut v6, v4));
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<AIC>>(0x2::coin::from_balance<AIC>(0x2::balance::split<AIC>(&mut v6, v3), arg4), @0x0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<AIC>>(0x2::coin::from_balance<AIC>(v6, arg4), v0);
        let v7 = AMMSwap{
            transAddress : v0,
            sui_amount   : v1,
            token_amount : v5,
            burn_amount  : v3,
            nft_amount   : v4,
            is_buy       : true,
        };
        0x2::event::emit<AMMSwap>(v7);
    }

    public entry fun buyback_and_burn(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut AicPlatform, arg3: &mut AMMPool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 4);
        assert!(arg2.is_amm_initialized, 1);
        assert!(0x2::balance::value<AIC>(&arg3.token_reserve) >= arg1, 5);
        let v0 = calculate_sui_out(arg1, 0x2::balance::value<AIC>(&arg3.token_reserve), 0x2::balance::value<0x2::sui::SUI>(&arg3.sui_reserve));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIC>>(0x2::coin::from_balance<AIC>(0x2::balance::split<AIC>(&mut arg3.token_reserve, arg1), arg4), @0x0);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1) - v0;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v2), arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.sui_reserve, v1);
        let v3 = DestroyForPool{
            sui_amount   : v0,
            token_amount : arg1,
        };
        0x2::event::emit<DestroyForPool>(v3);
    }

    public fun calculate_sui_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 10);
        let v0 = (arg2 as u128) * (arg0 as u128) / ((arg1 as u128) + (arg0 as u128));
        assert!(v0 <= (arg2 as u128), 11);
        (v0 as u64)
    }

    public fun calculate_swap_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 10);
        let v0 = (arg0 as u128);
        (((arg2 as u128) * v0 / ((arg1 as u128) + v0)) as u64)
    }

    public fun calculate_tax(arg0: u64, arg1: u64) : u64 {
        let v0 = (10000 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 / 2) / v0) as u64)
    }

    public fun calculate_token_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 10);
        let v0 = (arg2 as u128) * (arg0 as u128) / ((arg1 as u128) + (arg0 as u128));
        assert!(v0 <= (arg2 as u128), 11);
        (v0 as u64)
    }

    public entry fun deposit_SUI_tokens(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut AicPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
    }

    public entry fun destroy_treasury_cap(arg0: &mut AicPlatform, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIC>>(0x1::option::extract<0x2::coin::TreasuryCap<AIC>>(&mut arg0.treasury_cap), @0x0);
    }

    public entry fun extract_sui_nft_platform(arg0: u64, arg1: address, arg2: &mut AicPlatform, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg2.owner, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.nft_balance) >= arg0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.nft_balance, arg0), arg3), arg1);
        let v0 = WithdrawForPlatformSUI{sui_amount: arg0};
        0x2::event::emit<WithdrawForPlatformSUI>(v0);
    }

    public entry fun extract_sui_platform(arg0: u64, arg1: address, arg2: &mut AicPlatform, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg2.owner, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.sui_balance) >= arg0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.sui_balance, arg0), arg3), arg1);
        let v0 = WithdrawForPlatformSUI{sui_amount: arg0};
        0x2::event::emit<WithdrawForPlatformSUI>(v0);
    }

    public entry fun extract_token_platform(arg0: u64, arg1: address, arg2: &mut AicPlatform, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg2.owner, 0);
        assert!(0x2::balance::value<AIC>(&arg2.token_balance) >= arg0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIC>>(0x2::coin::from_balance<AIC>(0x2::balance::split<AIC>(&mut arg2.token_balance, arg0), arg3), arg1);
        let v0 = WithdrawForPlatformToken{token_amount: arg0};
        0x2::event::emit<WithdrawForPlatformToken>(v0);
    }

    fun init(arg0: AIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIC>(arg0, 9, b"AIC", b"Ai Cat", b"AIC (Ai Cat) represents the next development of game value interaction protocols, built on high-performance SUI blockchain as the foundational energy center for decentralized gaming ecosystems. This innovative protocol achieves three core breakthroughs: zero latency instant payment processing, seamless cross game asset circulation, and an intelligent artificial intelligence economic system that automatically maintains balance. By utilizing SUI's advanced architecture, AIC has achieved real-time trading and reward distribution, while establishing universal standards for digital assets, allowing characters, items, and currency to freely flow in different game worlds. The integrated artificial intelligence engine continuously analyzes economic data, dynamically adjusts key parameters such as inflation rate and reward pool, to ensure the long-term health of the ecosystem. For developers, AIC provides SDK integration and customizable smart contract templates. Players gain true ownership of their assets through complete interoperability between games. Governance operates through a decentralized DAO structure, with stakeholders working together to guide protocol evolution. These features collectively push Web3 games from a simple 'play to earn' mode to a more sustainable 'play and earn' mode, creating an interconnected, player driven metaverse economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s3-figma-hubfile-images-production.figma.com/hub/file/carousel/img/8c53506f4de4769c8b66760ea6f8b3c4858ab26f/ba0f973be63d2950595fa3ef92fbed04fbe45147")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIC>>(v1);
        let v2 = AicPlatform{
            id                   : 0x2::object::new(arg1),
            owner                : 0x2::tx_context::sender(arg1),
            is_amm_initialized   : false,
            token_balance        : 0x2::balance::zero<AIC>(),
            sui_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            mining_token_balance : 0x2::balance::zero<AIC>(),
            mining_sign_owner    : 0x2::tx_context::sender(arg1),
            is_closed            : false,
            draw_balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            draw_sign_owner      : 0x2::tx_context::sender(arg1),
            treasury_cap         : 0x1::option::some<0x2::coin::TreasuryCap<AIC>>(v0),
            nft_table            : 0x2::table::new<0x2::object::ID, AicNFT>(arg1),
            type_index           : 0x2::table::new<u64, vector<0x2::object::ID>>(arg1),
            nft_sign_owner       : 0x2::tx_context::sender(arg1),
            nft_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<AicPlatform>(v2);
    }

    public entry fun initialize_amm_pool(arg0: &mut AicPlatform, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 0);
        assert!(!arg0.is_amm_initialized, 1);
        assert!(0x2::balance::value<AIC>(&arg0.token_balance) >= 1000000000000000, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= 1000000000, 3);
        let v1 = AMMPool{
            id            : 0x2::object::new(arg1),
            owner         : v0,
            sui_reserve   : 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 1000000000),
            token_reserve : 0x2::balance::split<AIC>(&mut arg0.token_balance, 1000000000000000),
        };
        arg0.is_amm_initialized = true;
        0x2::transfer::share_object<AMMPool>(v1);
    }

    public entry fun invest(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut AicPlatform, arg2: &mut AMMPool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_closed, 9);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 100, 3);
        let v1 = calculate_tax(v0, 200);
        assert!(v1 > 0, 3);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_balance, v2);
        let v3 = Invested{
            buyer             : 0x2::tx_context::sender(arg3),
            sui_amount        : v0,
            pool_contribution : v1,
        };
        0x2::event::emit<Invested>(v3);
    }

    public entry fun nft_transfer(arg0: AicNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<AicNFT>(arg0, arg1);
        let v0 = NFTTransferred{
            sender      : 0x2::tx_context::sender(arg2),
            sendAddress : arg1,
            timestamp   : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<NFTTransferred>(v0);
    }

    public entry fun reward_single_nft(arg0: u64, arg1: &mut AicPlatform, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.nft_sign_owner, 8);
        assert!(0x2::table::contains<u64, vector<0x2::object::ID>>(&arg1.type_index, arg0), 12);
        let v1 = 0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg1.type_index, arg0);
        assert!(0x1::vector::length<0x2::object::ID>(v1) > 0, 13);
        let v2 = *0x1::vector::borrow<0x2::object::ID>(v1, 0);
        0x1::vector::remove<0x2::object::ID>(v1, 0);
        0x2::transfer::public_transfer<AicNFT>(0x2::table::remove<0x2::object::ID, AicNFT>(&mut arg1.nft_table, v2), arg2);
        let v3 = NFTRewarded{
            rewarder    : v0,
            sendAddress : arg2,
            nft_type    : arg0,
            nft_id      : v2,
            timestamp   : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<NFTRewarded>(v3);
    }

    public entry fun sell_tokens_to_amm(arg0: 0x2::coin::Coin<AIC>, arg1: u64, arg2: &mut AicPlatform, arg3: &mut AMMPool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_closed, 9);
        assert!(arg2.is_amm_initialized, 1);
        let v0 = 0x2::coin::value<AIC>(&arg0);
        assert!(v0 > 0, 4);
        let v1 = calculate_tax(v0, 200);
        let v2 = calculate_tax(v0, 300);
        assert!(v1 + v2 < v0, 10);
        let v3 = calculate_sui_out(v0 - v2 - v1, 0x2::balance::value<AIC>(&arg3.token_reserve), 0x2::balance::value<0x2::sui::SUI>(&arg3.sui_reserve));
        assert!(v3 >= arg1, 7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg3.sui_reserve) >= v3, 6);
        let v4 = 0x2::coin::into_balance<AIC>(arg0);
        if (v2 > 0) {
            0x2::balance::join<AIC>(&mut arg2.token_balance, 0x2::balance::split<AIC>(&mut v4, v2));
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<AIC>>(0x2::coin::from_balance<AIC>(0x2::balance::split<AIC>(&mut v4, v1), arg4), @0x0);
        };
        0x2::balance::join<AIC>(&mut arg3.token_reserve, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg3.sui_reserve, v3), arg4), 0x2::tx_context::sender(arg4));
        let v5 = AMMSwap{
            transAddress : 0x2::tx_context::sender(arg4),
            sui_amount   : v3,
            token_amount : v0,
            burn_amount  : v1,
            nft_amount   : v2,
            is_buy       : false,
        };
        0x2::event::emit<AMMSwap>(v5);
    }

    public entry fun sui_mutual_conversion(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        let v1 = TransferAccounts{
            nowAddress   : 0x2::tx_context::sender(arg2),
            sendAddress  : arg1,
            token_amount : v0,
        };
        0x2::event::emit<TransferAccounts>(v1);
    }

    public entry fun sui_payment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut AicPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v1 = TokenPayment{
            buyer        : 0x2::tx_context::sender(arg2),
            token_amount : v0,
        };
        0x2::event::emit<TokenPayment>(v1);
    }

    public entry fun token_mutual_conversion(arg0: 0x2::coin::Coin<AIC>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<AIC>(&arg0);
        assert!(v0 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIC>>(arg0, arg1);
        let v1 = TransferAccounts{
            nowAddress   : 0x2::tx_context::sender(arg2),
            sendAddress  : arg1,
            token_amount : v0,
        };
        0x2::event::emit<TransferAccounts>(v1);
    }

    public entry fun token_payment(arg0: 0x2::coin::Coin<AIC>, arg1: &mut AicPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_closed, 9);
        let v0 = 0x2::coin::value<AIC>(&arg0);
        assert!(v0 > 0, 3);
        0x2::balance::join<AIC>(&mut arg1.token_balance, 0x2::coin::into_balance<AIC>(arg0));
        let v1 = TokenPayment{
            buyer        : 0x2::tx_context::sender(arg2),
            token_amount : v0,
        };
        0x2::event::emit<TokenPayment>(v1);
    }

    public entry fun update_draw_amount(arg0: u64, arg1: &mut AicPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.draw_balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, arg0));
    }

    public entry fun update_draw_sign_owner(arg0: address, arg1: &mut AicPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        arg1.draw_sign_owner = arg0;
    }

    public entry fun update_mining_sign_owner(arg0: address, arg1: &mut AicPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        arg1.mining_sign_owner = arg0;
    }

    public entry fun update_nft_sign_owner(arg0: address, arg1: &mut AicPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        arg1.nft_sign_owner = arg0;
    }

    public entry fun update_platform(arg0: bool, arg1: &mut AicPlatform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        arg1.is_closed = arg0;
    }

    public entry fun withdraw_amm_funds(arg0: &mut AicPlatform, arg1: &mut AMMPool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 0);
        assert!(arg0.is_amm_initialized, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIC>>(0x2::coin::from_balance<AIC>(0x2::balance::split<AIC>(&mut arg1.token_reserve, 0x2::balance::value<AIC>(&arg1.token_reserve)), arg2), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve)), arg2), v0);
    }

    public entry fun withdraw_draw_amount(arg0: &mut AicPlatform, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 0);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.draw_balance) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.draw_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.draw_balance)), arg1), v0);
        };
    }

    public entry fun withdraw_sui_Airdrop(arg0: u64, arg1: address, arg2: &mut AicPlatform, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_closed, 9);
        assert!(0x2::tx_context::sender(arg3) == arg2.draw_sign_owner, 8);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.draw_balance) >= arg0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.draw_balance, arg0), arg3), arg1);
        let v0 = WithdrawForPlatformToken{token_amount: arg0};
        0x2::event::emit<WithdrawForPlatformToken>(v0);
    }

    public entry fun withdrawal_token_mining(arg0: u64, arg1: address, arg2: &mut AicPlatform, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_closed, 9);
        assert!(0x2::tx_context::sender(arg3) == arg2.mining_sign_owner, 8);
        assert!(0x2::balance::value<AIC>(&arg2.token_balance) >= arg0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIC>>(0x2::coin::from_balance<AIC>(0x2::balance::split<AIC>(&mut arg2.token_balance, arg0), arg3), arg1);
        let v0 = WithdrawForPlatformToken{token_amount: arg0};
        0x2::event::emit<WithdrawForPlatformToken>(v0);
    }

    // decompiled from Move bytecode v6
}

