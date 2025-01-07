module 0xcd350134512a0151ad4be4d02abde7248747127d12d6eefb79976cad3f2f42a5::jellyfish {
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
        tier: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        type: 0x1::string::String,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        discount: Discount,
        type: 0x1::string::String,
        for: address,
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

    struct JELLYFISH has drop {
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
                tier_4_pct : 20,
            };
            let v1 = Whitelist{
                id       : 0x2::object::new(arg3),
                discount : v0,
                type     : 0x1::string::utf8(b"OG"),
                for      : arg1,
            };
            0x2::transfer::public_transfer<Whitelist>(v1, arg1);
        } else {
            assert!(arg2 == 2, 2);
            let v2 = Discount{
                id         : 0x2::object::new(arg3),
                tier_1_pct : 30,
                tier_2_pct : 25,
                tier_3_pct : 25,
                tier_4_pct : 20,
            };
            let v3 = Whitelist{
                id       : 0x2::object::new(arg3),
                discount : v2,
                type     : 0x1::string::utf8(b"Whitelist"),
                for      : arg1,
            };
            0x2::transfer::public_transfer<Whitelist>(v3, arg1);
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

    fun gen_next_free(arg0: u16, arg1: &mut vector<bool>, arg2: u16) : u16 {
        let v0;
        loop {
            v0 = 0x1::vector::borrow_mut<bool>(arg1, (arg0 as u64));
            if (*v0 == false) {
                break
            };
            let v1 = arg0 + 1;
            arg0 = v1 % arg2;
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
            let v16 = 0x1::vector::length<Features>(&arg2.features) - 1;
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

    fun init(arg0: JELLYFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CreatorCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"tier"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Steampunk Jellyfish #{nr}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Tier {tier}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://steampunkjellyfish.com/nft/steampunkjellyfish{index}.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"These Steampunk Jellyfish are small, adaptable, smart and creative creatures that use their superpowers to defy the dangers in the depths of the ocean and have a lot of fun doing it."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Axelra Early Stage AG"));
        let v5 = 0x2::package::claim<JELLYFISH>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v6);
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
        let (v22, v23) = 0x2::transfer_policy::new<NFT>(&v5, arg1);
        let v24 = v23;
        let v25 = v22;
        let v26 = 30;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::add<NFT>(&mut v25, &v24, v26);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<NFT>(&mut v25, &v24);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT>>(v24, 0x2::tx_context::sender(arg1));
        let v27 = ContractInfo{
            id                      : 0x2::object::new(arg1),
            owner_address           : 0x2::tx_context::sender(arg1),
            required_payment_tier_1 : 200,
            required_payment_tier_2 : 150,
            required_payment_tier_3 : 75,
            required_payment_tier_4 : v26,
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
        0x2::transfer::share_object<ContractInfo>(v27);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT>>(v25);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut ContractInfo, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        mint0(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun mint0(arg0: &mut ContractInfo, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0;
        if (arg2 == 2) {
            let v1 = arg0.required_payment_tier_2 - arg0.required_payment_tier_2 * 20 / 100;
            v0 = v1;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 0);
        } else if (arg2 == 3) {
            let v2 = arg0.required_payment_tier_3 - arg0.required_payment_tier_3 * 15 / 100;
            v0 = v2;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v2, 0);
        } else if (arg2 == 4) {
            let v3 = arg0.required_payment_tier_4 - arg0.required_payment_tier_4 * 10 / 100;
            v0 = v3;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v3, 0);
        };
        assert!(v0 != 0, 2);
        let v4 = 0x2::tx_context::sender(arg5);
        payment_processing(arg1, v0, arg0.owner_address, v4, arg5);
        let v5 = 0x2::tx_context::sender(arg5);
        mintInternal(arg0, arg2, 0, 0x1::string::utf8(b"Early Adopter"), v5, arg3, arg4, true, arg5)
    }

    public entry fun mintDiscount(arg0: &mut ContractInfo, arg1: &Whitelist, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u8, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        mintDiscount0(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun mintDiscount0(arg0: &mut ContractInfo, arg1: &Whitelist, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u8, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0;
        if (arg3 == 1) {
            assert!(arg1.discount.tier_1_pct != 0, 0);
            let v1 = arg0.required_payment_tier_1 - arg0.required_payment_tier_1 * (arg1.discount.tier_1_pct as u64) / 100;
            v0 = v1;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1, 0);
        } else if (arg3 == 2) {
            assert!(arg1.discount.tier_2_pct != 0, 0);
            let v2 = arg0.required_payment_tier_2 - arg0.required_payment_tier_2 * (arg1.discount.tier_2_pct as u64) / 100;
            v0 = v2;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v2, 0);
        } else if (arg3 == 3) {
            assert!(arg1.discount.tier_3_pct != 0, 0);
            let v3 = arg0.required_payment_tier_3 - arg0.required_payment_tier_3 * (arg1.discount.tier_3_pct as u64) / 100;
            v0 = v3;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v3, 0);
        } else if (arg3 == 4) {
            assert!(arg1.discount.tier_4_pct != 0, 0);
            let v4 = arg0.required_payment_tier_4 - arg0.required_payment_tier_4 * (arg1.discount.tier_4_pct as u64) / 100;
            v0 = v4;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v4, 0);
        };
        assert!(v0 != 0, 2);
        assert!(arg1.for == 0x2::tx_context::sender(arg6), 4);
        let v5 = 0x2::tx_context::sender(arg6);
        payment_processing(arg2, v0, arg0.owner_address, v5, arg6);
        let v6 = 0x2::tx_context::sender(arg6);
        mintInternal(arg0, arg3, 0, arg1.type, v6, arg4, arg5, true, arg6)
    }

    fun mintInternal(arg0: &mut ContractInfo, arg1: u8, arg2: u16, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        if (arg2 == 0) {
            arg2 = ((0xcd350134512a0151ad4be4d02abde7248747127d12d6eefb79976cad3f2f42a5::pseudorandom::rand_u32(arg8) % 65535) as u16);
        };
        assert!(arg0.count_total < 2180, 1);
        arg0.count_total = arg0.count_total + 1;
        let v0 = arg2;
        let v1 = 0x1::string::utf8(b"");
        if (arg1 == 0) {
            assert!(arg0.count_tier_0 < 30, 1);
            arg0.count_tier_0 = arg0.count_tier_0 + 1;
            let v2 = &mut arg0.nfts_minted_tier_0;
            let v3 = gen_next_free(arg2 % 30, v2, 30);
            arg2 = v3;
            v0 = v3;
            v1 = 0x1::string::utf8(b"Team");
        } else if (arg1 == 1) {
            assert!(arg0.count_tier_1 < 50, 1);
            arg0.count_tier_1 = arg0.count_tier_1 + 1;
            let v4 = &mut arg0.nfts_minted_tier_1;
            let v5 = gen_next_free(arg2 % 50, v4, 50);
            arg2 = v5;
            v0 = v5 + 30;
            v1 = 0x1::string::utf8(b"Ultra Rare");
        } else if (arg1 == 2) {
            assert!(arg0.count_tier_2 < 100, 1);
            arg0.count_tier_2 = arg0.count_tier_2 + 1;
            let v6 = &mut arg0.nfts_minted_tier_2;
            let v7 = gen_next_free(arg2 % 100, v6, 100);
            arg2 = v7;
            v0 = v7 + 30 + 50;
            v1 = 0x1::string::utf8(b"Rare");
        } else if (arg1 == 3) {
            assert!(arg0.count_tier_3 < 500, 1);
            arg0.count_tier_3 = arg0.count_tier_3 + 1;
            let v8 = &mut arg0.nfts_minted_tier_3;
            let v9 = gen_next_free(arg2 % 500, v8, 500);
            arg2 = v9;
            v0 = v9 + 30 + 50 + 100;
            v1 = 0x1::string::utf8(b"Uncommon");
        } else if (arg1 == 4) {
            assert!(arg0.count_tier_4 < 1500, 1);
            arg0.count_tier_4 = arg0.count_tier_4 + 1;
            let v10 = &mut arg0.nfts_minted_tier_4;
            let v11 = gen_next_free(arg2 % 1500, v10, 1500);
            arg2 = v11;
            v0 = v11 + 30 + 50 + 100 + 500;
            v1 = 0x1::string::utf8(b"Common");
        };
        let v12 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v13 = 0x1::string::utf8(b"");
        let v14 = get_traits(arg2, arg1, arg0);
        let v15 = 0;
        while (v15 < 0x1::vector::length<Feature>(&v14)) {
            let v16 = 0x1::vector::borrow<Feature>(&v14, v15);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v12, v16.name, v16.trait);
            0x1::string::append(&mut v13, convert_u8(v16.index));
            v15 = v15 + 1;
        };
        let v17 = NFT{
            id         : 0x2::object::new(arg8),
            nr         : v0,
            index      : v13,
            tier       : v1,
            attributes : v12,
            type       : arg3,
        };
        let v18 = NFTMinted{
            id        : 0x2::object::id<NFT>(&v17),
            minted_by : arg4,
        };
        0x2::event::emit<NFTMinted>(v18);
        if (arg7) {
            0x2::kiosk::place<NFT>(arg5, arg6, v17);
        } else {
            0x2::transfer::public_transfer<NFT>(v17, arg0.owner_address);
        };
        0x2::object::id<NFT>(&v17)
    }

    public entry fun mint_custom(arg0: &CreatorCap, arg1: &mut ContractInfo, arg2: u16, arg3: u8, arg4: 0x1::string::String, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        mintInternal(arg1, arg3, arg2, arg4, v0, arg5, arg6, arg7, arg8);
    }

    public fun pay_nft(arg0: &NFT) : &NFT {
        arg0
    }

    fun payment_processing(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg0, arg1, arg2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg3);
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

