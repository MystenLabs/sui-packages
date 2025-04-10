module 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::karafuru_collection {
    struct Karafuru has store, key {
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
        supply: u64,
    }

    struct AddressMintedPool has copy, drop, store {
        pool_whitelist: u64,
        pool_holder: u64,
        pool_public: u64,
        pool_private: u64,
    }

    struct InfoCollection has store, key {
        id: 0x2::object::UID,
        name_nft: 0x1::string::String,
        description_nft: 0x1::string::String,
        ourl: 0x1::string::String,
        metadata: 0x1::string::String,
        sum_nft: u64,
        option_mint_whitelist: PoolMint,
        option_mint_holder: PoolMint,
        option_mint_public: PoolMint,
        option_mint_private: PoolMint,
        sui_deposit: 0x2::balance::Balance<0x2::sui::SUI>,
        supply: u64,
        version: u64,
    }

    struct KARAFURU_COLLECTION has drop {
        dummy_field: bool,
    }

    public entry fun burnNFT(arg0: &mut InfoCollection, arg1: Karafuru, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::witness::check_owner(arg2), 1);
        let v0 = NFTBurn{
            object_id : 0x2::object::id<Karafuru>(&arg1),
            owner     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NFTBurn>(v0);
        arg0.sum_nft = arg0.sum_nft - 1;
        let Karafuru {
            id      : v1,
            name    : _,
            img_url : _,
            link    : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    fun checkOwnerSign(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::tx_context::sender(arg1)));
        let v1 = 0x1::string::utf8(arg0);
        0x1::string::sub_string(&v1, 0, 66) == v0 && 0x1::string::sub_string(&v1, 67, 0x1::string::length(&v1)) == 0x1::string::utf8(0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_project())
    }

    fun img_url(arg0: vector<u8>, arg1: u64, arg2: vector<u8>) : 0x2::url::Url {
        0x1::vector::append<u8>(&mut arg0, numberToStr(arg1));
        0x1::vector::append<u8>(&mut arg0, arg2);
        0x2::url::new_unsafe_from_bytes(arg0)
    }

    fun img_url_name(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : 0x2::url::Url {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::vector::append<u8>(&mut arg0, arg2);
        0x2::url::new_unsafe_from_bytes(arg0)
    }

    fun init(arg0: KARAFURU_COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_description_nft()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_website()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://opensea.io/collection/karafuru"));
        let v4 = 0x2::package::claim<KARAFURU_COLLECTION>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Karafuru>(&v4, v0, v2, arg1);
        0x2::display::update_version<Karafuru>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Karafuru>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun init_infocollection(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolMint{
            sum_nft         : 0,
            price_mint      : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_price_mint_whitelist(),
            timestamp_start : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_time_start_whitelist(),
            timestamp_end   : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_time_end_whitelist(),
            user_mint_max   : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_user_mint_max_whitelist(),
            supply          : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_hard_cap_whitelist(),
        };
        let v1 = PoolMint{
            sum_nft         : 0,
            price_mint      : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_price_mint_holder(),
            timestamp_start : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_time_start_holder(),
            timestamp_end   : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_time_end_holder(),
            user_mint_max   : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_user_mint_max_holder(),
            supply          : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_hard_cap_holder(),
        };
        let v2 = PoolMint{
            sum_nft         : 0,
            price_mint      : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_price_mint_public(),
            timestamp_start : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_time_start_public(),
            timestamp_end   : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_time_end_public(),
            user_mint_max   : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_user_mint_max_public(),
            supply          : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_hard_cap_public(),
        };
        let v3 = PoolMint{
            sum_nft         : 0,
            price_mint      : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_price_mint_private(),
            timestamp_start : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_time_start_private(),
            timestamp_end   : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_time_end_private(),
            user_mint_max   : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_user_mint_max_private(),
            supply          : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_hard_cap_private(),
        };
        let v4 = InfoCollection{
            id                    : 0x2::object::new(arg0),
            name_nft              : 0x1::string::utf8(0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_name_nft()),
            description_nft       : 0x1::string::utf8(0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_description_nft()),
            ourl                  : 0x1::string::utf8(0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_image_url()),
            metadata              : 0x1::string::utf8(0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_metadata_url()),
            sum_nft               : 0,
            option_mint_whitelist : v0,
            option_mint_holder    : v1,
            option_mint_public    : v2,
            option_mint_private   : v3,
            sui_deposit           : 0x2::balance::zero<0x2::sui::SUI>(),
            supply                : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_hard_cap_total(),
            version               : 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_version(),
        };
        0x2::transfer::share_object<InfoCollection>(v4);
    }

    fun mint(arg0: &mut InfoCollection, arg1: &mut 0x2::tx_context::TxContext) : Karafuru {
        let v0 = arg0.name_nft;
        arg0.sum_nft = arg0.sum_nft + 1;
        0x1::string::append_utf8(&mut v0, numberToStr(arg0.sum_nft));
        Karafuru{
            id      : 0x2::object::new(arg1),
            name    : v0,
            img_url : img_url(*0x1::string::bytes(&arg0.ourl), arg0.sum_nft, 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_type_image()),
            link    : img_url(*0x1::string::bytes(&arg0.metadata), arg0.sum_nft, 0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::info::get_type_metadata()),
        }
    }

    public entry fun mint_nft_with_airdrop(arg0: &mut InfoCollection, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.sum_nft < arg0.supply, 5);
        assert!(0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::witness::check_owner(arg3), 1);
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = mint(arg0, arg3);
            let v2 = NFTMinted{
                object_id : 0x2::object::id<Karafuru>(&v1),
                creator   : arg2,
                name      : v1.name,
                image_url : v1.img_url,
            };
            0x2::event::emit<NFTMinted>(v2);
            0x2::transfer::public_transfer<Karafuru>(v1, arg2);
            v0 = v0 + 1;
        };
    }

    public entry fun mint_nft_with_public(arg0: &mut InfoCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.option_mint_public.sum_nft < arg0.option_mint_public.supply, 5);
        arg0.option_mint_public.sum_nft = arg0.option_mint_public.sum_nft + 1;
        let v0 = &mut arg0.sui_deposit;
        transferSui(v0, arg1, arg0.option_mint_public.price_mint, arg2);
        let v1 = mint(arg0, arg2);
        let v2 = NFTMinted{
            object_id : 0x2::object::id<Karafuru>(&v1),
            creator   : 0x2::tx_context::sender(arg2),
            name      : v1.name,
            image_url : v1.img_url,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<Karafuru>(v1, 0x2::tx_context::sender(arg2));
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

    public entry fun pool(arg0: &mut InfoCollection, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::witness::check_owner(arg3), 1);
        if (arg1 == 1) {
            arg0.option_mint_whitelist.supply = arg2;
        } else if (arg1 == 2) {
            arg0.option_mint_holder.supply = arg2;
        } else if (arg1 == 3) {
            arg0.option_mint_public.supply = arg2;
        } else if (arg1 == 4) {
            arg0.option_mint_private.supply = arg2;
        };
    }

    fun transferSui(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 1);
        0x2::balance::join<0x2::sui::SUI>(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun up_pr(arg0: &mut InfoCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::witness::check_owner(arg2), 1);
        arg0.option_mint_public.price_mint = arg1;
    }

    public entry fun update_time_public(arg0: &mut InfoCollection, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::witness::check_owner(arg3), 1);
        if (arg1 == 1) {
            arg0.option_mint_public.timestamp_start = arg2;
        } else if (arg1 == 2) {
            arg0.option_mint_public.timestamp_end = arg2;
        };
    }

    public entry fun with(arg0: &mut InfoCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xb853b70429f99e52c21608470cc4e30caf92920d4d5a92427da1523e2d10d0c4::witness::check_owner(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_deposit, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

