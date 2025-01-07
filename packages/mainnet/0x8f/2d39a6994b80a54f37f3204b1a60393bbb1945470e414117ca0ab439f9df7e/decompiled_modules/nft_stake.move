module 0x8f2d39a6994b80a54f37f3204b1a60393bbb1945470e414117ca0ab439f9df7e::nft_stake {
    struct NFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct RTN has drop {
        dummy_field: bool,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        admin: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        treasury: address,
        base_url: 0x1::string::String,
        total: u64,
        sui_fee: u64,
        reward_per_day: u64,
        last_index: u64,
        token_supply: 0x2::balance::Supply<RTN>,
    }

    struct Record has key {
        id: 0x2::object::UID,
        owner: vector<address>,
        token_id: vector<u64>,
        update_time: vector<u64>,
    }

    public entry fun claim(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut Collection, arg3: &mut Record, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2.treasury;
        let v1 = get_transfer_sui<0x2::sui::SUI>(arg0, arg2.sui_fee, v0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0;
        let v4 = 0;
        loop {
            if (v4 == 0x1::vector::length<address>(&arg3.owner)) {
                break
            };
            if (*0x1::vector::borrow<address>(&arg3.owner, v4) == v2) {
                let v5 = 0x1::vector::borrow_mut<u64>(&mut arg3.update_time, v4);
                v3 = v3 + (arg1 - *v5) * 10 / 3600;
                *v5 = arg1;
            };
            v4 = v4 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<RTN>>(0x2::coin::from_balance<RTN>(0x2::balance::increase_supply<RTN>(&mut arg2.token_supply, v3), arg4), v2);
    }

    public fun get_transfer_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x2::coin::value<T0>(&arg0) == arg1) {
            return arg0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        0x2::coin::split<T0>(&mut arg0, arg1, arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = RTN{dummy_field: false};
        let v2 = Collection{
            id             : 0x2::object::new(arg0),
            admin          : v0,
            name           : 0x1::string::utf8(b"Rotten us Unstaked"),
            description    : 0x1::string::utf8(b"Rotten Us 10 unique rotten characters on Sui."),
            treasury       : v0,
            base_url       : 0x1::string::utf8(b"https://QmU4GxmFpyBiAJCExpdMAFiBfTDhPceuxZhVrFWnjWcET9/"),
            total          : 20000,
            sui_fee        : 1000000,
            reward_per_day : 10,
            last_index     : 350,
            token_supply   : 0x2::balance::create_supply<RTN>(v1),
        };
        0x2::transfer::share_object<Collection>(v2);
        let v3 = Record{
            id          : 0x2::object::new(arg0),
            owner       : 0x1::vector::empty<address>(),
            token_id    : 0x1::vector::empty<u64>(),
            update_time : 0x1::vector::empty<u64>(),
        };
        0x2::transfer::share_object<Record>(v3);
    }

    public fun mint_single_nft(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg4),
            token_id    : arg0,
            name        : arg1,
            description : arg2,
            url         : 0x2::url::new_unsafe(0x1::string::to_ascii(arg3)),
        };
        0x2::transfer::public_transfer<NFT>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun num_to_str(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        loop {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
            if (arg0 == 0) {
                break
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun reset_admin(arg0: address, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        arg1.admin = arg0;
    }

    public entry fun reset_base_url(arg0: vector<u8>, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        arg1.base_url = 0x1::string::utf8(arg0);
    }

    public entry fun reset_reward_per_day(arg0: u64, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        arg1.reward_per_day = arg0;
    }

    public entry fun reset_sui_fee(arg0: u64, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        arg1.sui_fee = arg0;
    }

    public entry fun reset_total(arg0: u64, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        arg1.total = arg0;
    }

    public entry fun reset_treasury(arg0: address, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        arg1.treasury = arg0;
    }

    public entry fun stake(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut Collection, arg3: &mut Record, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2.last_index;
        assert!(v0 < arg2.total, 2);
        let v1 = arg2.treasury;
        let v2 = get_transfer_sui<0x2::sui::SUI>(arg0, arg2.sui_fee, v1, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v1);
        0x1::vector::push_back<address>(&mut arg3.owner, 0x2::tx_context::sender(arg4));
        0x1::vector::push_back<u64>(&mut arg3.token_id, v0);
        0x1::vector::push_back<u64>(&mut arg3.update_time, arg1);
        arg2.last_index = arg2.last_index + 1;
    }

    public entry fun unstake(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &mut Collection, arg4: &mut Record, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3.treasury;
        let v1 = get_transfer_sui<0x2::sui::SUI>(arg0, arg3.sui_fee, v0, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
        let (v2, v3) = 0x1::vector::index_of<u64>(&arg4.token_id, &arg1);
        assert!(v2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<RTN>>(0x2::coin::from_balance<RTN>(0x2::balance::increase_supply<RTN>(&mut arg3.token_supply, (arg2 - *0x1::vector::borrow<u64>(&arg4.update_time, v3)) * 10 / 3600), arg5), 0x2::tx_context::sender(arg5));
        let v4 = arg3.base_url;
        0x1::string::append(&mut v4, 0x1::string::utf8(num_to_str(arg1)));
        0x1::string::append(&mut v4, 0x1::string::utf8(b".jpg"));
        mint_single_nft(arg1, arg3.name, arg3.description, v4, arg5);
        0x1::vector::remove<address>(&mut arg4.owner, v3);
        0x1::vector::remove<u64>(&mut arg4.token_id, v3);
        0x1::vector::remove<u64>(&mut arg4.update_time, v3);
    }

    // decompiled from Move bytecode v6
}

