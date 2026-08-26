module 0xf2230d0d0bea32e42f8d452d72b1342443e059195f2376f9107ca0aa154ec374::solar_earth {
    struct SOLAR_EARTH has drop {
        dummy_field: bool,
    }

    struct CollectionConfig has key {
        id: 0x2::object::UID,
        total_minted: u64,
        treasury: address,
        admin: address,
        pending_admin: address,
        image_url: 0x2::url::Url,
    }

    struct SolarEarth has store, key {
        id: 0x2::object::UID,
        token_number: u64,
        collection_name: vector<u8>,
        image_url: 0x2::url::Url,
        mint_timestamp: u64,
    }

    struct Minted has copy, drop {
        buyer: address,
        first_token_number: u64,
        last_token_number: u64,
        quantity: u64,
        unit_price_mist: u64,
        paid_mist: u64,
    }

    public entry fun accept_admin(arg0: &mut CollectionConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.pending_admin, 7);
        arg0.admin = v0;
        arg0.pending_admin = @0x0;
    }

    public fun current_price_mist(arg0: u64) : u64 {
        assert!(arg0 <= 51010000, 1);
        let v0 = arg0 * 10000 / 51010000;
        if (v0 < 500) {
            100000000
        } else if (v0 < 1500) {
            200000000
        } else if (v0 < 3000) {
            300000000
        } else if (v0 < 5000) {
            500000000
        } else if (v0 < 7500) {
            800000000
        } else if (v0 < 9000) {
            1200000000
        } else {
            2000000000
        }
    }

    fun init(arg0: SOLAR_EARTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<SOLAR_EARTH>(arg0, arg1);
        let v2 = CollectionConfig{
            id            : 0x2::object::new(arg1),
            total_minted  : 0,
            treasury      : v0,
            admin         : v0,
            pending_admin : @0x0,
            image_url     : 0x2::url::new_unsafe_from_bytes(b"https://solar-earth.vercel.app/nft/solar-earth.png"),
        };
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"link"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Solar Earth #{token_number}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Solar Earth virtual photovoltaic panel NFT"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://solar-earth.vercel.app"));
        let v7 = 0x2::display::new_with_fields<SolarEarth>(&v1, v3, v5, arg1);
        0x2::display::update_version<SolarEarth>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<SolarEarth>>(v7, v0);
        0x2::transfer::share_object<CollectionConfig>(v2);
    }

    public entry fun mint_batch(arg0: &mut CollectionConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        mint_batch_impl(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3), arg4);
    }

    fun mint_batch_impl(arg0: &mut CollectionConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 100, 2);
        assert!(arg0.total_minted <= 51010000, 1);
        assert!(arg2 <= 51010000 - arg0.total_minted, 1);
        assert!(arg2 <= remaining_in_current_tier(arg0.total_minted), 5);
        let v0 = current_price_mist(arg0.total_minted);
        let v1 = v0 * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 3);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = arg0.total_minted + 1;
        let v4 = arg0.total_minted + arg2;
        let v5 = 0;
        while (v5 < arg2) {
            let v6 = SolarEarth{
                id              : 0x2::object::new(arg4),
                token_number    : v3 + v5,
                collection_name : b"Solar Earth",
                image_url       : arg0.image_url,
                mint_timestamp  : arg3,
            };
            0x2::transfer::public_transfer<SolarEarth>(v6, v2);
            v5 = v5 + 1;
        };
        arg0.total_minted = v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg4), arg0.treasury);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v2);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v7 = Minted{
            buyer              : v2,
            first_token_number : v3,
            last_token_number  : v4,
            quantity           : arg2,
            unit_price_mist    : v0,
            paid_mist          : v1,
        };
        0x2::event::emit<Minted>(v7);
    }

    public entry fun propose_admin(arg0: &mut CollectionConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        assert!(arg1 != @0x0, 6);
        arg0.pending_admin = arg1;
    }

    public fun remaining_in_current_tier(arg0: u64) : u64 {
        assert!(arg0 < 51010000, 1);
        tier_end_minted(arg0) - arg0
    }

    fun tier_end_minted(arg0: u64) : u64 {
        assert!(arg0 < 51010000, 1);
        if (arg0 < 2550500) {
            2550500
        } else if (arg0 < 7651500) {
            7651500
        } else if (arg0 < 15303000) {
            15303000
        } else if (arg0 < 25505000) {
            25505000
        } else if (arg0 < 38257500) {
            38257500
        } else if (arg0 < 45909000) {
            45909000
        } else {
            51010000
        }
    }

    public fun total_minted(arg0: &CollectionConfig) : u64 {
        arg0.total_minted
    }

    public entry fun update_image_url(arg0: &mut CollectionConfig, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public entry fun update_treasury(arg0: &mut CollectionConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        arg0.treasury = arg1;
    }

    // decompiled from Move bytecode v7
}

