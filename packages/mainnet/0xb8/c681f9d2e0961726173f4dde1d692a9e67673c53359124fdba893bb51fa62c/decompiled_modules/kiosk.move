module 0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::kiosk {
    struct KIOSK has drop {
        dummy_field: bool,
    }

    struct KioskRegistry has store, key {
        id: 0x2::object::UID,
        kiosks: vector<0x2::object::ID>,
        owners: vector<address>,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        kiosk_sponsor_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        kiosk_creation_fee: u64,
        owner: address,
    }

    struct KioskItem has drop, store {
        id: u64,
        title: vector<u8>,
        content_cid: vector<u8>,
        price: u64,
        timestamp: u64,
    }

    struct KioskNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        price: u64,
        timestamp: u64,
        metadata: vector<u8>,
    }

    struct UserKiosk has store, key {
        id: 0x2::object::UID,
        owner: address,
        items: vector<KioskItem>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun buy_item(arg0: &mut KioskRegistry, arg1: &mut UserKiosk, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(has_item(arg1, arg2), 1);
        let v0 = 0x1::option::none<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<KioskItem>(&arg1.items)) {
            if (0x1::vector::borrow<KioskItem>(&arg1.items, v1).id == arg2) {
                v0 = 0x1::option::some<u64>(v1);
                break
            };
            v1 = v1 + 1;
        };
        let v2 = 0x1::option::get_with_default<u64>(&v0, 0);
        let v3 = 0x1::vector::borrow<KioskItem>(&arg1.items, v2).price;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v3, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.kiosk_sponsor_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v3 * 5 / 100, arg4)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v4 = 0x1::vector::remove<KioskItem>(&mut arg1.items, v2);
        let v5 = 0x1::string::utf8(b"https://bronze-quiet-cuckoo-704.mypinata.cloud/ipfs/");
        0x1::string::append(&mut v5, 0x1::string::utf8(v4.content_cid));
        let v6 = KioskNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(v4.title),
            image_url   : v5,
            description : 0x1::string::utf8(b"This is a test item."),
            price       : v4.price,
            timestamp   : v4.timestamp,
            metadata    : create_metadata_json(v4.title, v4.content_cid, v4.price, v4.timestamp),
        };
        0x2::transfer::public_transfer<KioskNFT>(v6, 0x2::tx_context::sender(arg4));
    }

    fun create_metadata_json(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = 0x1::string::utf8(x"7b0a");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"  \"name\": \""));
        0x1::string::append(&mut v0, 0x1::string::utf8(arg0));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"222c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"  \"image\": \"https://bronze-quiet-cuckoo-704.mypinata.cloud/ipfs/"));
        0x1::string::append(&mut v0, 0x1::string::utf8(arg1));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"222c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"2020226465736372697074696f6e223a20225468697320697320612074657374206974656d2e222c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"  \"price\": "));
        0x1::string::append(&mut v0, to_string(arg2));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"2c0a"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"  \"timestamp\": "));
        0x1::string::append(&mut v0, to_string(arg3));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a7d"));
        let v1 = 0x1::string::as_bytes(&v0);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v1)) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(v1, v3));
            v3 = v3 + 1;
        };
        v2
    }

    public entry fun delete_item(arg0: &mut UserKiosk, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0, 0x2::tx_context::sender(arg2)), 3);
        assert!(has_item(arg0, arg1), 1);
        let v0 = 0x1::option::none<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<KioskItem>(&arg0.items)) {
            if (0x1::vector::borrow<KioskItem>(&arg0.items, v1).id == arg1) {
                v0 = 0x1::option::some<u64>(v1);
                break
            };
            v1 = v1 + 1;
        };
        0x1::vector::remove<KioskItem>(&mut arg0.items, 0x1::option::get_with_default<u64>(&v0, 0));
    }

    public entry fun distribute_fees(arg0: &mut KioskRegistry, arg1: &mut 0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::nft_staking::StakingPool, arg2: &0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::nft_staking::NFTCollectionRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.kiosk_sponsor_fees);
        assert!(v0 > 0, 6);
        let v1 = 0x2::coin::take<0x2::sui::SUI>(&mut arg0.kiosk_sponsor_fees, v0, arg3);
        let v2 = vector[10, 10, 10, 10];
        let v3 = vector[10, 100, 1000, 10000];
        let v4 = 0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::nft_staking::get_staked_nfts(arg1);
        let v5 = 0x1::vector::length<0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::nft_staking::StakedNFT>(v4);
        let v6 = vector[0, 0, 0, 0];
        let v7 = 0x1::vector::empty<address>();
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0;
        while (v9 < v5) {
            let v10 = 0x1::vector::borrow<0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::nft_staking::StakedNFT>(v4, v9);
            let v11 = (0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::nft_staking::get_tier(v10, arg2) as u64) - 1;
            *0x1::vector::borrow_mut<u64>(&mut v6, v11) = *0x1::vector::borrow<u64>(&v6, v11) + 1;
            0x1::vector::push_back<address>(&mut v7, 0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::nft_staking::get_owner(v10));
            0x1::vector::push_back<u64>(&mut v8, v11);
            v9 = v9 + 1;
        };
        let v12 = 0;
        let v13 = 0x1::vector::empty<u64>();
        v9 = 0;
        while (v9 < 4) {
            let v14 = v0 * *0x1::vector::borrow<u64>(&v2, v9) / 100;
            let v15 = *0x1::vector::borrow<u64>(&v6, v9);
            let v16 = if (v15 > 0) {
                let v17 = v15 * v14 / *0x1::vector::borrow<u64>(&v3, v9);
                if (v17 > v14) {
                    v14
                } else {
                    v17
                }
            } else {
                0
            };
            v12 = v12 + v16;
            let v18 = if (v15 > 0) {
                v16 / v15
            } else {
                0
            };
            let v19 = 0;
            while (v19 < v5) {
                if (*0x1::vector::borrow<u64>(&v8, v19) == v9) {
                    0x1::vector::push_back<u64>(&mut v13, v18);
                };
                v19 = v19 + 1;
            };
            v9 = v9 + 1;
        };
        if (v5 > 0) {
            v9 = 0;
            while (v9 < v5) {
                let v20 = *0x1::vector::borrow<u64>(&v13, v9);
                if (v20 > 0) {
                    0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::nft_staking::add_to_user_balance(arg1, *0x1::vector::borrow<address>(&v7, v9), 0x2::coin::split<0x2::sui::SUI>(&mut v1, v20, arg3), arg3);
                };
                v9 = v9 + 1;
            };
        };
        let v21 = v0 - v12;
        if (v21 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v21, arg3), arg0.owner);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.kiosk_sponsor_fees, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
    }

    public fun get_kiosk_balance(arg0: &UserKiosk) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_kiosk_length(arg0: &UserKiosk) : u64 {
        0x1::vector::length<KioskItem>(&arg0.items)
    }

    public fun get_owner(arg0: &UserKiosk) : address {
        arg0.owner
    }

    public fun has_item(arg0: &UserKiosk, arg1: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<KioskItem>(&arg0.items)) {
            if (0x1::vector::borrow<KioskItem>(&arg0.items, v0).id == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun id_to_numeric(arg0: &0x2::object::ID) : u64 {
        let v0 = 0x2::object::id_to_bytes(arg0);
        (*0x1::vector::borrow<u8>(&v0, 0) as u64) | (*0x1::vector::borrow<u8>(&v0, 1) as u64) << 8 | (*0x1::vector::borrow<u8>(&v0, 2) as u64) << 16 | (*0x1::vector::borrow<u8>(&v0, 3) as u64) << 24 | (*0x1::vector::borrow<u8>(&v0, 4) as u64) << 32 | (*0x1::vector::borrow<u8>(&v0, 5) as u64) << 40 | (*0x1::vector::borrow<u8>(&v0, 6) as u64) << 48 | (*0x1::vector::borrow<u8>(&v0, 7) as u64) << 56
    }

    fun init(arg0: KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = KioskRegistry{
            id                 : 0x2::object::new(arg1),
            kiosks             : 0x1::vector::empty<0x2::object::ID>(),
            owners             : 0x1::vector::empty<address>(),
            fee_balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            kiosk_sponsor_fees : 0x2::balance::zero<0x2::sui::SUI>(),
            kiosk_creation_fee : 10000000000,
            owner              : v0,
        };
        0x2::transfer::share_object<KioskRegistry>(v1);
        let v2 = 0x2::package::claim<KIOSK>(arg0, arg1);
        let v3 = 0x2::display::new<KioskNFT>(&v2, arg1);
        0x2::display::add<KioskNFT>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<KioskNFT>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<KioskNFT>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<KioskNFT>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suimail.xyz"));
        0x2::display::add<KioskNFT>(&mut v3, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Kiosk Creator"));
        0x2::display::add<KioskNFT>(&mut v3, 0x1::string::utf8(b"price"), 0x1::string::utf8(b"{price}"));
        0x2::display::add<KioskNFT>(&mut v3, 0x1::string::utf8(b"timestamp"), 0x1::string::utf8(b"{timestamp}"));
        0x2::display::update_version<KioskNFT>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, v0);
        0x2::transfer::public_transfer<0x2::display::Display<KioskNFT>>(v3, v0);
    }

    public entry fun init_kiosk(arg0: &mut KioskRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!user_has_kiosk(arg0, v0), 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.kiosk_creation_fee, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = UserKiosk{
            id      : 0x2::object::new(arg2),
            owner   : v0,
            items   : 0x1::vector::empty<KioskItem>(),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.kiosks, 0x2::object::id<UserKiosk>(&v1));
        0x1::vector::push_back<address>(&mut arg0.owners, v0);
        0x2::transfer::public_share_object<UserKiosk>(v1);
    }

    public fun is_owner(arg0: &UserKiosk, arg1: address) : bool {
        arg1 == arg0.owner
    }

    public entry fun publish_item(arg0: &mut UserKiosk, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0, 0x2::tx_context::sender(arg5)), 3);
        assert!(0x1::vector::length<KioskItem>(&arg0.items) < 8, 4);
        let v0 = KioskItem{
            id          : (0x1::vector::length<KioskItem>(&arg0.items) as u64) + 1,
            title       : arg1,
            content_cid : arg2,
            price       : arg3,
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x1::vector::push_back<KioskItem>(&mut arg0.items, v0);
    }

    fun to_string(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        if (arg0 == 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"0"));
            return v0
        };
        while (arg0 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(0x1::vector::singleton<u8>(((arg0 % 10 + 48) as u8))));
            arg0 = arg0 / 10;
        };
        let v1 = 0x1::string::utf8(b"");
        let v2 = 0x1::string::length(&v0);
        let v3 = 0;
        while (v3 < v2) {
            0x1::string::append(&mut v1, 0x1::string::sub_string(&v0, v2 - v3 - 1, v2 - v3));
            v3 = v3 + 1;
        };
        v1
    }

    fun user_has_kiosk(arg0: &KioskRegistry, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.owners)) {
            if (*0x1::vector::borrow<address>(&arg0.owners, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun verify_kiosk_ownership(arg0: &KioskRegistry, arg1: 0x2::object::ID, arg2: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.kiosks)) {
            if (0x1::vector::borrow<0x2::object::ID>(&arg0.kiosks, v0) == &arg1) {
                return *0x1::vector::borrow<address>(&arg0.owners, v0) == arg2
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun withdraw_funds(arg0: &mut UserKiosk, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(is_owner(arg0, v0), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg1), v0);
    }

    public entry fun withdraw_registry_fees(arg0: &mut KioskRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance);
        assert!(v1 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_balance, v1, arg1), v0);
    }

    // decompiled from Move bytecode v6
}

