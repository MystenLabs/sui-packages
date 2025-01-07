module 0xce5fb43f06f109937ce0f45298b6dc632fc2c4116de438401a2540664f1ae050::nft_market {
    struct NFT has store, key {
        id: 0x2::object::UID,
        owner: address,
        votes: u64,
        on_market: bool,
        revenue: u64,
        total_revenue: u64,
        origin_owner_address: vector<u8>,
        origin_chain: vector<u8>,
        name: vector<u8>,
        token_id: u64,
        collection_address: vector<u8>,
    }

    struct UserRegistry has key {
        id: 0x2::object::UID,
        user_count: u64,
    }

    struct User has store, key {
        id: 0x2::object::UID,
        address: address,
        authorized_nfts: vector<vector<u8>>,
        vote_history: vector<vector<u8>>,
        print_history: vector<vector<u8>>,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        admin: address,
        vote_threshold: u64,
        commission_rate: u64,
    }

    struct NFT_MARKET has drop {
        dummy_field: bool,
    }

    public fun buy_print(arg0: &mut UserRegistry, arg1: &mut NFT, arg2: u64, arg3: &Config, arg4: &mut 0xce5fb43f06f109937ce0f45298b6dc632fc2c4116de438401a2540664f1ae050::nft_treasury::Treasury, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.on_market, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = arg2 * arg3.commission_rate / 100;
        arg1.revenue = arg1.revenue + v1;
        arg1.total_revenue = arg1.total_revenue + v1;
        0xce5fb43f06f109937ce0f45298b6dc632fc2c4116de438401a2540664f1ae050::nft_treasury::set_allowance(arg4, arg1.owner, arg1.revenue);
        0x1::vector::push_back<vector<u8>>(&mut get_or_create_user(arg0, v0, arg5).print_history, 0x2::object::uid_to_bytes(&arg1.id));
    }

    public fun claim_revenue(arg0: &mut NFT, arg1: &mut 0xce5fb43f06f109937ce0f45298b6dc632fc2c4116de438401a2540664f1ae050::nft_treasury::Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        let v0 = arg0.revenue;
        assert!(v0 > 0, 4);
        0xce5fb43f06f109937ce0f45298b6dc632fc2c4116de438401a2540664f1ae050::nft_treasury::withdraw_allowance(arg1, v0, arg2);
        arg0.revenue = 0;
    }

    public fun get_all_users_nfts(arg0: &UserRegistry) : (vector<address>, vector<vector<vector<u8>>>) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<vector<vector<u8>>>();
        let v2 = 0;
        while (v2 < arg0.user_count) {
            if (0x2::dynamic_field::exists_<u64>(&arg0.id, v2)) {
                let v3 = 0x2::dynamic_field::borrow<address, User>(&arg0.id, *0x2::dynamic_field::borrow<u64, address>(&arg0.id, v2));
                0x1::vector::push_back<address>(&mut v0, v3.address);
                0x1::vector::push_back<vector<vector<u8>>>(&mut v1, v3.authorized_nfts);
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_authorized_nfts(arg0: &UserRegistry, arg1: &0x2::tx_context::TxContext) : vector<vector<u8>> {
        0x2::dynamic_field::borrow<address, User>(&arg0.id, 0x2::tx_context::sender(arg1)).authorized_nfts
    }

    public fun get_current_user_data(arg0: &UserRegistry, arg1: &0x2::tx_context::TxContext) : (address, vector<vector<u8>>, vector<vector<u8>>, vector<vector<u8>>) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 0);
        let v1 = 0x2::dynamic_field::borrow<address, User>(&arg0.id, v0);
        (v1.address, v1.authorized_nfts, v1.vote_history, v1.print_history)
    }

    fun get_or_create_user(arg0: &mut UserRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &mut User {
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v0 = User{
                id              : 0x2::object::new(arg2),
                address         : arg1,
                authorized_nfts : 0x1::vector::empty<vector<u8>>(),
                vote_history    : 0x1::vector::empty<vector<u8>>(),
                print_history   : 0x1::vector::empty<vector<u8>>(),
            };
            0x2::dynamic_field::add<address, User>(&mut arg0.id, arg1, v0);
            0x2::dynamic_field::add<u64, address>(&mut arg0.id, arg0.user_count, arg1);
            arg0.user_count = arg0.user_count + 1;
        };
        0x2::dynamic_field::borrow_mut<address, User>(&mut arg0.id, arg1)
    }

    public fun get_print_history(arg0: &UserRegistry, arg1: &0x2::tx_context::TxContext) : vector<vector<u8>> {
        0x2::dynamic_field::borrow<address, User>(&arg0.id, 0x2::tx_context::sender(arg1)).print_history
    }

    public fun get_vote_history(arg0: &UserRegistry, arg1: &0x2::tx_context::TxContext) : vector<vector<u8>> {
        0x2::dynamic_field::borrow<address, User>(&arg0.id, 0x2::tx_context::sender(arg1)).vote_history
    }

    public fun has_printed_nft(arg0: &UserRegistry, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : bool {
        0x1::vector::contains<vector<u8>>(&0x2::dynamic_field::borrow<address, User>(&arg0.id, 0x2::tx_context::sender(arg2)).print_history, &arg1)
    }

    public fun has_voted_for_nft(arg0: &UserRegistry, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : bool {
        0x1::vector::contains<vector<u8>>(&0x2::dynamic_field::borrow<address, User>(&arg0.id, 0x2::tx_context::sender(arg2)).vote_history, &arg1)
    }

    fun init(arg0: NFT_MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UserRegistry{
            id         : 0x2::object::new(arg1),
            user_count : 0,
        };
        0x2::transfer::share_object<UserRegistry>(v0);
        let v1 = Config{
            id              : 0x2::object::new(arg1),
            admin           : 0x2::tx_context::sender(arg1),
            vote_threshold  : 10,
            commission_rate : 5,
        };
        0x2::transfer::share_object<Config>(v1);
        0x2::package::claim_and_keep<NFT_MARKET>(arg0, arg1);
    }

    public fun is_nft_authorized(arg0: &UserRegistry, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : bool {
        0x1::vector::contains<vector<u8>>(&0x2::dynamic_field::borrow<address, User>(&arg0.id, 0x2::tx_context::sender(arg2)).authorized_nfts, &arg1)
    }

    public fun register_wormhole_nft(arg0: &mut UserRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::new(arg6);
        let v2 = NFT{
            id                   : v1,
            owner                : v0,
            votes                : 0,
            on_market            : false,
            revenue              : 0,
            total_revenue        : 0,
            origin_owner_address : arg2,
            origin_chain         : arg1,
            name                 : arg5,
            token_id             : arg3,
            collection_address   : arg4,
        };
        0x1::vector::push_back<vector<u8>>(&mut get_or_create_user(arg0, v0, arg6).authorized_nfts, 0x2::object::uid_to_bytes(&v2.id));
        0x2::transfer::share_object<NFT>(v2);
    }

    public fun revoke_nft_authorization(arg0: &mut UserRegistry, arg1: &NFT, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.owner == v0, 11);
        let v1 = get_or_create_user(arg0, v0, arg2);
        let v2 = 0x2::object::uid_to_bytes(&arg1.id);
        assert!(0x1::vector::contains<vector<u8>>(&v1.authorized_nfts, &v2), 9);
        let (v3, v4) = 0x1::vector::index_of<vector<u8>>(&v1.authorized_nfts, &v2);
        if (v3) {
            0x1::vector::remove<vector<u8>>(&mut v1.authorized_nfts, v4);
        };
    }

    public entry fun setup_config(arg0: &mut Config, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg0.vote_threshold = arg1;
        arg0.commission_rate = arg2;
    }

    public fun update_commission_rate(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 7);
        arg0.commission_rate = arg1;
    }

    public fun update_vote_threshold(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 6);
        arg0.vote_threshold = arg1;
    }

    public fun vote_nft(arg0: &mut UserRegistry, arg1: &mut NFT, arg2: &Config, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = get_or_create_user(arg0, v0, arg3);
        let v2 = 0x2::object::uid_to_bytes(&arg1.id);
        assert!(!0x1::vector::contains<vector<u8>>(&v1.vote_history, &v2), 2);
        0x1::vector::push_back<vector<u8>>(&mut v1.vote_history, v2);
        arg1.votes = arg1.votes + 1;
        if (arg1.votes >= arg2.vote_threshold) {
            arg1.on_market = true;
        };
    }

    // decompiled from Move bytecode v6
}

