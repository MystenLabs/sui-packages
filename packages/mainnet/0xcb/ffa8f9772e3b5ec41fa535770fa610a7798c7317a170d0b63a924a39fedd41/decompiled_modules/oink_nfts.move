module 0xcbffa8f9772e3b5ec41fa535770fa610a7798c7317a170d0b63a924a39fedd41::oink_nfts {
    struct OinkNFT has store, key {
        id: 0x2::object::UID,
        number: u64,
        metadata: OinkNFTMetadata,
    }

    struct OinkNFTMetadata has copy, drop, store {
        image_url: 0x1::string::String,
        rarity: 0x1::string::String,
        background_color: 0x1::string::String,
    }

    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        mint_price: u64,
        max_mint_per_address: u64,
        total_supply: u64,
        whitelist_mint: bool,
        whitelist: vector<address>,
        start_public_mint_time: u64,
        end_public_mint_time: u64,
        nft_metadata: vector<OinkNFTMetadata>,
        minted: 0x2::table::Table<address, u64>,
    }

    struct Fee<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct OINK_NFTS has drop {
        dummy_field: bool,
    }

    public fun add_nft_metadata(arg0: &mut Config, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg4) != arg0.admin) {
            return
        };
        let v0 = OinkNFTMetadata{
            image_url        : arg1,
            rarity           : arg2,
            background_color : arg3,
        };
        0x1::vector::push_back<OinkNFTMetadata>(&mut arg0.nft_metadata, v0);
    }

    public fun add_to_whitelist(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.admin) {
            return
        };
        0x1::vector::push_back<address>(&mut arg0.whitelist, arg1);
    }

    public fun close_whitelist_mint(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg1) != arg0.admin) {
            return
        };
        arg0.whitelist_mint = false;
    }

    public fun get_whitelist_index(arg0: &Config, arg1: address) : u64 {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelist, &arg1);
        if (!v0) {
            abort 2
        };
        v1
    }

    fun init(arg0: OINK_NFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                     : 0x2::object::new(arg1),
            admin                  : 0x2::tx_context::sender(arg1),
            mint_price             : 0,
            max_mint_per_address   : 0,
            total_supply           : 0,
            whitelist_mint         : false,
            whitelist              : 0x1::vector::empty<address>(),
            start_public_mint_time : 0,
            end_public_mint_time   : 0,
            nft_metadata           : 0x1::vector::empty<OinkNFTMetadata>(),
            minted                 : 0x2::table::new<address, u64>(arg1),
        };
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Sui Oink #{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{metadata.image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(x"f09f90bdf09fa4bf20546865206d6f737420616476656e7475726f75732070696720696e20535549204f6365616ef09f92a7"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.suioink.fun/"));
        let v5 = 0x2::package::claim<OINK_NFTS>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<OinkNFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<OinkNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<OinkNFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Config>(v0);
    }

    public fun init_collection<T0>(arg0: &Config, arg1: &mut 0x2::tx_context::TxContext) {
        if (arg0.admin != 0x2::tx_context::sender(arg1)) {
            return
        };
        let v0 = Fee<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Fee<T0>>(v0);
    }

    entry fun mint<T0>(arg0: &mut Config, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut Fee<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.start_public_mint_time <= v0 && v0 <= arg0.end_public_mint_time;
        if (!v1 && !arg0.whitelist_mint) {
            abort 0
        };
        if (!v1) {
            get_whitelist_index(arg0, 0x2::tx_context::sender(arg5));
        };
        let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.minted, 0x2::tx_context::sender(arg5));
        if (*v2 >= arg0.max_mint_per_address) {
            abort 3
        };
        *v2 = *v2 + 1;
        pay_before_mint<T0>(arg0, arg3, arg4, arg5);
        let v3 = 0x2::random::new_generator(arg1, arg5);
        let v4 = 0x1::vector::swap_remove<OinkNFTMetadata>(&mut arg0.nft_metadata, 0x2::random::generate_u64(&mut v3) % 0x1::vector::length<OinkNFTMetadata>(&arg0.nft_metadata));
        let v5 = 0x2::tx_context::sender(arg5);
        mint_internal(arg0, v5, v4, arg5);
    }

    entry fun mint_batch<T0>(arg0: &mut Config, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut Fee<T0>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg5) {
            let v1 = 0x2::clock::timestamp_ms(arg2);
            let v2 = arg0.start_public_mint_time <= v1 && v1 <= arg0.end_public_mint_time;
            if (!v2 && !arg0.whitelist_mint) {
                abort 0
            };
            if (!v2) {
                get_whitelist_index(arg0, 0x2::tx_context::sender(arg6));
            };
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.minted, 0x2::tx_context::sender(arg6));
            if (*v3 >= arg0.max_mint_per_address) {
                abort 3
            };
            *v3 = *v3 + 1;
            if (arg0.mint_price > 0x2::coin::value<T0>(&arg4)) {
                abort 1
            };
            0x2::balance::join<T0>(&mut arg3.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, arg0.mint_price, arg6)));
            let v4 = 0x2::random::new_generator(arg1, arg6);
            let v5 = 0x1::vector::swap_remove<OinkNFTMetadata>(&mut arg0.nft_metadata, 0x2::random::generate_u64(&mut v4) % 0x1::vector::length<OinkNFTMetadata>(&arg0.nft_metadata));
            let v6 = 0x2::tx_context::sender(arg6);
            mint_internal(arg0, v6, v5, arg6);
            v0 = v0 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x2::tx_context::sender(arg6));
    }

    fun mint_internal(arg0: &mut Config, arg1: address, arg2: OinkNFTMetadata, arg3: &mut 0x2::tx_context::TxContext) {
        let OinkNFTMetadata {
            image_url        : v0,
            rarity           : v1,
            background_color : v2,
        } = arg2;
        let v3 = OinkNFTMetadata{
            image_url        : v0,
            rarity           : v1,
            background_color : v2,
        };
        let v4 = OinkNFT{
            id       : 0x2::object::new(arg3),
            number   : arg0.total_supply,
            metadata : v3,
        };
        arg0.total_supply = arg0.total_supply + 1;
        0x2::transfer::public_transfer<OinkNFT>(v4, arg1);
    }

    public fun open_public_mint(arg0: &mut Config, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg3) != arg0.admin) {
            return
        };
        if (arg1 >= arg2) {
            abort 0
        };
        arg0.start_public_mint_time = arg1;
        arg0.end_public_mint_time = arg2;
    }

    public fun open_whitelist_mint(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg1) != arg0.admin) {
            return
        };
        arg0.whitelist_mint = true;
    }

    fun pay_before_mint<T0>(arg0: &Config, arg1: &mut Fee<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.mint_price > 0x2::coin::value<T0>(&arg2)) {
            abort 1
        };
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg0.mint_price, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg3));
    }

    public fun remove_from_whitelist(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.admin) {
            return
        };
        0x1::vector::swap_remove<address>(&mut arg0.whitelist, arg1);
    }

    public fun remove_nft_metadata(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.admin) {
            return
        };
        0x1::vector::swap_remove<OinkNFTMetadata>(&mut arg0.nft_metadata, arg1);
    }

    public fun renounce(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg1) != arg0.admin) {
            return
        };
        arg0.admin = @0x0;
    }

    public fun update_max_mint_per_address(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.admin) {
            return
        };
        arg0.max_mint_per_address = arg1;
    }

    public fun update_mint_price(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.admin) {
            return
        };
        arg0.mint_price = arg1;
    }

    // decompiled from Move bytecode v6
}

