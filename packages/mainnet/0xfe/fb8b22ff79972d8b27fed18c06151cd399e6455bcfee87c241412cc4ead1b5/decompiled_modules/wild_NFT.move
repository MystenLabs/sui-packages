module 0xfefb8b22ff79972d8b27fed18c06151cd399e6455bcfee87c241412cc4ead1b5::wild_NFT {
    struct WILD_NFT has drop {
        dummy_field: bool,
    }

    struct Animals has key {
        id: 0x2::object::UID,
        animal_infos: 0x2::table::Table<u64, AnimalInfo>,
    }

    struct AnimalInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        species: 0x1::string::String,
        habitat: 0x1::string::String,
        status: u64,
        image_url: 0x1::string::String,
    }

    struct AnimalNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        animal_id: u64,
        species: 0x1::string::String,
        habitat: 0x1::string::String,
        adopted_by: address,
        image_url: 0x1::string::String,
        create_time: u64,
    }

    struct NFTAdminCap has key {
        id: 0x2::object::UID,
    }

    struct MintRecord has key {
        id: 0x2::object::UID,
        record: 0x2::linked_table::LinkedTable<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct NFTAbandoned has copy, drop {
        name: 0x1::string::String,
        species: 0x1::string::String,
        habitat: 0x1::string::String,
        abandoned_by: address,
        image_url: 0x1::string::String,
    }

    struct Nft_weight has drop, store {
        status_weight: u64,
        time_weight: u64,
    }

    public entry fun abandon_adoption(arg0: AnimalNFT, arg1: &mut 0xfefb8b22ff79972d8b27fed18c06151cd399e6455bcfee87c241412cc4ead1b5::wild_coin::WildVault, arg2: &mut MintRecord, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTAbandoned{
            name         : arg0.name,
            species      : arg0.species,
            habitat      : arg0.habitat,
            abandoned_by : 0x2::tx_context::sender(arg3),
            image_url    : arg0.image_url,
        };
        0x2::event::emit<NFTAbandoned>(v0);
        let v1 = arg0.animal_id;
        if (0x2::linked_table::contains<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg2.record, v1)) {
            let v2 = 0x2::linked_table::borrow_mut<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&mut arg2.record, v1);
            0x2::linked_table::remove<0x2::object::ID, u64>(v2, 0x2::object::id<AnimalNFT>(&arg0));
            if (0x2::linked_table::is_empty<0x2::object::ID, u64>(v2)) {
                0x2::linked_table::drop<0x2::object::ID, u64>(0x2::linked_table::remove<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&mut arg2.record, v1));
            };
        };
        let AnimalNFT {
            id          : v3,
            name        : _,
            animal_id   : _,
            species     : _,
            habitat     : _,
            adopted_by  : _,
            image_url   : _,
            create_time : _,
        } = arg0;
        0x2::object::delete(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfefb8b22ff79972d8b27fed18c06151cd399e6455bcfee87c241412cc4ead1b5::wild_coin::WILD_COIN>>(0xfefb8b22ff79972d8b27fed18c06151cd399e6455bcfee87c241412cc4ead1b5::wild_coin::withdraw_wild_coin_from_vault(arg1, 10, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun calculate_send_airdrop_distribution(arg0: &NFTAdminCap, arg1: &MintRecord, arg2: &Animals, arg3: &mut 0xfefb8b22ff79972d8b27fed18c06151cd399e6455bcfee87c241412cc4ead1b5::wild_coin::WildVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x2::linked_table::new<0x2::object::ID, u64>(arg5);
        let v3 = 0x2::linked_table::front<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg1.record);
        let v4 = 0x2::linked_table::new<0x2::object::ID, Nft_weight>(arg5);
        while (0x1::option::is_some<u64>(v3)) {
            let v5 = 0x1::option::borrow<u64>(v3);
            let v6 = 0x2::linked_table::borrow<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg1.record, *v5);
            let v7 = 0x2::table::borrow<u64, AnimalInfo>(&arg2.animal_infos, *v5).status;
            let v8 = 0x2::linked_table::front<0x2::object::ID, u64>(v6);
            while (0x1::option::is_some<0x2::object::ID>(v8)) {
                let v9 = 0x1::option::borrow<0x2::object::ID>(v8);
                let v10 = (0x2::clock::timestamp_ms(arg4) - *0x2::linked_table::borrow<0x2::object::ID, u64>(v6, *v9)) / 86400000;
                v0 = v0 + v7;
                v1 = v1 + v10;
                let v11 = Nft_weight{
                    status_weight : v7,
                    time_weight   : v10,
                };
                0x2::linked_table::push_back<0x2::object::ID, Nft_weight>(&mut v4, *v9, v11);
                v8 = 0x2::linked_table::next<0x2::object::ID, u64>(v6, *v9);
            };
            v3 = 0x2::linked_table::next<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg1.record, *v5);
        };
        let v12 = 0x2::linked_table::front<0x2::object::ID, Nft_weight>(&v4);
        while (0x1::option::is_some<0x2::object::ID>(v12)) {
            let v13 = 0x1::option::borrow<0x2::object::ID>(v12);
            let v14 = 0x2::linked_table::borrow<0x2::object::ID, Nft_weight>(&v4, *v13);
            0x2::linked_table::push_back<0x2::object::ID, u64>(&mut v2, *v13, v14.status_weight * 1000000000 / v0 * 8 / 10 + v14.time_weight * 1000000000 / v1 * 2 / 10);
            v12 = 0x2::linked_table::next<0x2::object::ID, Nft_weight>(&v4, *v13);
        };
        0xfefb8b22ff79972d8b27fed18c06151cd399e6455bcfee87c241412cc4ead1b5::wild_coin::distribute_airdrop(&v2, arg3, arg5);
        0x2::linked_table::destroy_empty<0x2::object::ID, u64>(v2);
        0x2::linked_table::destroy_empty<0x2::object::ID, Nft_weight>(v4);
    }

    public entry fun create_animal_info(arg0: &NFTAdminCap, arg1: &mut Animals, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = AnimalInfo{
            id        : 0x2::object::new(arg7),
            name      : arg2,
            species   : arg3,
            habitat   : arg4,
            status    : arg5,
            image_url : arg6,
        };
        0x2::table::add<u64, AnimalInfo>(&mut arg1.animal_infos, 0x2::table::length<u64, AnimalInfo>(&arg1.animal_infos), v0);
    }

    public entry fun fund_and_purchase_nft(arg0: &Animals, arg1: u64, arg2: &mut MintRecord, arg3: 0x2::coin::Coin<0xfefb8b22ff79972d8b27fed18c06151cd399e6455bcfee87c241412cc4ead1b5::wild_coin::WILD_COIN>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg8: &mut 0xfefb8b22ff79972d8b27fed18c06151cd399e6455bcfee87c241412cc4ead1b5::wild_coin::WildVault, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xfefb8b22ff79972d8b27fed18c06151cd399e6455bcfee87c241412cc4ead1b5::wild_coin::WILD_COIN>(&arg3) == 10, 5);
        let v0 = 0x2::table::borrow<u64, AnimalInfo>(&arg0.animal_infos, arg1);
        let v1 = AnimalNFT{
            id          : 0x2::object::new(arg11),
            name        : v0.name,
            animal_id   : arg1,
            species     : v0.species,
            habitat     : v0.habitat,
            adopted_by  : 0x2::tx_context::sender(arg11),
            image_url   : v0.image_url,
            create_time : 0x2::clock::timestamp_ms(arg5),
        };
        0xfefb8b22ff79972d8b27fed18c06151cd399e6455bcfee87c241412cc4ead1b5::wild_coin::deposit_sui_to_lending_platform(arg5, arg6, arg7, arg8, 0xfefb8b22ff79972d8b27fed18c06151cd399e6455bcfee87c241412cc4ead1b5::wild_coin::withdraw_sui_from_vault(arg8, 10, arg11), arg9, arg10);
        0xfefb8b22ff79972d8b27fed18c06151cd399e6455bcfee87c241412cc4ead1b5::wild_coin::deposit_wild_coin(arg8, arg3);
        if (!0x2::linked_table::contains<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg2.record, arg1)) {
            let v2 = 0x2::linked_table::new<0x2::object::ID, u64>(arg11);
            0x2::linked_table::push_back<0x2::object::ID, u64>(&mut v2, 0x2::object::id<AnimalNFT>(&v1), v1.create_time);
            0x2::linked_table::push_back<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&mut arg2.record, arg1, v2);
        } else {
            0x2::linked_table::push_back<0x2::object::ID, u64>(0x2::linked_table::borrow_mut<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&mut arg2.record, arg1), 0x2::object::id<AnimalNFT>(&v1), 0x2::clock::timestamp_ms(arg5));
        };
        let v3 = NFTMinted{
            object_id : 0x2::object::id<AnimalNFT>(&v1),
            creator   : 0x2::tx_context::sender(arg11),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<AnimalNFT>(v1, arg4);
    }

    public entry fun get_airdrop(arg0: &mut AnimalNFT, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer::public_receive<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, arg1), 0x2::tx_context::sender(arg2));
    }

    public fun get_all_animal_infos(arg0: &Animals) : &0x2::table::Table<u64, AnimalInfo> {
        &arg0.animal_infos
    }

    fun init(arg0: WILD_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTAdminCap{id: 0x2::object::new(arg1)};
        let v1 = Animals{
            id           : 0x2::object::new(arg1),
            animal_infos : 0x2::table::new<u64, AnimalInfo>(arg1),
        };
        let v2 = MintRecord{
            id     : 0x2::object::new(arg1),
            record : 0x2::linked_table::new<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(arg1),
        };
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"species"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"habitat"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"status"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"adopted_by"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"creator"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{nft.name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{nft.species}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{nft.habitat}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{nft.status}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{nft.adopted_by}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{nft.image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{ctx.sender()}"));
        let v7 = 0x2::package::claim<WILD_NFT>(arg0, arg1);
        let v8 = 0x2::display::new_with_fields<AnimalNFT>(&v7, v3, v5, arg1);
        0x2::display::update_version<AnimalNFT>(&mut v8);
        0x2::transfer::public_transfer<0x2::display::Display<AnimalNFT>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintRecord>(v2);
        0x2::transfer::share_object<Animals>(v1);
        0x2::transfer::transfer<NFTAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun update_animal_info(arg0: &NFTAdminCap, arg1: &mut Animals, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, AnimalInfo>(&arg1.animal_infos, arg2), 1);
        let v0 = 0x2::table::borrow_mut<u64, AnimalInfo>(&mut arg1.animal_infos, arg2);
        v0.name = arg3;
        v0.species = arg4;
        v0.habitat = arg5;
        v0.status = arg6;
        v0.image_url = arg7;
    }

    // decompiled from Move bytecode v6
}

