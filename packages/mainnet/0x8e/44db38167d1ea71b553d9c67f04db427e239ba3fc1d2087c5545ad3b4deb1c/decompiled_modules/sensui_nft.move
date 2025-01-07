module 0x8e44db38167d1ea71b553d9c67f04db427e239ba3fc1d2087c5545ad3b4deb1c::sensui_nft {
    struct SenSuiNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMintData has store, key {
        id: 0x2::object::UID,
        nft_minted: u64,
        max_supply: u64,
        owner_event: address,
        has_paused: bool,
        is_resume: bool,
        time_start_event: u64,
        users_mint_data: 0x2::bag::Bag,
    }

    struct MintNFTEvent has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public entry fun transfer(arg0: SenSuiNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SenSuiNFT>(arg0, arg1);
    }

    public fun url(arg0: &SenSuiNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun description(arg0: &SenSuiNFT) : &0x1::string::String {
        &arg0.description
    }

    fun get_now_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTMintData{
            id               : 0x2::object::new(arg0),
            nft_minted       : 0,
            max_supply       : 100000,
            owner_event      : @0xf8c2b01934301cfb98bf48724165d78f88f41af54c19518e2c6a4bc7fd52ac47,
            has_paused       : false,
            is_resume        : false,
            time_start_event : 0,
            users_mint_data  : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<NFTMintData>(v0);
    }

    fun merge_and_split(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) >= arg1, 101);
        (0x2::coin::split<0x2::sui::SUI>(&mut v0, arg1, arg2), v0)
    }

    public entry fun mint_to_sender(arg0: &mut NFTMintData, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = get_now_seconds(arg6);
        assert!(arg0.nft_minted <= arg0.max_supply, 100);
        assert!(arg0.time_start_event > 0, 103);
        assert!(arg0.has_paused == false, 105);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        if (arg0.nft_minted <= 10000 && v1 / 3600 - arg0.time_start_event / 3600 <= 120 && !arg0.is_resume) {
            if (arg5 >= 1 && arg5 <= 6) {
                v2 = 1200000000;
            } else if (arg5 >= 7) {
                v2 = 1000000000;
            };
        } else {
            v2 = 1600000000;
            v3 = 72000000;
            v4 = 18000000;
        };
        let (v5, v6) = merge_and_split(arg4, v2, arg7);
        let v7 = v6;
        if (!0x2::bag::contains<address>(&arg0.users_mint_data, v0)) {
            0x2::bag::add<address, u64>(&mut arg0.users_mint_data, v0, v1);
        } else {
            assert!(v1 / 86400 - *0x2::bag::borrow<address, u64>(&mut arg0.users_mint_data, v0) / 86400 > 0, 102);
            0x2::bag::remove<address, u64>(&mut arg0.users_mint_data, v0);
            0x2::bag::add<address, u64>(&mut arg0.users_mint_data, v0, v1);
        };
        if (v3 > 0 && v4 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&v7) > v3 + v4, 101);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v3, arg7), @0x606d0751f8ed5a200808c058b8b69ff4c757991a527a20163e1764c9f9291bdc);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v4, arg7), @0x48b18f250b26f9ff57cbe872a7802725c9413cc6a0ba2dfc3a03ae3a7d5ab405);
        };
        arg0.nft_minted = arg0.nft_minted + 1;
        let v8 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v8, arg1);
        0x1::string::append_utf8(&mut v8, b" #");
        let v9 = to_string(arg0.nft_minted);
        0x1::string::append_utf8(&mut v8, *0x1::string::bytes(&v9));
        let v10 = SenSuiNFT{
            id          : 0x2::object::new(arg7),
            name        : 0x1::string::utf8(*0x1::string::bytes(&v8)),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v11 = MintNFTEvent{
            nft_id      : 0x2::object::id<SenSuiNFT>(&v10),
            minter      : v0,
            name        : v10.name,
            description : v10.description,
            url         : v10.url,
        };
        0x2::event::emit<MintNFTEvent>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, @0x6899c0803998f7d5b06758a03be3a8c8d26359d5e1dcec4de16333be6a6cab86);
        0x2::transfer::public_transfer<SenSuiNFT>(v10, v0);
    }

    public fun name(arg0: &SenSuiNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun pause_event(arg0: &mut NFTMintData, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner_event || v0 == @0x6f48615e72481747d4bd88f6dea9e9643199804b3eba4a432f801750c170b6d4, 104);
        arg0.has_paused = true;
    }

    public entry fun resume_event(arg0: &mut NFTMintData, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner_event || v0 == @0x6f48615e72481747d4bd88f6dea9e9643199804b3eba4a432f801750c170b6d4, 104);
        arg0.has_paused = false;
        arg0.is_resume = true;
    }

    public entry fun start_event(arg0: &mut NFTMintData, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner_event || v0 == @0x6f48615e72481747d4bd88f6dea9e9643199804b3eba4a432f801750c170b6d4, 104);
        assert!(arg0.time_start_event == 0, 106);
        arg0.time_start_event = get_now_seconds(arg1);
    }

    fun to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun update_description(arg0: &mut SenSuiNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

