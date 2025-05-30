module 0x2a06138306a0ade73a3960e233a503394bd2fe42ed642aacde7b6fc429f1daff::fuddies_gang_nft {
    struct FuddiesGangster has store, key {
        id: 0x2::object::UID,
        number: u64,
        metadata: Metadata,
    }

    struct Metadata has copy, drop, store {
        image_url: 0x1::string::String,
        rarity: 0x1::string::String,
    }

    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        total_supply: u64,
        whitelist_mintable: 0x2::table::Table<address, u64>,
        whitelist_mint_price: u64,
        community_mint_price: u64,
        start_public_mint_time: u64,
        end_public_mint_time: u64,
        nft_metadata: vector<Metadata>,
    }

    struct WhitelistMintFee<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct CommunityMintForce<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct FUDDIES_GANG_NFT has drop {
        dummy_field: bool,
    }

    public fun add_nft_metadata(arg0: &mut Config, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg3) != arg0.admin) {
            return
        };
        let v0 = Metadata{
            image_url : arg1,
            rarity    : arg2,
        };
        0x1::vector::push_back<Metadata>(&mut arg0.nft_metadata, v0);
    }

    public fun add_to_whitelist(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.admin) {
            return
        };
        if (0x2::table::contains<address, u64>(&arg0.whitelist_mintable, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist_mintable, arg1);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.whitelist_mintable, arg1, 1);
        };
    }

    public fun burn<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
    }

    entry fun community_mint<T0>(arg0: &mut Config, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut CommunityMintForce<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.start_public_mint_time <= v0 && v0 <= arg0.end_public_mint_time;
        if (!v1) {
            abort 0
        };
        community_pay<T0>(arg0, arg3, arg4, arg5);
        let v2 = 0x2::random::new_generator(arg1, arg5);
        let v3 = 0x1::vector::swap_remove<Metadata>(&mut arg0.nft_metadata, 0x2::random::generate_u64(&mut v2) % 0x1::vector::length<Metadata>(&arg0.nft_metadata));
        let v4 = 0x2::tx_context::sender(arg5);
        mint_internal(arg0, v4, v3, arg5);
    }

    fun community_pay<T0>(arg0: &Config, arg1: &mut CommunityMintForce<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.community_mint_price > 0x2::coin::value<T0>(&arg2)) {
            abort 1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, arg0.community_mint_price, arg3), @0x0);
    }

    fun init(arg0: FUDDIES_GANG_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                     : 0x2::object::new(arg1),
            admin                  : 0x2::tx_context::sender(arg1),
            total_supply           : 0,
            whitelist_mintable     : 0x2::table::new<address, u64>(arg1),
            whitelist_mint_price   : 0,
            community_mint_price   : 0,
            start_public_mint_time : 0,
            end_public_mint_time   : 0,
            nft_metadata           : 0x1::vector::empty<Metadata>(),
        };
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Fuddies Gangster #{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{metadata.image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"AI NFT Collection & Meme coin on $SUI"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://fuddies-gang.fun/"));
        let v5 = 0x2::package::claim<FUDDIES_GANG_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<FuddiesGangster>(&v5, v1, v3, arg1);
        0x2::display::update_version<FuddiesGangster>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<FuddiesGangster>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Config>(v0);
    }

    fun mint_internal(arg0: &mut Config, arg1: address, arg2: Metadata, arg3: &mut 0x2::tx_context::TxContext) {
        let Metadata {
            image_url : v0,
            rarity    : v1,
        } = arg2;
        let v2 = Metadata{
            image_url : v0,
            rarity    : v1,
        };
        let v3 = FuddiesGangster{
            id       : 0x2::object::new(arg3),
            number   : arg0.total_supply,
            metadata : v2,
        };
        arg0.total_supply = arg0.total_supply + 1;
        0x2::transfer::public_transfer<FuddiesGangster>(v3, arg1);
    }

    public fun open_public_mint<T0>(arg0: &mut Config, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg4) != arg0.admin) {
            return
        };
        if (arg1 >= arg2) {
            abort 0
        };
        arg0.start_public_mint_time = arg1;
        arg0.end_public_mint_time = arg2;
        arg0.community_mint_price = arg3;
        let v0 = CommunityMintForce<T0>{id: 0x2::object::new(arg4)};
        0x2::transfer::public_transfer<CommunityMintForce<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun open_whitelist_mint<T0>(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.admin) {
            return
        };
        arg0.whitelist_mint_price = arg1;
        let v0 = WhitelistMintFee<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<WhitelistMintFee<T0>>(v0);
    }

    public fun remove_from_whitelist(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.admin) {
            return
        };
        0x2::table::remove<address, u64>(&mut arg0.whitelist_mintable, arg1);
    }

    public fun remove_nft_metadata(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.admin) {
            return
        };
        0x1::vector::swap_remove<Metadata>(&mut arg0.nft_metadata, arg1);
    }

    public fun renounce(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg1) != arg0.admin) {
            return
        };
        arg0.admin = @0x0;
    }

    fun update_whitelist_mint(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, u64>(&arg0.whitelist_mintable, 0x2::tx_context::sender(arg1)), 2);
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist_mintable, 0x2::tx_context::sender(arg1));
        let v1 = 0;
        if (v0 == &v1) {
            abort 2
        };
        *v0 = *v0 - 1;
    }

    public fun whitelist_mint<T0>(arg0: &mut Config, arg1: &mut WhitelistMintFee<T0>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        update_whitelist_mint(arg0, arg4);
        whitelist_pay<T0>(arg0, arg1, arg3, arg4);
        let v0 = 0x1::vector::swap_remove<Metadata>(&mut arg0.nft_metadata, arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        mint_internal(arg0, v1, v0, arg4);
    }

    fun whitelist_pay<T0>(arg0: &Config, arg1: &mut WhitelistMintFee<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.whitelist_mint_price > 0x2::coin::value<T0>(&arg2)) {
            abort 1
        };
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg0.whitelist_mint_price, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

