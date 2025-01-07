module 0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::gamio_collection_snake_legend {
    struct SnakeLegend has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x2::url::Url,
        link: 0x2::url::Url,
        creator: address,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct NFTMintedEggs has copy, drop {
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

    struct InfoCollection has store, key {
        id: 0x2::object::UID,
        name_nft: 0x1::string::String,
        description_nft: 0x1::string::String,
        ourl: 0x1::string::String,
        metadata: 0x1::string::String,
        sum_nft: u64,
        sui_deposit: 0x2::balance::Balance<0x2::sui::SUI>,
        hard_cap: u64,
        price_mint: u64,
    }

    struct EggsBasket has store, key {
        id: 0x2::object::UID,
    }

    struct GAMIO_COLLECTION_SNAKE_LEGEND has drop {
        dummy_field: bool,
    }

    public entry fun claim(arg0: &mut InfoCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::witness::check_owner(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_deposit, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    fun mint(arg0: &mut InfoCollection, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : SnakeLegend {
        let v0 = arg0.name_nft;
        arg0.sum_nft = arg0.sum_nft + 1;
        0x1::string::append_utf8(&mut v0, numberToStr(arg0.sum_nft));
        SnakeLegend{
            id      : 0x2::object::new(arg3),
            name    : v0,
            img_url : 0x2::url::new_unsafe_from_bytes(arg1),
            link    : 0x2::url::new_unsafe_from_bytes(arg2),
            creator : 0x2::tx_context::sender(arg3),
        }
    }

    fun check_sign_egg_stone(arg0: vector<u8>, arg1: address, arg2: address, arg3: vector<u8>, arg4: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(arg1));
        let v1 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v1, 0x2::address::to_string(arg2));
        let v2 = 0x1::string::utf8(arg3);
        let v3 = 0x1::string::length(&v2);
        let v4 = 0x1::string::utf8(arg0);
        v0 == 0x1::string::sub_string(&v4, 0, 66) && v1 == 0x1::string::sub_string(&v4, 67, 133) && v2 == 0x1::string::sub_string(&v4, 134, 134 + v3) && 0x1::string::utf8(arg4) == 0x1::string::sub_string(&v4, 135 + v3, 0x1::string::length(&v4))
    }

    fun check_sign_egg_sui(arg0: vector<u8>, arg1: address, arg2: vector<u8>, arg3: vector<u8>) : (bool, u64) {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(arg1));
        let v1 = 0x1::string::utf8(arg2);
        let v2 = 0x1::string::length(&v1);
        let v3 = 0x1::string::utf8(arg0);
        let v4 = 0x1::string::sub_string(&v3, 67, 68);
        let v5 = 0x1::string::utf8(b"1");
        let v6 = 0;
        if (v5 == v4) {
            v6 = 1;
        };
        let v7 = (0x1::string::utf8(b"0") == v4 || v5 == v4) && v0 == 0x1::string::sub_string(&v3, 0, 66) && v1 == 0x1::string::sub_string(&v3, 69, 69 + v2) && 0x1::string::utf8(arg3) == 0x1::string::sub_string(&v3, 70 + v2, 0x1::string::length(&v3));
        (v7, v6)
    }

    fun init(arg0: GAMIO_COLLECTION_SNAKE_LEGEND, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_description_nft()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_website()));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<GAMIO_COLLECTION_SNAKE_LEGEND>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SnakeLegend>(&v4, v0, v2, arg1);
        0x2::display::update_version<SnakeLegend>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SnakeLegend>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun init_infocollection(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InfoCollection{
            id              : 0x2::object::new(arg0),
            name_nft        : 0x1::string::utf8(0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_name_nft()),
            description_nft : 0x1::string::utf8(0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_description_nft()),
            ourl            : 0x1::string::utf8(0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_image_url()),
            metadata        : 0x1::string::utf8(0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_metadata_url()),
            sum_nft         : 0,
            sui_deposit     : 0x2::balance::zero<0x2::sui::SUI>(),
            hard_cap        : 0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_hard_cap(),
            price_mint      : 0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_price_mint(),
        };
        let v1 = EggsBasket{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<EggsBasket>(v1);
        0x2::transfer::share_object<InfoCollection>(v0);
    }

    public entry fun mix_egg_stone<T0: store + key, T1: store + key>(arg0: &mut InfoCollection, arg1: vector<u8>, arg2: vector<u8>, arg3: T0, arg4: T1, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_key();
        assert!(0x2::ed25519::ed25519_verify(&arg1, &v0, &arg2), 12);
        assert!(check_sign_egg_stone(arg2, 0x2::object::id_address<T0>(&arg3), 0x2::object::id_address<T1>(&arg4), arg5, arg6), 1223);
        assert!(arg0.sum_nft < arg0.hard_cap, 5);
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_type_egg1() || 0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_type_egg2(), 9);
        assert!(0x1::type_name::into_string(0x1::type_name::get<T1>()) == 0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_type_gem(), 9);
        let v1 = mint(arg0, arg5, arg6, arg7);
        let v2 = NFTMinted{
            object_id : 0x2::object::id<SnakeLegend>(&v1),
            creator   : 0x2::tx_context::sender(arg7),
            name      : v1.name,
            image_url : v1.img_url,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::dynamic_object_field::add<0x1::string::String, T0>(&mut v1.id, 0x1::string::utf8(b"Evo Eggs"), arg3);
        0x2::dynamic_object_field::add<0x1::string::String, T1>(&mut v1.id, 0x1::string::utf8(b"Magic Stone"), arg4);
        0x2::transfer::public_transfer<SnakeLegend>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun mix_egg_sui<T0: store + key>(arg0: &mut InfoCollection, arg1: &mut EggsBasket, arg2: vector<u8>, arg3: vector<u8>, arg4: T0, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_key();
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v0, &arg3), 12);
        assert!(arg0.sum_nft < arg0.hard_cap, 5);
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_type_egg1() || 0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::snake_item::get_type_egg2(), 9);
        let (v1, v2) = check_sign_egg_sui(arg3, 0x2::object::id_address<T0>(&arg4), arg6, arg7);
        assert!(v1, 123);
        if (v2 == 1) {
            let v3 = mint(arg0, arg6, arg7, arg8);
            let v4 = NFTMinted{
                object_id : 0x2::object::id<SnakeLegend>(&v3),
                creator   : 0x2::tx_context::sender(arg8),
                name      : v3.name,
                image_url : v3.img_url,
            };
            0x2::event::emit<NFTMinted>(v4);
            0x2::dynamic_object_field::add<0x1::string::String, T0>(&mut v3.id, 0x1::string::utf8(b"Evo Eggs"), arg4);
            0x2::transfer::public_transfer<SnakeLegend>(v3, 0x2::tx_context::sender(arg8));
        } else {
            let v5 = 0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::broken_egg::mint(arg8);
            let v6 = NFTMintedEggs{
                object_id : 0x2::object::id<0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::broken_egg::BrokenEgg>(&v5),
                creator   : 0x2::tx_context::sender(arg8),
                name      : 0x1::string::utf8(b"Broken Evo Egg"),
                image_url : 0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihjak7rph5fzxkzswquxkmzjfimjpa74xj6jaq4wnqx45ffmbcuru"),
            };
            0x2::event::emit<NFTMintedEggs>(v6);
            0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg1.id, 0x2::object::id<T0>(&arg4), arg4);
            0x2::transfer::public_transfer<0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::broken_egg::BrokenEgg>(v5, 0x2::tx_context::sender(arg8));
        };
        let v7 = &mut arg0.sui_deposit;
        transferSui(v7, arg5, arg0.price_mint, arg8);
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
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 6);
        0x2::balance::join<0x2::sui::SUI>(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun update_hardcap(arg0: &mut InfoCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::witness::check_owner(arg2), 1);
        arg0.hard_cap = arg1;
    }

    public entry fun update_price_mix(arg0: &mut InfoCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaafe05da55b1b5f8463b4943a0edc8e74a672d73bc49f6daa4f258906ad68fd4::witness::check_owner(arg2), 1);
        arg0.price_mint = arg1;
    }

    // decompiled from Move bytecode v6
}

