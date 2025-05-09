module 0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_NFT {
    struct WILD_NFT has drop {
        dummy_field: bool,
    }

    struct Animals has store, key {
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

    struct MintRecord has store, key {
        id: 0x2::object::UID,
        record: 0x2::linked_table::LinkedTable<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>,
        count: u64,
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

    public fun abandon_adoption(arg0: &0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::version::Version, arg1: &mut 0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::market::Market, arg2: AnimalNFT, arg3: &mut 0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::WildVault, arg4: &mut MintRecord, arg5: &0x2::clock::Clock, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTAbandoned{
            name         : arg2.name,
            species      : arg2.species,
            habitat      : arg2.habitat,
            abandoned_by : 0x2::tx_context::sender(arg7),
            image_url    : arg2.image_url,
        };
        0x2::event::emit<NFTAbandoned>(v0);
        let v1 = arg2.animal_id;
        if (0x2::linked_table::contains<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg4.record, v1)) {
            let v2 = 0x2::linked_table::borrow_mut<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&mut arg4.record, v1);
            0x2::linked_table::remove<0x2::object::ID, u64>(v2, 0x2::object::id<AnimalNFT>(&arg2));
            if (0x2::linked_table::is_empty<0x2::object::ID, u64>(v2)) {
                0x2::linked_table::drop<0x2::object::ID, u64>(0x2::linked_table::remove<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&mut arg4.record, v1));
            };
        };
        arg4.count = arg4.count - 1;
        0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::withdraw_sui_from_lending_platform(arg0, arg1, 0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::withdraw_scoin_from_vault(arg3, 0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::calc_coin_to_scoin(arg0, arg1, 0x1::type_name::get<0x2::sui::SUI>(), arg5, 10), arg7), arg5, arg3, arg7);
        let AnimalNFT {
            id          : v3,
            name        : _,
            animal_id   : _,
            species     : _,
            habitat     : _,
            adopted_by  : _,
            image_url   : _,
            create_time : _,
        } = arg2;
        0x2::object::delete(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::WILD_COIN>>(0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::withdraw_wild_coin_from_vault(arg3, 10, arg7), arg6);
    }

    public fun calculate_send_airdrop_distribution(arg0: &NFTAdminCap, arg1: &0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::version::Version, arg2: &mut 0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::market::Market, arg3: &MintRecord, arg4: &Animals, arg5: &mut 0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::WildVault, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x2::linked_table::new<0x2::object::ID, u64>(arg7);
        let v3 = 0x2::linked_table::front<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg3.record);
        let v4 = 0x2::linked_table::new<0x2::object::ID, Nft_weight>(arg7);
        while (0x1::option::is_some<u64>(v3)) {
            let v5 = 0x1::option::borrow<u64>(v3);
            let v6 = 0x2::linked_table::borrow<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg3.record, *v5);
            let v7 = 0x2::table::borrow<u64, AnimalInfo>(&arg4.animal_infos, *v5).status;
            let v8 = 0x2::linked_table::front<0x2::object::ID, u64>(v6);
            while (0x1::option::is_some<0x2::object::ID>(v8)) {
                let v9 = 0x1::option::borrow<0x2::object::ID>(v8);
                let v10 = (0x2::clock::timestamp_ms(arg6) - *0x2::linked_table::borrow<0x2::object::ID, u64>(v6, *v9)) / 86400000 + 1;
                v0 = v0 + v7;
                v1 = v1 + v10;
                let v11 = Nft_weight{
                    status_weight : v7,
                    time_weight   : v10,
                };
                0x2::linked_table::push_back<0x2::object::ID, Nft_weight>(&mut v4, *v9, v11);
                v8 = 0x2::linked_table::next<0x2::object::ID, u64>(v6, *v9);
            };
            v3 = 0x2::linked_table::next<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg3.record, *v5);
        };
        assert!(v0 > 0, 1);
        assert!(v1 > 0, 2);
        let v12 = 0x2::linked_table::front<0x2::object::ID, Nft_weight>(&v4);
        while (0x1::option::is_some<0x2::object::ID>(v12)) {
            let v13 = 0x1::option::borrow<0x2::object::ID>(v12);
            let v14 = 0x2::linked_table::borrow<0x2::object::ID, Nft_weight>(&v4, *v13);
            0x2::linked_table::push_back<0x2::object::ID, u64>(&mut v2, *v13, v14.status_weight * 1000000000 / v0 * 8 / 10 + v14.time_weight * 1000000000 / v1 * 2 / 10);
            v12 = 0x2::linked_table::next<0x2::object::ID, Nft_weight>(&v4, *v13);
        };
        0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::distribute_airdrop(arg1, arg2, arg6, &v2, arg3.count, 10, arg5, arg7);
        0x2::linked_table::drop<0x2::object::ID, u64>(v2);
        0x2::linked_table::drop<0x2::object::ID, Nft_weight>(v4);
    }

    public fun create_animal_info(arg0: &NFTAdminCap, arg1: &mut Animals, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
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

    public fun fund_and_purchase_nft(arg0: &0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::version::Version, arg1: &mut 0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::market::Market, arg2: &Animals, arg3: u64, arg4: &mut MintRecord, arg5: 0x2::coin::Coin<0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::WILD_COIN>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::WildVault, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::WILD_COIN>(&arg5) == 10, 5);
        let v0 = 0x2::table::borrow<u64, AnimalInfo>(&arg2.animal_infos, arg3);
        let v1 = AnimalNFT{
            id          : 0x2::object::new(arg9),
            name        : v0.name,
            animal_id   : arg3,
            species     : v0.species,
            habitat     : v0.habitat,
            adopted_by  : 0x2::tx_context::sender(arg9),
            image_url   : v0.image_url,
            create_time : 0x2::clock::timestamp_ms(arg7),
        };
        0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::deposit_sui_to_lending_platform(arg0, arg1, 0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::withdraw_sui_from_vault(arg8, 10, arg9), arg7, arg8, arg9);
        0x2912b34a2f332944794755f0f2ab5aa8814c2714b03df340f3ac3bb7d9e7d417::wild_coin::deposit_wild_coin(arg8, arg5);
        if (!0x2::linked_table::contains<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg4.record, arg3)) {
            let v2 = 0x2::linked_table::new<0x2::object::ID, u64>(arg9);
            0x2::linked_table::push_back<0x2::object::ID, u64>(&mut v2, 0x2::object::id<AnimalNFT>(&v1), v1.create_time);
            0x2::linked_table::push_back<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&mut arg4.record, arg3, v2);
        } else {
            0x2::linked_table::push_back<0x2::object::ID, u64>(0x2::linked_table::borrow_mut<u64, 0x2::linked_table::LinkedTable<0x2::object::ID, u64>>(&mut arg4.record, arg3), 0x2::object::id<AnimalNFT>(&v1), 0x2::clock::timestamp_ms(arg7));
        };
        arg4.count = arg4.count + 1;
        let v3 = NFTMinted{
            object_id : 0x2::object::id<AnimalNFT>(&v1),
            creator   : 0x2::tx_context::sender(arg9),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<AnimalNFT>(v1, arg6);
    }

    public fun get_airdrop(arg0: &mut AnimalNFT, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0x2::sui::SUI>>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer::public_receive<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, arg1), arg2);
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
            count  : 0,
        };
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"species"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"habitat"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"status"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"adopted_by"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{species}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{habitat}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{status}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{adopted_by}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        let v7 = 0x2::package::claim<WILD_NFT>(arg0, arg1);
        let v8 = 0x2::display::new_with_fields<AnimalNFT>(&v7, v3, v5, arg1);
        0x2::display::update_version<AnimalNFT>(&mut v8);
        0x2::transfer::public_transfer<0x2::display::Display<AnimalNFT>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintRecord>(v2);
        0x2::transfer::share_object<Animals>(v1);
        0x2::transfer::transfer<NFTAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun update_animal_info(arg0: &NFTAdminCap, arg1: &mut Animals, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
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

