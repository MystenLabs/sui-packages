module 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::cannabeach_collection {
    struct Cannabeach has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x2::url::Url,
        link: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct NFTTransfer has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        receiver: address,
    }

    struct NFTBurn has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
    }

    struct PoolMint has copy, drop, store {
        sum_nft: u64,
        price_mint: u64,
        timestamp_start: u64,
        timestamp_end: u64,
        user_mint_max: u64,
    }

    struct AddressMintedPool has copy, drop, store {
        pool_whitelist: u64,
        pool_public: u64,
    }

    struct InfoCollection has store, key {
        id: 0x2::object::UID,
        name_nft: 0x1::string::String,
        description_nft: 0x1::string::String,
        ourl: 0x1::string::String,
        metadata: 0x1::string::String,
        sum_nft: u64,
        option_mint_whitelist: PoolMint,
        option_mint_public: PoolMint,
        sui_deposit: 0x2::balance::Balance<0x2::sui::SUI>,
        hard_cap: u64,
        white_list_address: 0x2::table::Table<address, bool>,
        version: u64,
    }

    struct CANNABEACH_COLLECTION has drop {
        dummy_field: bool,
    }

    public entry fun claim(arg0: &mut InfoCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::witness::check_owner(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_deposit, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun Insert_white_list(arg0: &mut InfoCollection, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::witness::check_owner(arg2), 1);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0x2::table::add<address, bool>(&mut arg0.white_list_address, 0x1::vector::pop_back<address>(&mut arg1), true);
        };
    }

    fun checkOwnerSign(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::tx_context::sender(arg1)));
        let v1 = 0x1::string::utf8(arg0);
        0x1::string::sub_string(&v1, 0, 66) == v0 && 0x1::string::sub_string(&v1, 67, 0x1::string::length(&v1)) == 0x1::string::utf8(0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_project())
    }

    fun img_url(arg0: vector<u8>, arg1: u64, arg2: vector<u8>) : 0x2::url::Url {
        0x1::vector::append<u8>(&mut arg0, numberToStr(arg1));
        0x1::vector::append<u8>(&mut arg0, arg2);
        0x2::url::new_unsafe_from_bytes(arg0)
    }

    fun init(arg0: CANNABEACH_COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        init_infocollection(arg1);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_description_nft()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_website()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://tocen.co/"));
        let v4 = 0x2::package::claim<CANNABEACH_COLLECTION>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Cannabeach>(&v4, v0, v2, arg1);
        0x2::display::update_version<Cannabeach>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Cannabeach>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun init_infocollection(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolMint{
            sum_nft         : 0,
            price_mint      : 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_price_mint_private(),
            timestamp_start : 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_time_start_private(),
            timestamp_end   : 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_time_end_private(),
            user_mint_max   : 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_user_mint_max_private(),
        };
        let v1 = PoolMint{
            sum_nft         : 0,
            price_mint      : 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_price_mint_public(),
            timestamp_start : 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_time_start_public(),
            timestamp_end   : 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_time_end_public(),
            user_mint_max   : 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_user_mint_max_public(),
        };
        let v2 = InfoCollection{
            id                    : 0x2::object::new(arg0),
            name_nft              : 0x1::string::utf8(0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_name_nft()),
            description_nft       : 0x1::string::utf8(0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_description_nft()),
            ourl                  : 0x1::string::utf8(0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_image_url()),
            metadata              : 0x1::string::utf8(0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_metadata_url()),
            sum_nft               : 0,
            option_mint_whitelist : v0,
            option_mint_public    : v1,
            sui_deposit           : 0x2::balance::zero<0x2::sui::SUI>(),
            hard_cap              : 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_hard_cap(),
            white_list_address    : 0x2::table::new<address, bool>(arg0),
            version               : 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_version(),
        };
        0x2::transfer::share_object<InfoCollection>(v2);
    }

    fun mint(arg0: &mut InfoCollection, arg1: &mut 0x2::tx_context::TxContext) : Cannabeach {
        let v0 = arg0.name_nft;
        arg0.sum_nft = arg0.sum_nft + 1;
        0x1::string::append_utf8(&mut v0, numberToStr(arg0.sum_nft));
        Cannabeach{
            id      : 0x2::object::new(arg1),
            name    : v0,
            img_url : img_url(*0x1::string::bytes(&arg0.ourl), arg0.sum_nft, 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_type_image()),
            link    : img_url(*0x1::string::bytes(&arg0.metadata), arg0.sum_nft, 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_type_metadata()),
        }
    }

    public entry fun mint_nft_with_public(arg0: &mut InfoCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_key();
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v0, &arg3), 12);
        assert!(arg0.sum_nft < arg0.hard_cap, 5);
        assert!(checkOwnerSign(arg3, arg5), 12);
        assert!(arg0.option_mint_public.timestamp_start <= 0x2::clock::timestamp_ms(arg4), 11);
        assert!(arg0.option_mint_public.timestamp_end >= 0x2::clock::timestamp_ms(arg4), 2);
        if (0x2::dynamic_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg5))) {
            let v1 = &mut 0x2::dynamic_field::borrow_mut<address, AddressMintedPool>(&mut arg0.id, 0x2::tx_context::sender(arg5)).pool_public;
            assert!(*v1 < arg0.option_mint_public.user_mint_max, 7);
            *v1 = *v1 + 1;
        } else {
            let v2 = AddressMintedPool{
                pool_whitelist : 0,
                pool_public    : 1,
            };
            0x2::dynamic_field::add<address, AddressMintedPool>(&mut arg0.id, 0x2::tx_context::sender(arg5), v2);
        };
        arg0.option_mint_public.sum_nft = arg0.option_mint_public.sum_nft + 1;
        let v3 = &mut arg0.sui_deposit;
        transferSui(v3, arg1, arg0.option_mint_public.price_mint, arg5);
        let v4 = mint(arg0, arg5);
        let v5 = NFTMinted{
            object_id : 0x2::object::id<Cannabeach>(&v4),
            creator   : 0x2::tx_context::sender(arg5),
            name      : v4.name,
            image_url : v4.img_url,
        };
        0x2::event::emit<NFTMinted>(v5);
        0x2::transfer::public_transfer<Cannabeach>(v4, 0x2::tx_context::sender(arg5));
    }

    public entry fun mint_nft_with_whitelist(arg0: &mut InfoCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::utils::get_key();
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v0, &arg3), 12);
        assert!(arg0.sum_nft < arg0.hard_cap, 5);
        assert!(arg0.sum_nft < 210, 5);
        assert!(checkOwnerSign(arg3, arg5), 12);
        assert!(0x2::table::contains<address, bool>(&arg0.white_list_address, 0x2::tx_context::sender(arg5)), 10);
        assert!(arg0.option_mint_whitelist.timestamp_start <= 0x2::clock::timestamp_ms(arg4), 11);
        assert!(arg0.option_mint_whitelist.timestamp_end >= 0x2::clock::timestamp_ms(arg4), 2);
        if (0x2::dynamic_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg5))) {
            let v1 = &mut 0x2::dynamic_field::borrow_mut<address, AddressMintedPool>(&mut arg0.id, 0x2::tx_context::sender(arg5)).pool_whitelist;
            assert!(*v1 < arg0.option_mint_whitelist.user_mint_max, 7);
            *v1 = *v1 + 1;
        } else {
            let v2 = AddressMintedPool{
                pool_whitelist : 1,
                pool_public    : 0,
            };
            0x2::dynamic_field::add<address, AddressMintedPool>(&mut arg0.id, 0x2::tx_context::sender(arg5), v2);
        };
        arg0.option_mint_whitelist.sum_nft = arg0.option_mint_whitelist.sum_nft + 1;
        let v3 = &mut arg0.sui_deposit;
        transferSui(v3, arg1, arg0.option_mint_whitelist.price_mint, arg5);
        let v4 = mint(arg0, arg5);
        let v5 = NFTMinted{
            object_id : 0x2::object::id<Cannabeach>(&v4),
            creator   : 0x2::tx_context::sender(arg5),
            name      : v4.name,
            image_url : v4.img_url,
        };
        0x2::event::emit<NFTMinted>(v5);
        0x2::transfer::public_transfer<Cannabeach>(v4, 0x2::tx_context::sender(arg5));
    }

    public fun numberToStr(arg0: u64) : vector<u8> {
        let v0 = b"";
        while (arg0 % 10 >= 0 && arg0 > 0) {
            let v1 = b"0123456789";
            0x1::vector::insert<u8>(&mut v0, *0x1::vector::borrow<u8>(&v1, arg0 % 10), 0);
            arg0 = arg0 / 10;
        };
        v0
    }

    public entry fun remote_white_list(arg0: &mut InfoCollection, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::witness::check_owner(arg2), 1);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.white_list_address, 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    fun transferSui(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 1);
        0x2::balance::join<0x2::sui::SUI>(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun update_time_private(arg0: &mut InfoCollection, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::witness::check_owner(arg3), 1);
        if (arg1 == 1) {
            arg0.option_mint_whitelist.timestamp_start = arg2;
        } else if (arg1 == 2) {
            arg0.option_mint_whitelist.timestamp_end = arg2;
        };
    }

    public entry fun update_time_public(arg0: &mut InfoCollection, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x974b94830b1955c8504a6618f275298a04a0568d2463cbfead1a39407a2eea6f::witness::check_owner(arg3), 1);
        if (arg1 == 1) {
            arg0.option_mint_public.timestamp_start = arg2;
        } else if (arg1 == 2) {
            arg0.option_mint_public.timestamp_end = arg2;
        };
    }

    // decompiled from Move bytecode v6
}

