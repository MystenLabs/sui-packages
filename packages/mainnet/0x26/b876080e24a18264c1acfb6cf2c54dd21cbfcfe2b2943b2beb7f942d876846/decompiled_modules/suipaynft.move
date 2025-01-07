module 0x26b876080e24a18264c1acfb6cf2c54dd21cbfcfe2b2943b2beb7f942d876846::suipaynft {
    struct CreatorCap has key {
        id: 0x2::object::UID,
    }

    struct ContractInfo has key {
        id: 0x2::object::UID,
        owner_address: address,
        required_payment_tier_1: u64,
        required_payment_tier_2: u64,
        required_payment_tier_3: u64,
        required_payment_tier_4: u64,
        count_tier_0: u16,
        count_tier_1: u16,
        count_tier_2: u16,
        count_tier_3: u16,
        count_tier_4: u16,
        count_total: u16,
        nfts_minted_tier_0: vector<bool>,
        nfts_minted_tier_1: vector<bool>,
        nfts_minted_tier_2: vector<bool>,
        nfts_minted_tier_3: vector<bool>,
        nfts_minted_tier_4: vector<bool>,
        features: vector<Features>,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        nr: u16,
        index: 0x1::string::String,
        tier: u8,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        type: 0x1::string::String,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        tier: TierDiscount,
        type: 0x1::string::String,
    }

    struct TierDiscount has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        discount: Discount,
    }

    struct Discount has store, key {
        id: 0x2::object::UID,
        tier_1_pct: u16,
        tier_2_pct: u16,
        tier_3_pct: u16,
        tier_4_pct: u16,
    }

    struct Features has drop, store {
        name: 0x1::string::String,
        traits: vector<0x1::string::String>,
    }

    struct Feature has drop, store {
        name: 0x1::string::String,
        trait: 0x1::string::String,
        index: u8,
    }

    struct NFTMinted has copy, drop {
        id: 0x2::object::ID,
        minted_by: address,
    }

    struct SUIPAYNFT has drop {
        dummy_field: bool,
    }

    public entry fun add_attribute(arg0: &CreatorCap, arg1: &mut NFT, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, arg2, arg3);
    }

    public entry fun add_discount(arg0: &CreatorCap, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 1) {
            let v0 = Discount{
                id         : 0x2::object::new(arg3),
                tier_1_pct : 40,
                tier_2_pct : 30,
                tier_3_pct : 25,
                tier_4_pct : 50,
            };
            let v1 = TierDiscount{
                id       : 0x2::object::new(arg3),
                name     : 0x1::string::utf8(b"Super OG"),
                discount : v0,
            };
            let v2 = Whitelist{
                id   : 0x2::object::new(arg3),
                tier : v1,
                type : 0x1::string::utf8(b"Super OG"),
            };
            0x2::transfer::public_transfer<Whitelist>(v2, arg1);
        } else if (arg2 == 2) {
            let v3 = Discount{
                id         : 0x2::object::new(arg3),
                tier_1_pct : 0,
                tier_2_pct : 30,
                tier_3_pct : 25,
                tier_4_pct : 20,
            };
            let v4 = TierDiscount{
                id       : 0x2::object::new(arg3),
                name     : 0x1::string::utf8(b"Whitelist"),
                discount : v3,
            };
            let v5 = Whitelist{
                id   : 0x2::object::new(arg3),
                tier : v4,
                type : 0x1::string::utf8(b"Whitelist"),
            };
            0x2::transfer::public_transfer<Whitelist>(v5, arg1);
        } else if (arg2 == 3) {
            let v6 = Discount{
                id         : 0x2::object::new(arg3),
                tier_1_pct : 0,
                tier_2_pct : 0,
                tier_3_pct : 15,
                tier_4_pct : 10,
            };
            let v7 = TierDiscount{
                id       : 0x2::object::new(arg3),
                name     : 0x1::string::utf8(b"Early Adopter"),
                discount : v6,
            };
            let v8 = Whitelist{
                id   : 0x2::object::new(arg3),
                tier : v7,
                type : 0x1::string::utf8(b"Early Adopter"),
            };
            0x2::transfer::public_transfer<Whitelist>(v8, arg1);
        };
    }

    public entry fun add_field(arg0: &CreatorCap, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::add<NFT>(arg1, arg2, arg3);
    }

    public fun contract_info(arg0: &ContractInfo) : &ContractInfo {
        arg0
    }

    fun convert_to_3bit(arg0: u16, arg1: u64) : u8 {
        ((arg0 >> ((3 * arg1) as u8) & 7) as u8)
    }

    fun convert_u8(arg0: u8) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = b"";
        0x1::vector::push_back<u8>(&mut v1, arg0);
        let v2 = 0x1::string::utf8(0x2::hex::encode(v1));
        0x1::string::append(&mut v0, 0x1::string::sub_string(&v2, 1, 2));
        v0
    }

    public entry fun destroy(arg0: NFT) {
        let NFT {
            id         : v0,
            nr         : _,
            index      : _,
            tier       : _,
            attributes : _,
            type       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun edit_field(arg0: &CreatorCap, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::edit<NFT>(arg1, arg2, arg3);
    }

    fun gen_next_free(arg0: u16, arg1: vector<bool>) : u16 {
        let v0;
        loop {
            v0 = 0x1::vector::borrow_mut<bool>(&mut arg1, (arg0 as u64));
            if (*v0 == false) {
                break
            };
            let v1 = arg0 + 1;
            arg0 = v1 % 2180;
        };
        *v0 = true;
        arg0
    }

    fun get_traits(arg0: u16, arg1: u8, arg2: &ContractInfo) : vector<Feature> {
        let v0 = 0x1::vector::empty<Feature>();
        let v1 = 0;
        if (arg1 < 3) {
            let v2 = 0x1::vector::length<Features>(&arg2.features) - 1;
            while (v1 < v2) {
                let v3 = 0x1::vector::borrow<Features>(&arg2.features, v1);
                assert!(0x1::vector::length<0x1::string::String>(&v3.traits) == 8, 3);
                let v4 = convert_to_3bit(arg0 ^ 498, (v1 + (arg1 as u64)) % v2);
                let v5 = Feature{
                    name  : v3.name,
                    trait : *0x1::vector::borrow<0x1::string::String>(&v3.traits, ((v4 + arg1) as u64) % v2),
                    index : v4 + 1,
                };
                0x1::vector::push_back<Feature>(&mut v0, v5);
                v1 = v1 + 1;
            };
            let v6 = 0x1::vector::borrow<Features>(&arg2.features, 3);
            let v7 = Feature{
                name  : v6.name,
                trait : *0x1::vector::borrow<0x1::string::String>(&v6.traits, (arg1 as u64)),
                index : arg1 + 1,
            };
            0x1::vector::push_back<Feature>(&mut v0, v7);
        } else if (arg1 == 3) {
            let v8 = arg0 ^ 498;
            let v9 = 0x1::vector::length<Features>(&arg2.features) - 1;
            while (v1 < v9) {
                let v10 = 0x1::vector::borrow<Features>(&arg2.features, v1);
                assert!(0x1::vector::length<0x1::string::String>(&v10.traits) == 8, 3);
                let v11 = convert_to_3bit(v8, (v1 + (arg1 as u64)) % v9);
                let v12 = Feature{
                    name  : v10.name,
                    trait : *0x1::vector::borrow<0x1::string::String>(&v10.traits, ((v11 + arg1) as u64) % v9),
                    index : v11 + 1,
                };
                0x1::vector::push_back<Feature>(&mut v0, v12);
                v1 = v1 + 1;
            };
            let v13 = 3 + (v8 + 256 >> 9 & 1);
            let v14 = 0x1::vector::borrow<Features>(&arg2.features, 3);
            let v15 = Feature{
                name  : v14.name,
                trait : *0x1::vector::borrow<0x1::string::String>(&v14.traits, (v13 as u64)),
                index : ((v13 + 1) as u8),
            };
            0x1::vector::push_back<Feature>(&mut v0, v15);
        } else {
            let v16 = 0x1::vector::length<Features>(&arg2.features);
            while (v1 < v16) {
                let v17 = 0x1::vector::borrow<Features>(&arg2.features, v1);
                assert!(0x1::vector::length<0x1::string::String>(&v17.traits) == 8, 3);
                let v18 = convert_to_3bit(arg0, (v1 + (arg1 as u64)) % v16);
                let v19 = Feature{
                    name  : v17.name,
                    trait : *0x1::vector::borrow<0x1::string::String>(&v17.traits, (v18 as u64)),
                    index : v18 + 1,
                };
                0x1::vector::push_back<Feature>(&mut v0, v19);
                v1 = v1 + 1;
            };
            let v20 = 0x1::vector::borrow<Features>(&arg2.features, 3);
            let v21 = 5 + (arg0 >> 9 & 3);
            let v22 = Feature{
                name  : v20.name,
                trait : *0x1::vector::borrow<0x1::string::String>(&v20.traits, (v21 as u64)),
                index : ((v21 + 1) as u8),
            };
            0x1::vector::push_back<Feature>(&mut v0, v22);
        };
        v0
    }

    fun init(arg0: SUIPAYNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CreatorCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"tier"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Jelly #{nr}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Tier {tier}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://axelra.net/nft/jelly{index}.html"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://axelra.net/nft/jelly{index}.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Test Sui Pay NFT6"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://axelra.net/nft"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Sui Pay Test Team"));
        let v5 = 0x2::package::claim<SUIPAYNFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = 0;
        let v8 = 0x1::vector::empty<bool>();
        while (v7 < 30) {
            0x1::vector::push_back<bool>(&mut v8, false);
            v7 = v7 + 1;
        };
        v7 = 0;
        let v9 = 0x1::vector::empty<bool>();
        while (v7 < 50) {
            0x1::vector::push_back<bool>(&mut v9, false);
            v7 = v7 + 1;
        };
        v7 = 0;
        let v10 = 0x1::vector::empty<bool>();
        while (v7 < 100) {
            0x1::vector::push_back<bool>(&mut v10, false);
            v7 = v7 + 1;
        };
        v7 = 0;
        let v11 = 0x1::vector::empty<bool>();
        while (v7 < 500) {
            0x1::vector::push_back<bool>(&mut v11, false);
            v7 = v7 + 1;
        };
        v7 = 0;
        let v12 = 0x1::vector::empty<bool>();
        while (v7 < 1500) {
            0x1::vector::push_back<bool>(&mut v12, false);
            v7 = v7 + 1;
        };
        let v13 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v13, 0x1::string::utf8(b"Purple Jelly"));
        0x1::vector::push_back<0x1::string::String>(&mut v13, 0x1::string::utf8(b"Red Jelly"));
        0x1::vector::push_back<0x1::string::String>(&mut v13, 0x1::string::utf8(b"Pink Jelly"));
        0x1::vector::push_back<0x1::string::String>(&mut v13, 0x1::string::utf8(b"Orange Jelly"));
        0x1::vector::push_back<0x1::string::String>(&mut v13, 0x1::string::utf8(b"Sky Jelly"));
        0x1::vector::push_back<0x1::string::String>(&mut v13, 0x1::string::utf8(b"Green Jelly"));
        0x1::vector::push_back<0x1::string::String>(&mut v13, 0x1::string::utf8(b"Black Jelly"));
        0x1::vector::push_back<0x1::string::String>(&mut v13, 0x1::string::utf8(b"Lime Jelly"));
        let v14 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v14, 0x1::string::utf8(b"Deep Sea Wings"));
        0x1::vector::push_back<0x1::string::String>(&mut v14, 0x1::string::utf8(b"Magic Mini Hat"));
        0x1::vector::push_back<0x1::string::String>(&mut v14, 0x1::string::utf8(b"Butterfly Wings"));
        0x1::vector::push_back<0x1::string::String>(&mut v14, 0x1::string::utf8(b"Golden Dagger"));
        0x1::vector::push_back<0x1::string::String>(&mut v14, 0x1::string::utf8(b"Compasses"));
        0x1::vector::push_back<0x1::string::String>(&mut v14, 0x1::string::utf8(b"Fly Wings"));
        0x1::vector::push_back<0x1::string::String>(&mut v14, 0x1::string::utf8(b"Mechanical Bowler"));
        0x1::vector::push_back<0x1::string::String>(&mut v14, 0x1::string::utf8(b"Steam Cylinder"));
        let v15 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v15, 0x1::string::utf8(b"Mechanic Glasses"));
        0x1::vector::push_back<0x1::string::String>(&mut v15, 0x1::string::utf8(b"Pink Laser"));
        0x1::vector::push_back<0x1::string::String>(&mut v15, 0x1::string::utf8(b"Binoculars"));
        0x1::vector::push_back<0x1::string::String>(&mut v15, 0x1::string::utf8(b"Orange Laser"));
        0x1::vector::push_back<0x1::string::String>(&mut v15, 0x1::string::utf8(b"One-eyed"));
        0x1::vector::push_back<0x1::string::String>(&mut v15, 0x1::string::utf8(b"Turquoise Laser"));
        0x1::vector::push_back<0x1::string::String>(&mut v15, 0x1::string::utf8(b"Camera"));
        0x1::vector::push_back<0x1::string::String>(&mut v15, 0x1::string::utf8(b"Green Laser"));
        let v16 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v16, 0x1::string::utf8(b"Blue Ocean"));
        0x1::vector::push_back<0x1::string::String>(&mut v16, 0x1::string::utf8(b"Mystic Orange"));
        0x1::vector::push_back<0x1::string::String>(&mut v16, 0x1::string::utf8(b"Green Depth"));
        0x1::vector::push_back<0x1::string::String>(&mut v16, 0x1::string::utf8(b"Pink Glow"));
        0x1::vector::push_back<0x1::string::String>(&mut v16, 0x1::string::utf8(b"Turquoise Light"));
        0x1::vector::push_back<0x1::string::String>(&mut v16, 0x1::string::utf8(b"Dark Red Ocean"));
        0x1::vector::push_back<0x1::string::String>(&mut v16, 0x1::string::utf8(b"Dark Ocean"));
        0x1::vector::push_back<0x1::string::String>(&mut v16, 0x1::string::utf8(b"Yellow Glow"));
        let v17 = 0x1::vector::empty<Features>();
        let v18 = Features{
            name   : 0x1::string::utf8(b"Jellyfish"),
            traits : v13,
        };
        0x1::vector::push_back<Features>(&mut v17, v18);
        let v19 = Features{
            name   : 0x1::string::utf8(b"Equipment"),
            traits : v14,
        };
        0x1::vector::push_back<Features>(&mut v17, v19);
        let v20 = Features{
            name   : 0x1::string::utf8(b"Decoration"),
            traits : v15,
        };
        0x1::vector::push_back<Features>(&mut v17, v20);
        let v21 = Features{
            name   : 0x1::string::utf8(b"Ocean Background"),
            traits : v16,
        };
        0x1::vector::push_back<Features>(&mut v17, v21);
        let v22 = ContractInfo{
            id                      : 0x2::object::new(arg1),
            owner_address           : 0x2::tx_context::sender(arg1),
            required_payment_tier_1 : 200000000000,
            required_payment_tier_2 : 150000000000,
            required_payment_tier_3 : 75000000000,
            required_payment_tier_4 : 30000000000,
            count_tier_0            : 0,
            count_tier_1            : 0,
            count_tier_2            : 0,
            count_tier_3            : 0,
            count_tier_4            : 0,
            count_total             : 0,
            nfts_minted_tier_0      : v8,
            nfts_minted_tier_1      : v9,
            nfts_minted_tier_2      : v10,
            nfts_minted_tier_3      : v11,
            nfts_minted_tier_4      : v12,
            features                : v17,
        };
        0x2::transfer::share_object<ContractInfo>(v22);
    }

    public entry fun mint(arg0: &mut ContractInfo, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        if (arg2 == 3) {
            let v1 = arg0.required_payment_tier_3;
            v0 = v1;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 0);
        } else if (arg2 == 4) {
            let v2 = arg0.required_payment_tier_4;
            v0 = v2;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v2, 0);
        };
        assert!(v0 != 0, 2);
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg1, v0, arg0.owner_address, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
        let v3 = 0x2::tx_context::sender(arg3);
        mintInternal(arg0, arg2, 0, 0x1::string::utf8(b"Supporter"), v3, arg3);
    }

    public entry fun mintDiscount(arg0: &mut ContractInfo, arg1: &Whitelist, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        if (arg3 == 1) {
            assert!(arg1.tier.discount.tier_1_pct != 0, 0);
            let v1 = arg0.required_payment_tier_1 - arg0.required_payment_tier_1 * (arg1.tier.discount.tier_1_pct as u64) / 100;
            v0 = v1;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1, 0);
        } else if (arg3 == 2) {
            assert!(arg1.tier.discount.tier_2_pct != 0, 0);
            let v2 = arg0.required_payment_tier_2 - arg0.required_payment_tier_2 * (arg1.tier.discount.tier_2_pct as u64) / 100;
            v0 = v2;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v2, 0);
        } else if (arg3 == 3) {
            assert!(arg1.tier.discount.tier_3_pct != 0, 0);
            let v3 = arg0.required_payment_tier_3 - arg0.required_payment_tier_3 * (arg1.tier.discount.tier_3_pct as u64) / 100;
            v0 = v3;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v3, 0);
        } else if (arg3 == 4) {
            assert!(arg1.tier.discount.tier_4_pct != 0, 0);
            let v4 = arg0.required_payment_tier_4 - arg0.required_payment_tier_4 * (arg1.tier.discount.tier_4_pct as u64) / 100;
            v0 = v4;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v4, 0);
        };
        assert!(v0 != 0, 2);
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg2, v0, arg0.owner_address, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        let v5 = 0x2::tx_context::sender(arg4);
        mintInternal(arg0, arg3, 0, arg1.type, v5, arg4);
    }

    fun mintInternal(arg0: &mut ContractInfo, arg1: u8, arg2: u16, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            arg2 = ((0x26b876080e24a18264c1acfb6cf2c54dd21cbfcfe2b2943b2beb7f942d876846::pseudorandom::rand_u32(arg5) % 65535) as u16);
        };
        assert!(arg0.count_total < 2180, 1);
        arg0.count_total = arg0.count_total + 1;
        let v0 = arg2;
        if (arg1 == 0) {
            assert!(arg0.count_tier_0 < 30, 1);
            arg0.count_tier_0 = arg0.count_tier_0 + 1;
            let v1 = gen_next_free(arg2 % 30, arg0.nfts_minted_tier_0);
            arg2 = v1;
            v0 = v1;
        } else if (arg1 == 1) {
            assert!(arg0.count_tier_1 < 50, 1);
            arg0.count_tier_1 = arg0.count_tier_1 + 1;
            let v2 = gen_next_free(arg2 % 50, arg0.nfts_minted_tier_1);
            arg2 = v2;
            v0 = v2 + 30;
        } else if (arg1 == 2) {
            assert!(arg0.count_tier_2 < 100, 1);
            arg0.count_tier_2 = arg0.count_tier_2 + 1;
            let v3 = gen_next_free(arg2 % 100, arg0.nfts_minted_tier_2);
            arg2 = v3;
            v0 = v3 + 50;
        } else if (arg1 == 3) {
            assert!(arg0.count_tier_3 < 500, 1);
            arg0.count_tier_3 = arg0.count_tier_3 + 1;
            let v4 = gen_next_free(arg2 % 500, arg0.nfts_minted_tier_3);
            arg2 = v4;
            v0 = v4 + 100;
        } else if (arg1 == 4) {
            assert!(arg0.count_tier_4 < 1500, 1);
            arg0.count_tier_4 = arg0.count_tier_4 + 1;
            let v5 = gen_next_free(arg2 % 1500, arg0.nfts_minted_tier_4);
            arg2 = v5;
            v0 = v5 + 500;
        };
        let v6 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v7 = 0x1::string::utf8(b"");
        let v8 = get_traits(arg2, arg1, arg0);
        let v9 = 0;
        while (v9 < 0x1::vector::length<Feature>(&v8)) {
            let v10 = 0x1::vector::borrow<Feature>(&v8, v9);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v6, v10.name, v10.trait);
            0x1::string::append(&mut v7, convert_u8(v10.index));
            v9 = v9 + 1;
        };
        let v11 = NFT{
            id         : 0x2::object::new(arg5),
            nr         : v0,
            index      : v7,
            tier       : arg1,
            attributes : v6,
            type       : arg3,
        };
        let v12 = NFTMinted{
            id        : 0x2::object::id<NFT>(&v11),
            minted_by : arg4,
        };
        0x2::event::emit<NFTMinted>(v12);
        0x2::transfer::public_transfer<NFT>(v11, arg4);
    }

    public entry fun mint_team(arg0: &CreatorCap, arg1: &mut ContractInfo, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        mintInternal(arg1, 0, arg2, 0x1::string::utf8(b"Team"), v0, arg3);
    }

    public fun pay_nft(arg0: &NFT) : &NFT {
        arg0
    }

    public entry fun remove_field(arg0: &CreatorCap, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String) {
        0x2::display::remove<NFT>(arg1, arg2);
    }

    public entry fun set_owner_address(arg0: &CreatorCap, arg1: &mut ContractInfo, arg2: address) {
        arg1.owner_address = arg2;
    }

    public fun whitelist(arg0: &Whitelist) : &Whitelist {
        arg0
    }

    // decompiled from Move bytecode v6
}

