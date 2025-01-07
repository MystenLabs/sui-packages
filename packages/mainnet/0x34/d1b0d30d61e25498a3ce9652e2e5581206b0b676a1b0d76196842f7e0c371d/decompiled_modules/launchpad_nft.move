module 0x34d1b0d30d61e25498a3ce9652e2e5581206b0b676a1b0d76196842f7e0c371d::launchpad_nft {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTRawData has copy, drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct Launchpad has key {
        id: 0x2::object::UID,
        owner: address,
        total_supply: u64,
        total_minted: u64,
        start_time: u64,
        end_time: u64,
        price: u64,
        whitelist: vector<address>,
        limit_per_wallet: u64,
        total_premint: u64,
        is_preminted: bool,
        raw_data: vector<NFTRawData>,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        wallet: address,
        transaction_fee: u64,
        transaction_fee_decimal_place: u8,
    }

    struct UserBuyData has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct MintNFTEvent has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public entry fun add_nft_raw_data(arg0: &AdminCap, arg1: &mut Launchpad, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v1 = NFTRawData{
                name        : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg2, v0)),
                description : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg3, v0)),
                image_url   : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v0)),
            };
            0x1::vector::push_back<NFTRawData>(&mut arg1.raw_data, v1);
            v0 = v0 + 1;
        };
    }

    public entry fun add_to_whitelist(arg0: &AdminCap, arg1: &mut Launchpad, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x1::vector::push_back<address>(&mut arg1.whitelist, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    public entry fun create_launchpad(arg0: &AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<address>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= arg2, 111);
        let v0 = Launchpad{
            id               : 0x2::object::new(arg9),
            owner            : arg1,
            total_supply     : arg2,
            total_minted     : 0,
            start_time       : arg3,
            end_time         : arg4,
            price            : arg5,
            whitelist        : arg6,
            limit_per_wallet : arg7,
            total_premint    : arg8,
            is_preminted     : false,
            raw_data         : 0x1::vector::empty<NFTRawData>(),
        };
        0x2::transfer::share_object<Launchpad>(v0);
    }

    fun get_now_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Marketplace{
            id                            : 0x2::object::new(arg0),
            wallet                        : @0x5667295fdc3e4ff8a6a9f4807dab36d3ba9d33a3ab55ceefc6dc9ed87e94742f,
            transaction_fee               : 0,
            transaction_fee_decimal_place : 3,
        };
        0x2::transfer::share_object<Marketplace>(v1);
    }

    fun merge_and_split(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) >= arg1, 108);
        (0x2::coin::split<0x2::sui::SUI>(&mut v0, arg1, arg2), v0)
    }

    public entry fun mint_nft(arg0: &Marketplace, arg1: &mut Launchpad, arg2: u64, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = get_now_seconds(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        let (v2, v3) = merge_and_split(arg3, arg1.price * arg2, arg5);
        let (v4, _) = 0x1::vector::index_of<address>(&arg1.whitelist, &v1);
        let v6 = 0x1::string::utf8(b"user_buy_data_");
        0x1::string::append(&mut v6, 0x2::address::to_string(v1));
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, v6)) {
            let v7 = UserBuyData{
                id     : 0x2::object::new(arg5),
                amount : 0,
            };
            0x2::dynamic_object_field::add<0x1::string::String, UserBuyData>(&mut arg1.id, v6, v7);
        };
        let v8 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, UserBuyData>(&mut arg1.id, v6);
        assert!(v8.amount + arg2 <= arg1.limit_per_wallet, 107);
        assert!(!(0x1::vector::length<address>(&arg1.whitelist) > 0) || v4, 106);
        assert!(v0 >= arg1.start_time, 103);
        assert!(v0 <= arg1.end_time, 104);
        assert!(arg2 + arg1.total_minted <= arg1.total_supply, 105);
        let v9 = 0;
        while (v9 < arg2) {
            mint_nft_from_raw_data(arg5, v1, *0x1::vector::borrow<NFTRawData>(&arg1.raw_data, arg1.total_minted + v9));
            v9 = v9 + 1;
        };
        arg1.total_minted = arg1.total_minted + arg2;
        v8.amount = v8.amount + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, arg0.wallet);
    }

    fun mint_nft_from_raw_data(arg0: &mut 0x2::tx_context::TxContext, arg1: address, arg2: NFTRawData) {
        let v0 = NFT{
            id          : 0x2::object::new(arg0),
            name        : arg2.name,
            description : arg2.description,
            url         : 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&arg2.image_url)),
        };
        let v1 = MintNFTEvent{
            nft_id      : 0x2::object::id<NFT>(&v0),
            minter      : arg1,
            name        : v0.name,
            description : v0.description,
            url         : v0.url,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        0x2::transfer::public_transfer<NFT>(v0, arg1);
    }

    public entry fun premint(arg0: &AdminCap, arg1: &mut Launchpad, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_now_seconds(arg2);
        assert!(!arg1.is_preminted, 101);
        assert!(arg1.start_time - v0 <= 3600 && arg1.start_time > v0, 102);
        assert!(arg1.total_premint > 0, 100);
        let v1 = 0;
        while (v1 < arg1.total_premint) {
            mint_nft_from_raw_data(arg3, arg1.owner, *0x1::vector::borrow<NFTRawData>(&arg1.raw_data, v1));
            v1 = v1 + 1;
        };
        arg1.total_minted = arg1.total_minted + arg1.total_premint;
        arg1.is_preminted = true;
    }

    public entry fun remove_from_whitelist(arg0: &AdminCap, arg1: &mut Launchpad, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg2);
            let (v1, v2) = 0x1::vector::index_of<address>(&arg1.whitelist, &v0);
            if (v1) {
                0x1::vector::remove<address>(&mut arg1.whitelist, v2);
            };
        };
    }

    public entry fun set_marketplace_transaction_fee(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.transaction_fee = arg2;
        arg1.transaction_fee_decimal_place = arg3;
    }

    public entry fun set_marketplace_wallet(arg0: &AdminCap, arg1: &mut Marketplace, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.wallet = arg2;
    }

    // decompiled from Move bytecode v6
}

