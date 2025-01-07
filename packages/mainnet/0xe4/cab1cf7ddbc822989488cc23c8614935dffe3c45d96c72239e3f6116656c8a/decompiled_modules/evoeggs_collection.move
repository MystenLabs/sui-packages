module 0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::evoeggs_collection {
    struct EvoEggs has store, key {
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

    struct InfoCollection has store, key {
        id: 0x2::object::UID,
        name_nft: 0x1::string::String,
        description_nft: 0x1::string::String,
        ourl: 0x1::string::String,
        metadata: 0x1::string::String,
        sum_nft: u64,
        option_mint_public: PoolMint,
        sui_deposit: 0x2::balance::Balance<0x2::sui::SUI>,
        hard_cap: u64,
    }

    struct EVOEGGS_COLLECTION has drop {
        dummy_field: bool,
    }

    public entry fun claim(arg0: &mut InfoCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::witness::check_owner(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_deposit, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun burnNFT(arg0: &mut InfoCollection, arg1: EvoEggs, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::witness::check_owner(arg2), 1);
        let v0 = NFTBurn{
            object_id : 0x2::object::id<EvoEggs>(&arg1),
            owner     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NFTBurn>(v0);
        arg0.sum_nft = arg0.sum_nft - 1;
        let EvoEggs {
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
        0x1::string::sub_string(&v1, 0, 66) == v0 && 0x1::string::sub_string(&v1, 67, 0x1::string::length(&v1)) == 0x1::string::utf8(0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::utils::get_project())
    }

    fun init(arg0: EVOEGGS_COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::utils::get_description_nft()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::utils::get_website()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://tocen.co/"));
        let v4 = 0x2::package::claim<EVOEGGS_COLLECTION>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<EvoEggs>(&v4, v0, v2, arg1);
        0x2::display::update_version<EvoEggs>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EvoEggs>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun init_infocollection(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolMint{
            sum_nft         : 0,
            price_mint      : 0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::utils::get_price_mint_public(),
            timestamp_start : 0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::utils::get_time_start_public(),
            timestamp_end   : 0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::utils::get_time_end_public(),
            user_mint_max   : 0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::utils::get_user_mint_max_public(),
        };
        let v1 = InfoCollection{
            id                 : 0x2::object::new(arg0),
            name_nft           : 0x1::string::utf8(0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::utils::get_name_nft()),
            description_nft    : 0x1::string::utf8(0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::utils::get_description_nft()),
            ourl               : 0x1::string::utf8(0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::utils::get_image_url()),
            metadata           : 0x1::string::utf8(0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::utils::get_metadata_url()),
            sum_nft            : 0,
            option_mint_public : v0,
            sui_deposit        : 0x2::balance::zero<0x2::sui::SUI>(),
            hard_cap           : 0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::utils::get_hard_cap(),
        };
        0x2::transfer::share_object<InfoCollection>(v1);
    }

    fun mint(arg0: &mut InfoCollection, arg1: &mut 0x2::tx_context::TxContext) : EvoEggs {
        let v0 = arg0.name_nft;
        arg0.sum_nft = arg0.sum_nft + 1;
        0x1::string::append_utf8(&mut v0, numberToStr(arg0.sum_nft));
        EvoEggs{
            id      : 0x2::object::new(arg1),
            name    : v0,
            img_url : 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&arg0.ourl)),
            link    : 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&arg0.metadata)),
        }
    }

    public entry fun mint_nft_with_public(arg0: &mut InfoCollection, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::utils::get_key();
        assert!(0x2::ed25519::ed25519_verify(&arg1, &v0, &arg2), 12);
        assert!(arg0.sum_nft < arg0.hard_cap, 5);
        assert!(checkOwnerSign(arg2, arg4), 12);
        assert!(arg0.option_mint_public.timestamp_start <= 0x2::clock::timestamp_ms(arg3), 11);
        assert!(arg0.option_mint_public.timestamp_end >= 0x2::clock::timestamp_ms(arg3), 2);
        if (0x2::dynamic_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg4))) {
            let v1 = 0x2::dynamic_field::borrow_mut<address, u64>(&mut arg0.id, 0x2::tx_context::sender(arg4));
            assert!(*v1 < arg0.option_mint_public.user_mint_max, 7);
            *v1 = *v1 + 1;
        } else {
            0x2::dynamic_field::add<address, u64>(&mut arg0.id, 0x2::tx_context::sender(arg4), 1);
        };
        arg0.option_mint_public.sum_nft = arg0.option_mint_public.sum_nft + 1;
        let v2 = mint(arg0, arg4);
        let v3 = NFTMinted{
            object_id : 0x2::object::id<EvoEggs>(&v2),
            creator   : 0x2::tx_context::sender(arg4),
            name      : v2.name,
            image_url : v2.img_url,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<EvoEggs>(v2, 0x2::tx_context::sender(arg4));
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

    fun transferSui(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 1);
        0x2::balance::join<0x2::sui::SUI>(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun update_hardCap(arg0: &mut InfoCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::witness::check_owner(arg2), 1);
        arg0.hard_cap = arg1;
    }

    public entry fun update_time_public(arg0: &mut InfoCollection, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xe4cab1cf7ddbc822989488cc23c8614935dffe3c45d96c72239e3f6116656c8a::witness::check_owner(arg3), 1);
        if (arg1 == 1) {
            arg0.option_mint_public.timestamp_start = arg2;
        } else if (arg1 == 2) {
            arg0.option_mint_public.timestamp_end = arg2;
        };
    }

    // decompiled from Move bytecode v6
}

