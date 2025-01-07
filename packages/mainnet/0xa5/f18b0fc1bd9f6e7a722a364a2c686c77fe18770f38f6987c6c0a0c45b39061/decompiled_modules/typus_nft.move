module 0xa5f18b0fc1bd9f6e7a722a364a2c686c77fe18770f38f6987c6c0a0c45b39061::typus_nft {
    struct TYPUS_NFT has drop {
        dummy_field: bool,
    }

    struct Tails has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        number: u64,
        url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        level: u64,
        exp: u64,
        first_bid: bool,
        first_deposit: bool,
        first_deposit_nft: bool,
    }

    struct ManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        tails: vector<Tails>,
        num: u64,
        is_live: bool,
    }

    struct Whitelist has key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    entry fun batch_deposit_nft(arg0: &ManagerCap, arg1: &mut Pool, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: vector<vector<0x1::string::String>>, arg6: vector<vector<0x1::string::String>>, arg7: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<0x1::string::String>(&arg2) > 0) {
            0x1::vector::push_back<Tails>(&mut arg1.tails, new_nft(0x1::vector::pop_back<0x1::string::String>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), 0x2::url::new_unsafe_from_bytes(0x1::vector::pop_back<vector<u8>>(&mut arg4)), from_vec_to_map<0x1::string::String, 0x1::string::String>(0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg5), 0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg6)), arg7));
            arg1.num = arg1.num + 1;
        };
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0, 3);
        assert!(0x1::vector::length<u64>(&arg3) == 0, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == 0, 3);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg5) == 0, 3);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg6) == 0, 3);
    }

    entry fun deposit_nft(arg0: &ManagerCap, arg1: &mut Pool, arg2: 0x1::string::String, arg3: u64, arg4: vector<u8>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<Tails>(&mut arg1.tails, new_nft(arg2, arg3, 0x2::url::new_unsafe_from_bytes(arg4), from_vec_to_map<0x1::string::String, 0x1::string::String>(arg5, arg6), arg7));
        arg1.num = arg1.num + 1;
    }

    fun extract_balance<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            if (arg1 > 0) {
                let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
                if (0x2::coin::value<T0>(&v1) >= arg1) {
                    0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut v1), arg1));
                    0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg0, v1);
                    arg1 = 0;
                    break
                };
                arg1 = arg1 - 0x2::coin::value<T0>(&v1);
                0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(v1));
            } else {
                break
            };
        };
        assert!(arg1 == 0, 0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0), 0x2::tx_context::sender(arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    entry fun free_mint(arg0: &mut Pool, arg1: Whitelist, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Tails>(&arg0.tails);
        assert!(v0 > 0, 4);
        let Whitelist {
            id  : v1,
            for : v2,
        } = arg1;
        0x2::object::delete(v1);
        assert!(v2 == 0x2::object::id<Pool>(arg0), 1);
        let (v3, v4) = 0x2::kiosk::new(arg2);
        let v5 = v4;
        let v6 = v3;
        0x2::kiosk::place<Tails>(&mut v6, &v5, 0x1::vector::remove<Tails>(&mut arg0.tails, ((0xa5f18b0fc1bd9f6e7a722a364a2c686c77fe18770f38f6987c6c0a0c45b39061::utils::rand(arg2) % ((v0 - 1) as u256)) as u64)));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v6);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v5, 0x2::tx_context::sender(arg2));
    }

    entry fun free_mint_into_kiosk(arg0: &mut Pool, arg1: Whitelist, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Tails>(&arg0.tails);
        assert!(v0 > 0, 4);
        let Whitelist {
            id  : v1,
            for : v2,
        } = arg1;
        0x2::object::delete(v1);
        assert!(v2 == 0x2::object::id<Pool>(arg0), 1);
        0x2::kiosk::place<Tails>(arg2, arg3, 0x1::vector::remove<Tails>(&mut arg0.tails, ((0xa5f18b0fc1bd9f6e7a722a364a2c686c77fe18770f38f6987c6c0a0c45b39061::utils::rand(arg4) % ((v0 - 1) as u256)) as u64)));
    }

    fun from_vec_to_map<T0: copy + drop, T1: drop>(arg0: vector<T0>, arg1: vector<T1>) : 0x2::vec_map::VecMap<T0, T1> {
        assert!(0x1::vector::length<T0>(&arg0) == 0x1::vector::length<T1>(&arg1), 2);
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<T0, T1>();
        while (v0 < 0x1::vector::length<T0>(&arg0)) {
            0x2::vec_map::insert<T0, T1>(&mut v1, 0x1::vector::pop_back<T0>(&mut arg0), 0x1::vector::pop_back<T1>(&mut arg1));
            v0 = v0 + 1;
        };
        v1
    }

    fun init(arg0: TYPUS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TYPUS_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<Tails>(&v0, arg1);
        0x2::display::add<Tails>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Tails>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Tails>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Tails>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Tails>(&mut v1, 0x1::string::utf8(b"level"), 0x1::string::utf8(b"{level}"));
        0x2::display::add<Tails>(&mut v1, 0x1::string::utf8(b"exp"), 0x1::string::utf8(b"{exp}"));
        0x2::display::update_version<Tails>(&mut v1);
        let v2 = ManagerCap{id: 0x2::object::new(arg1)};
        let (v3, v4) = 0x2::transfer_policy::new<Tails>(&v0, arg1);
        let v5 = v4;
        let v6 = v3;
        0xa5f18b0fc1bd9f6e7a722a364a2c686c77fe18770f38f6987c6c0a0c45b39061::royalty_rule::add<Tails>(&mut v6, &v5, 1000, 1000000000);
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v7);
        0x2::transfer::public_transfer<0x2::display::Display<Tails>>(v1, v7);
        0x2::transfer::public_transfer<ManagerCap>(v2, v7);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Tails>>(v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Tails>>(v5, v7);
    }

    entry fun issue_whitelist(arg0: &ManagerCap, arg1: &Pool, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v0 = Whitelist{
                id  : 0x2::object::new(arg3),
                for : 0x2::object::id<Pool>(arg1),
            };
            0x2::transfer::transfer<Whitelist>(v0, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    fun level_up(arg0: &mut Tails) {
        if (arg0.exp >= 500000) {
            arg0.level = 7;
        } else if (arg0.exp >= 100000) {
            arg0.level = 6;
        } else if (arg0.exp >= 50000) {
            arg0.level = 5;
        } else if (arg0.exp >= 25000) {
            arg0.level = 4;
        } else if (arg0.exp >= 12500) {
            arg0.level = 3;
        } else if (arg0.exp >= 3000) {
            arg0.level = 2;
        };
    }

    public fun level_up_with_sui(arg0: &mut Tails, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = extract_balance<0x2::sui::SUI>(arg1, arg2, arg3);
        arg0.exp = arg0.exp + 0x2::balance::value<0x2::sui::SUI>(&v0) / 1000000000 * 100;
        level_up(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), @0x978f65df8570a075298598a9965c18de9087f9e888eb3430fe20334f5c554cfd);
    }

    fun new_nft(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::url::Url, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : Tails {
        Tails{
            id                : 0x2::object::new(arg4),
            name              : arg0,
            description       : 0x1::string::utf8(b"A collection of 6666 3D Dynamic NFTs."),
            number            : arg1,
            url               : arg2,
            attributes        : arg3,
            level             : 1,
            exp               : 0,
            first_bid         : false,
            first_deposit     : false,
            first_deposit_nft : false,
        }
    }

    entry fun new_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id      : 0x2::object::new(arg0),
            tails   : 0x1::vector::empty<Tails>(),
            num     : 0,
            is_live : false,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public fun nft_exp_up(arg0: &ManagerCap, arg1: &mut Tails, arg2: u64) {
        arg1.exp = arg1.exp + arg2;
        level_up(arg1);
    }

    public fun take_tails(arg0: &ManagerCap, arg1: &mut Tails, arg2: vector<u8>) {
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    public fun update_image_url(arg0: &ManagerCap, arg1: &mut Tails, arg2: vector<u8>) {
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    entry fun update_sale(arg0: &ManagerCap, arg1: &mut Pool, arg2: bool) {
        arg1.is_live = arg2;
    }

    entry fun withdraw_nft(arg0: &ManagerCap, arg1: &mut Pool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.num;
        while (v0 > 0) {
            0x2::transfer::public_transfer<Tails>(0x1::vector::pop_back<Tails>(&mut arg1.tails), 0x2::tx_context::sender(arg2));
            v0 = v0 - 1;
        };
    }

    // decompiled from Move bytecode v6
}

