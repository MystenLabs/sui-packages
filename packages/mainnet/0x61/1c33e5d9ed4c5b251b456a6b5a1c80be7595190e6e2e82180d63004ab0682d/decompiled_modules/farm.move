module 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::farm {
    struct FARM has drop {
        dummy_field: bool,
    }

    struct FarmAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        listed_items: vector<0x2::object::ID>,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        item: FarmAnimal,
        price: u64,
        seller: address,
    }

    struct FarmAnimal has store, key {
        id: 0x2::object::UID,
        animal_type: u8,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        weight: u64,
        health: 0x1::string::String,
        generation: u8,
        real_tag_id: 0x1::string::String,
        birth_date: u64,
        growth_target_days: u64,
        parent_id: 0x1::option::Option<0x2::object::ID>,
        kapogian_id: 0x1::option::Option<0x2::object::ID>,
    }

    entry fun acknowledge_daily_report(arg0: &mut FarmAnimal, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.weight = arg1;
        arg0.health = arg2;
    }

    entry fun burn_harvested_animal(arg0: FarmAnimal, arg1: &mut 0x2::tx_context::TxContext) {
        let FarmAnimal {
            id                 : v0,
            animal_type        : _,
            name               : _,
            image_url          : _,
            weight             : _,
            health             : _,
            generation         : _,
            real_tag_id        : _,
            birth_date         : _,
            growth_target_days : _,
            parent_id          : _,
            kapogian_id        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun buy_animal(arg0: Listing, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.price, 0);
        let Listing {
            id     : v0,
            item   : v1,
            price  : _,
            seller : v3,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v3);
        0x2::transfer::public_transfer<FarmAnimal>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun calculate_halving(arg0: u8, arg1: u64) : u64 {
        let v0 = 0;
        if (arg0 == 0) {
            v0 = arg1;
        } else if (arg0 == 1) {
            v0 = arg1 / 2;
        } else if (arg0 == 2) {
            v0 = arg1 / 4;
        } else if (arg0 == 3) {
            v0 = arg1 / 8;
        } else if (arg0 == 4) {
            v0 = arg1 / 16;
        };
        v0
    }

    entry fun distribute_payout(arg0: &FarmAdminCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x2::coin::value<0x2::sui::SUI>(&arg1) * 30 / 100, arg3), @0xb9c396cd825224a1d58d4688d52c4879195d00d714a042ef89c4054844d257b8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg2);
    }

    fun init(arg0: FARM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FARM>(arg0, arg1);
        let v1 = Marketplace{
            id           : 0x2::object::new(arg1),
            listed_items : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Marketplace>(v1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"A Kapogian Farm Animal linked to a physical farm!"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        let v6 = 0x2::display::new_with_fields<FarmAnimal>(&v0, v2, v4, arg1);
        0x2::display::update_version<FarmAnimal>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<FarmAnimal>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = FarmAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<FarmAdminCap>(v7, 0x2::tx_context::sender(arg1));
    }

    entry fun list_animal(arg0: &mut Marketplace, arg1: FarmAnimal, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.listed_items, 0x2::object::uid_to_inner(&v0));
        let v1 = Listing{
            id     : v0,
            item   : arg1,
            price  : arg2,
            seller : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::share_object<Listing>(v1);
    }

    entry fun mint_farm_nft(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: 0x2::object::ID, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x0);
        let v0 = FarmAnimal{
            id                 : 0x2::object::new(arg8),
            animal_type        : arg3,
            name               : arg4,
            image_url          : arg5,
            weight             : 0,
            health             : 0x1::string::utf8(b"Healthy"),
            generation         : 0,
            real_tag_id        : arg6,
            birth_date         : arg1,
            growth_target_days : arg7,
            parent_id          : 0x1::option::none<0x2::object::ID>(),
            kapogian_id        : 0x1::option::some<0x2::object::ID>(arg2),
        };
        0x2::transfer::public_transfer<FarmAnimal>(v0, 0x2::tx_context::sender(arg8));
    }

    entry fun register_offspring(arg0: &FarmAnimal, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = FarmAnimal{
            id                 : 0x2::object::new(arg6),
            animal_type        : arg0.animal_type,
            name               : arg2,
            image_url          : arg3,
            weight             : 0,
            health             : 0x1::string::utf8(b"Healthy"),
            generation         : arg0.generation + 1,
            real_tag_id        : arg4,
            birth_date         : arg1,
            growth_target_days : arg5,
            parent_id          : 0x1::option::some<0x2::object::ID>(0x2::object::id<FarmAnimal>(arg0)),
            kapogian_id        : arg0.kapogian_id,
        };
        0x2::transfer::public_transfer<FarmAnimal>(v0, 0x2::tx_context::sender(arg6));
    }

    entry fun unlist_animal(arg0: Listing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 0);
        let Listing {
            id     : v0,
            item   : v1,
            price  : _,
            seller : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<FarmAnimal>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

