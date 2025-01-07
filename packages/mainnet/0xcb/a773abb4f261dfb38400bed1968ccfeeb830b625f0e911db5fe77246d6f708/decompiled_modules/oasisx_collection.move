module 0xcba773abb4f261dfb38400bed1968ccfeeb830b625f0e911db5fe77246d6f708::oasisx_collection {
    struct OASISX_COLLECTION has drop {
        dummy_field: bool,
    }

    struct OasisXNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct OasisXMetadata has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        max_supply: u64,
        max_mint_per_user: u64,
        stake_holders: vector<address>,
        stake_percentages: vector<u64>,
    }

    struct SetupCap has key {
        id: 0x2::object::UID,
    }

    struct OasisXNFTTreasury has store, key {
        id: 0x2::object::UID,
        total_supply: u64,
        protocol_fee: u64,
        protocol_address: address,
        mint_price: u64,
        user_minted: 0x2::vec_map::VecMap<address, u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Transfer has copy, drop {
        from: address,
        to: address,
        id: 0x2::object::ID,
    }

    public entry fun admin_mint(arg0: &AdminCap, arg1: &mut OasisXNFTTreasury, arg2: &OasisXMetadata, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        arg1.total_supply = arg1.total_supply + 1;
        assert!(arg1.total_supply <= arg2.max_supply, 21);
        assert!(arg8 != @0x0, 11);
        generate_nft(arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun admin_mint_many(arg0: &AdminCap, arg1: &mut OasisXNFTTreasury, arg2: &OasisXMetadata, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<vector<0x1::string::String>>, arg7: vector<vector<0x1::string::String>>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg3);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == v0, 10);
        assert!(0x1::vector::length<0x1::string::String>(&arg5) == v0, 10);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg6) == v0, 10);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg7) == v0, 10);
        assert!(arg8 != @0x0, 11);
        assert!(arg1.total_supply + v0 <= arg2.max_supply, 21);
        arg1.total_supply = arg1.total_supply + v0;
        0x1::vector::reverse<0x1::string::String>(&mut arg3);
        0x1::vector::reverse<0x1::string::String>(&mut arg4);
        0x1::vector::reverse<0x1::string::String>(&mut arg5);
        0x1::vector::reverse<vector<0x1::string::String>>(&mut arg6);
        0x1::vector::reverse<vector<0x1::string::String>>(&mut arg7);
        while (0x1::vector::length<0x1::string::String>(&arg3) != 0) {
            generate_nft(0x1::vector::pop_back<0x1::string::String>(&mut arg3), 0x1::vector::pop_back<0x1::string::String>(&mut arg4), 0x1::vector::pop_back<0x1::string::String>(&mut arg5), 0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg6), 0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg7), arg8, arg9);
        };
    }

    public fun attributes(arg0: &OasisXNFT) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun create(arg0: SetupCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<address>, arg8: vector<u64>, arg9: &0x2::package::Publisher, arg10: u64, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg7) == 0x1::vector::length<u64>(&arg8), 10);
        let v0 = 0;
        while (0x1::vector::length<u64>(&arg8) != 0) {
            v0 = v0 + 0x1::vector::pop_back<u64>(&mut arg8);
        };
        assert!(v0 == 10000, 10);
        let v1 = OasisXMetadata{
            id                : 0x2::object::new(arg12),
            name              : arg1,
            symbol            : arg2,
            max_supply        : arg6,
            max_mint_per_user : arg4,
            stake_holders     : arg7,
            stake_percentages : arg8,
        };
        0x2::transfer::freeze_object<OasisXMetadata>(v1);
        let v2 = OasisXNFTTreasury{
            id               : 0x2::object::new(arg12),
            total_supply     : 0,
            protocol_fee     : arg10,
            protocol_address : arg11,
            mint_price       : arg5,
            user_minted      : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<OasisXNFTTreasury>(v2);
        let SetupCap { id: v3 } = arg0;
        let (v4, v5) = 0x2::transfer_policy::new<OasisXNFT>(arg9, arg12);
        let v6 = v5;
        let v7 = v4;
        0x81542f65941bc188d8b6ddb3eb3ecc78812013fff9f2350322b474578276f78::royalty::add<OasisXNFT>(&mut v7, &v6, arg3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<OasisXNFT>>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<OasisXNFT>>(v6, 0x2::tx_context::sender(arg12));
        0x2::object::delete(v3);
    }

    public fun description(arg0: &OasisXNFT) : 0x1::string::String {
        arg0.description
    }

    fun generate_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == 0x1::vector::length<0x1::string::String>(&arg4), 10);
        let v0 = 0x2::object::new(arg6);
        let v1 = Transfer{
            from : @0x0,
            to   : arg5,
            id   : 0x2::object::uid_to_inner(&v0),
        };
        0x2::event::emit<Transfer>(v1);
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x1::vector::reverse<0x1::string::String>(&mut arg3);
        0x1::vector::reverse<0x1::string::String>(&mut arg4);
        while (0x1::vector::length<0x1::string::String>(&arg3) > 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::vector::pop_back<0x1::string::String>(&mut arg3), 0x1::vector::pop_back<0x1::string::String>(&mut arg4));
        };
        let v3 = OasisXNFT{
            id          : v0,
            name        : arg0,
            image_url   : arg1,
            description : arg2,
            attributes  : v2,
        };
        0x2::transfer::transfer<OasisXNFT>(v3, arg5);
    }

    public fun image_url(arg0: &OasisXNFT) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: OASISX_COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = 0x2::package::claim<OASISX_COLLECTION>(arg0, arg1);
        let v2 = 0x2::display::new<OasisXNFT>(&v1, arg1);
        0x2::display::add<OasisXNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<OasisXNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<OasisXNFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<OasisXNFT>(&mut v2, 0x1::string::utf8(b"icon_url"), 0x1::string::utf8(b"{icon_url}"));
        0x2::display::add<OasisXNFT>(&mut v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"{metadata}"));
        0x2::display::update_version<OasisXNFT>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<OasisXNFT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v3 = SetupCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SetupCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut OasisXNFTTreasury, arg1: &OasisXMetadata, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        if (!0x2::vec_map::contains<address, u64>(&arg0.user_minted, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.user_minted, v0, 0);
        };
        let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.user_minted, &v0);
        assert!(*v1 < arg1.max_mint_per_user, 20);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= arg0.mint_price, 22);
        let v2 = &mut arg7;
        pay_protocol(arg0.protocol_fee, arg0.protocol_address, v2, arg8);
        pay_stake_holders(arg1.stake_holders, arg1.stake_percentages, arg7, arg8);
        arg0.total_supply = arg0.total_supply + 1;
        *v1 = *v1 + 1;
        generate_nft(arg2, arg3, arg4, arg5, arg6, v0, arg8);
    }

    public entry fun mint_many(arg0: &mut OasisXNFTTreasury, arg1: &OasisXMetadata, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<vector<0x1::string::String>>, arg6: vector<vector<0x1::string::String>>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == v1, 10);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == v1, 10);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg5) == v1, 10);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg6) == v1, 10);
        if (!0x2::vec_map::contains<address, u64>(&arg0.user_minted, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.user_minted, v0, 0);
        };
        let v2 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.user_minted, &v0);
        assert!(*v2 + v1 <= arg1.max_mint_per_user, 20);
        assert!(arg0.mint_price * v1 == 0x2::coin::value<0x2::sui::SUI>(&arg7), 22);
        let v3 = &mut arg7;
        pay_protocol(arg0.protocol_fee, arg0.protocol_address, v3, arg8);
        pay_stake_holders(arg1.stake_holders, arg1.stake_percentages, arg7, arg8);
        *v2 = *v2 + v1;
        arg0.total_supply = arg0.total_supply + v1;
        0x1::vector::reverse<0x1::string::String>(&mut arg2);
        0x1::vector::reverse<0x1::string::String>(&mut arg3);
        0x1::vector::reverse<0x1::string::String>(&mut arg4);
        0x1::vector::reverse<vector<0x1::string::String>>(&mut arg5);
        0x1::vector::reverse<vector<0x1::string::String>>(&mut arg6);
        while (0x1::vector::length<0x1::string::String>(&arg2) != 0) {
            generate_nft(0x1::vector::pop_back<0x1::string::String>(&mut arg2), 0x1::vector::pop_back<0x1::string::String>(&mut arg3), 0x1::vector::pop_back<0x1::string::String>(&mut arg4), 0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg5), 0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg6), v0, arg8);
        };
    }

    public fun name(arg0: &OasisXNFT) : 0x1::string::String {
        arg0.name
    }

    fun pay_protocol(arg0: u64, arg1: address, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::pay::split_and_transfer<0x2::sui::SUI>(arg2, arg0 * 0x2::coin::value<0x2::sui::SUI>(arg2) / 10000, arg1, arg3);
    }

    fun pay_stake_holders(arg0: vector<address>, arg1: vector<u64>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg0)) {
            0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg2, 0x2::coin::value<0x2::sui::SUI>(&arg2) * 0x1::vector::pop_back<u64>(&mut arg1) / 10000, 0x1::vector::pop_back<address>(&mut arg0), arg3);
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
    }

    public fun total_supply(arg0: &OasisXNFTTreasury) : u64 {
        arg0.total_supply
    }

    public fun user_minted(arg0: &OasisXNFTTreasury, arg1: address) : u64 {
        *0x2::vec_map::get<address, u64>(&arg0.user_minted, &arg1)
    }

    // decompiled from Move bytecode v6
}

