module 0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::mint {
    struct BlubWhitelist has store, key {
        id: 0x2::object::UID,
    }

    struct CollectionData has store, key {
        id: 0x2::object::UID,
        nfts: 0x2::table_vec::TableVec<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>,
        registry: 0x2::table::Table<address, u64>,
        mint_wl_date: u64,
        mint_buy_date: u64,
        mint_buy_price: u64,
    }

    public entry fun mint(arg0: BlubWhitelist, arg1: &mut CollectionData, arg2: &0x2::transfer_policy::TransferPolicy<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFam>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.mint_wl_date >= 0x2::clock::timestamp_ms(arg3), 9223372333207519231);
        let BlubWhitelist { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = if (0x2::table_vec::length<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&arg1.nfts) == 1) {
            0
        } else {
            0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::pseuso_random::rng(0, 0x2::table_vec::length<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&arg1.nfts) - 1, arg3, arg6)
        };
        let v2 = if (0x2::table_vec::length<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&arg1.nfts) == 1) {
            0x2::table_vec::pop_back<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&mut arg1.nfts)
        } else {
            0x2::table_vec::swap_remove<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&mut arg1.nfts, v1)
        };
        0x2::kiosk::lock<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFam>(arg4, arg5, arg2, 0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::mint(v2, arg6));
    }

    public fun admin_mint(arg0: &0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::cap::MintCap, arg1: u64, arg2: &mut CollectionData, arg3: &0x2::transfer_policy::TransferPolicy<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFam>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        while (arg1 > 0) {
            let v0 = if (0x2::table_vec::length<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&arg2.nfts) == 1) {
                0
            } else {
                0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::pseuso_random::rng(0, 0x2::table_vec::length<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&arg2.nfts) - 1, arg4, arg7)
            };
            let v1 = if (0x2::table_vec::length<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&arg2.nfts) == 1) {
                0x2::table_vec::pop_back<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&mut arg2.nfts)
            } else {
                0x2::table_vec::swap_remove<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&mut arg2.nfts, v0)
            };
            0x2::kiosk::lock<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFam>(arg5, arg6, arg3, 0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::mint(v1, arg7));
            arg1 = arg1 - 1;
        };
    }

    public fun create_data(arg0: &0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::cap::MintCap, arg1: &mut CollectionData, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut vector<0x1::string::String>, arg5: &mut vector<0x1::string::String>, arg6: 0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>) {
        0x2::table_vec::push_back<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&mut arg1.nfts, 0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::create(arg2, arg3, arg4, arg5, arg6));
    }

    public fun distribute_wl(arg0: &0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::cap::MintCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v0 = BlubWhitelist{id: 0x2::object::new(arg2)};
            0x2::transfer::public_transfer<BlubWhitelist>(v0, 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionData{
            id             : 0x2::object::new(arg0),
            nfts           : 0x2::table_vec::empty<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(arg0),
            registry       : 0x2::table::new<address, u64>(arg0),
            mint_wl_date   : 0,
            mint_buy_date  : 0,
            mint_buy_price : 0,
        };
        0x2::transfer::public_share_object<CollectionData>(v0);
    }

    public entry fun mint_buy(arg0: 0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>, arg1: &mut CollectionData, arg2: &0x2::transfer_policy::TransferPolicy<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFam>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.mint_buy_date >= 0x2::clock::timestamp_ms(arg3), 9223372457761570815);
        assert!(arg1.mint_buy_price <= 0x2::coin::value<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(&arg0), 9223372462056538111);
        if (0x2::table::contains<address, u64>(&arg1.registry, 0x2::tx_context::sender(arg6))) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg1.registry, 0x2::tx_context::sender(arg6));
            assert!(*v0 < 2, 0);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg1.registry, 0x2::tx_context::sender(arg6), 1);
        };
        let v1 = if (0x2::table_vec::length<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&arg1.nfts) == 1) {
            0
        } else {
            0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::pseuso_random::rng(0, 0x2::table_vec::length<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&arg1.nfts) - 1, arg3, arg6)
        };
        let v2 = if (0x2::table_vec::length<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&arg1.nfts) == 1) {
            0x2::table_vec::pop_back<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&mut arg1.nfts)
        } else {
            0x2::table_vec::swap_remove<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&mut arg1.nfts, v1)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>>(arg0, @0x8e9a48fcdcd04180517aaf118e58d0b2bec3484f97b200aa6cda0d8028b038be);
        0x2::kiosk::lock<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFam>(arg4, arg5, arg2, 0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::mint(v2, arg6));
    }

    public fun mint_exact_numbers(arg0: &0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::cap::MintCap, arg1: vector<u64>, arg2: &mut CollectionData, arg3: &0x2::transfer_policy::TransferPolicy<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFam>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<u64>(&arg1) > 0) {
            0x2::kiosk::lock<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFam>(arg4, arg5, arg3, 0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::mint(0x2::table_vec::swap_remove<0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection::BlubFamData>(&mut arg2.nfts, 0x1::vector::pop_back<u64>(&mut arg1)), arg6));
        };
    }

    // decompiled from Move bytecode v6
}

