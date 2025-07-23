module 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::sales {
    struct SalePlan has store {
        id: 0x2::object::ID,
        card_pack_template_id: 0x2::object::ID,
        receiving_address: address,
        name: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        price: u64,
        max_supply: u64,
        remaining_supply: u64,
        purchase_limit_per_wallet: u64,
        has_whitelist: bool,
        purchases: 0x2::table::Table<address, u64>,
    }

    struct SalePlanManager has store, key {
        id: 0x2::object::UID,
        version: u64,
        sale_plans: 0x2::vec_map::VecMap<0x2::object::ID, SalePlan>,
    }

    struct WhitelistObject has store, key {
        id: 0x2::object::UID,
        sale_plan_ids: vector<0x2::object::ID>,
        quantity: u64,
        expired_at: u64,
    }

    public entry fun airdrop_card_packs(arg0: &0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::AdminCap, arg1: &mut 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::Warehouse, arg2: &mut SalePlanManager, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::is_admincap_valid(arg1, arg0), 30013);
        assert!(0x2::vec_map::contains<0x2::object::ID, SalePlan>(&arg2.sale_plans, &arg3), 30011);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, SalePlan>(&mut arg2.sale_plans, &arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(v1 >= v0.start_time && v1 <= v0.end_time, 30005);
        assert!(arg5 > 0, 30003);
        assert!(arg5 <= v0.remaining_supply, 30007);
        let v2 = if (0x2::table::contains<address, u64>(&v0.purchases, arg4)) {
            *0x2::table::borrow<address, u64>(&v0.purchases, arg4)
        } else {
            0
        };
        if (v0.purchase_limit_per_wallet > 0) {
            assert!(v2 + arg5 <= v0.purchase_limit_per_wallet, 30006);
        };
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg1, v0.card_pack_template_id);
        let v5 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_card_templates_and_weights(v4);
        let v6 = (arg5 + 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_unopened_pack_count(v4)) * 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_cards_per_pack(v4);
        let v7 = 0;
        while (v7 < 0x2::vec_map::size<0x2::object::ID, u64>(v5)) {
            let (v8, _) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u64>(v5, v7);
            0x1::vector::push_back<0x2::object::ID>(&mut v3, *v8);
            v7 = v7 + 1;
        };
        let v10 = 0x1::vector::empty<0x2::object::ID>();
        let v11 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_linked_pack_template_ids(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg1, v0.card_pack_template_id));
        let v12 = 0;
        while (v12 < 0x1::vector::length<0x2::object::ID>(v11)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v10, *0x1::vector::borrow<0x2::object::ID>(v11, v12));
            v12 = v12 + 1;
        };
        let v13 = 0;
        while (v13 < 0x1::vector::length<0x2::object::ID>(&v10)) {
            let v14 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg1, *0x1::vector::borrow<0x2::object::ID>(&v10, v13));
            let v15 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_card_templates_and_weights(v14);
            v6 = v6 + (arg5 + 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_unopened_pack_count(v14)) * 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_cards_per_pack(v14);
            let v16 = 0;
            while (v16 < 0x2::vec_map::size<0x2::object::ID, u64>(v15)) {
                let (v17, _) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u64>(v15, v16);
                0x1::vector::push_back<0x2::object::ID>(&mut v3, *v17);
                v16 = v16 + 1;
            };
            v13 = v13 + 1;
        };
        while (!0x1::vector::is_empty<0x2::object::ID>(&v10)) {
            0x1::vector::pop_back<0x2::object::ID>(&mut v10);
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v10);
        let v19 = 0;
        let v20 = 0;
        while (v20 < 0x1::vector::length<0x2::object::ID>(&v3)) {
            let v21 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_template(arg1, *0x1::vector::borrow<0x2::object::ID>(&v3, v20));
            let v22 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_template_max_supply(v21);
            let v23 = if (v22 == 0) {
                v6
            } else {
                v22 - 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_template_current_supply(v21)
            };
            v19 = v19 + v23;
            v20 = v20 + 1;
        };
        assert!(v19 >= v6, 30012);
        internal_mint_card_packs(arg1, v0, arg5, arg4, arg7);
    }

    public fun buy_card_packs(arg0: &mut 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::Warehouse, arg1: &mut SalePlanManager, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::option::Option<WhitelistObject>, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, SalePlan>(&arg1.sale_plans, &arg2), 30011);
        process_pack_purchase(arg0, &arg1.sale_plans, arg2, arg3, arg4, arg5, &arg6, arg7);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, SalePlan>(&mut arg1.sale_plans, &arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, arg3 * v0.price, arg7), v0.receiving_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg6);
        };
        let v1 = 0x2::tx_context::sender(arg7);
        internal_mint_card_packs(arg0, v0, arg3, v1, arg7);
    }

    fun create_pack_without_increment(arg0: &0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::CardPackTemplate, arg1: &mut 0x2::tx_context::TxContext) : 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::card_pack::Pack {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"#"));
        0x1::string::append(&mut v0, 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::u64_to_string(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_current_supply(arg0)));
        0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::card_pack::mint_pack(v0, 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_id(arg0), 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_name(arg0), 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_description(arg0), 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_image_url(arg0), 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_url(arg0), 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_metadata(arg0), 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_open_until(arg0), arg1)
    }

    public fun create_sale_plan(arg0: &0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::AdminCap, arg1: &mut 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::Warehouse, arg2: &mut SalePlanManager, arg3: 0x2::object::ID, arg4: address, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::is_admincap_valid(arg1, arg0), 30013);
        assert!(arg6 < arg7, 30002);
        assert!(arg9 > 0, 30003);
        0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg1, arg3);
        let v0 = 0x2::object::new(arg12);
        let v1 = 0x2::object::id_from_address(0x2::object::uid_to_address(&v0));
        let v2 = SalePlan{
            id                        : v1,
            card_pack_template_id     : arg3,
            receiving_address         : arg4,
            name                      : arg5,
            start_time                : arg6,
            end_time                  : arg7,
            price                     : arg8,
            max_supply                : arg9,
            remaining_supply          : arg9,
            purchase_limit_per_wallet : arg10,
            has_whitelist             : arg11,
            purchases                 : 0x2::table::new<address, u64>(arg12),
        };
        0x2::vec_map::insert<0x2::object::ID, SalePlan>(&mut arg2.sale_plans, v1, v2);
        0x2::object::delete(v0);
        v1
    }

    public fun delete_sale_plan(arg0: &0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::AdminCap, arg1: &0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::Warehouse, arg2: &mut SalePlanManager, arg3: 0x2::object::ID) {
        assert!(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::is_admincap_valid(arg1, arg0), 30013);
        assert!(0x2::vec_map::contains<0x2::object::ID, SalePlan>(&arg2.sale_plans, &arg3), 30011);
        if (0x2::vec_map::contains<0x2::object::ID, SalePlan>(&arg2.sale_plans, &arg3)) {
            let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, SalePlan>(&mut arg2.sale_plans, &arg3);
            let SalePlan {
                id                        : _,
                card_pack_template_id     : _,
                receiving_address         : _,
                name                      : _,
                start_time                : _,
                end_time                  : _,
                price                     : _,
                max_supply                : _,
                remaining_supply          : _,
                purchase_limit_per_wallet : _,
                has_whitelist             : _,
                purchases                 : v13,
            } = v1;
            0x2::table::destroy_empty<address, u64>(v13);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SalePlanManager{
            id         : 0x2::object::new(arg0),
            version    : 1,
            sale_plans : 0x2::vec_map::empty<0x2::object::ID, SalePlan>(),
        };
        0x2::transfer::public_share_object<SalePlanManager>(v0);
    }

    fun internal_mint_card_packs(arg0: &mut 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::Warehouse, arg1: &mut SalePlan, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, u64>(&arg1.purchases, arg3)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg1.purchases, arg3);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg1.purchases, arg3, arg2);
        };
        arg1.remaining_supply = arg1.remaining_supply - arg2;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_linked_pack_template_ids(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg0, arg1.card_pack_template_id));
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(v2)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, *0x1::vector::borrow<0x2::object::ID>(v2, v3));
            v3 = v3 + 1;
        };
        0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::increment_pack_template_unopened_pack_count(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg0, arg1.card_pack_template_id), arg2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::increment_pack_template_unopened_pack_count(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg0, *0x1::vector::borrow<0x2::object::ID>(&v1, v4)), arg2);
            v4 = v4 + 1;
        };
        while (!0x1::vector::is_empty<0x2::object::ID>(&v1)) {
            0x1::vector::pop_back<0x2::object::ID>(&mut v1);
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v1);
        let v5 = 0;
        while (v5 < arg2) {
            0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::increment_pack_template_counter(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg0, arg1.card_pack_template_id));
            let v6 = 0x1::vector::empty<0x2::object::ID>();
            let v7 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_linked_pack_template_ids(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg0, arg1.card_pack_template_id));
            let v8 = 0;
            while (v8 < 0x1::vector::length<0x2::object::ID>(v7)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v6, *0x1::vector::borrow<0x2::object::ID>(v7, v8));
                v8 = v8 + 1;
            };
            let v9 = 0;
            while (v9 < 0x1::vector::length<0x2::object::ID>(&v6)) {
                0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::increment_pack_template_counter(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg0, *0x1::vector::borrow<0x2::object::ID>(&v6, v9)));
                v9 = v9 + 1;
            };
            while (!0x1::vector::is_empty<0x2::object::ID>(&v6)) {
                0x1::vector::pop_back<0x2::object::ID>(&mut v6);
            };
            0x1::vector::destroy_empty<0x2::object::ID>(v6);
            v5 = v5 + 1;
        };
        let v10 = 0;
        while (v10 < arg2) {
            0x2::transfer::public_transfer<0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::card_pack::Pack>(create_pack_without_increment(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg0, arg1.card_pack_template_id), arg4), arg3);
            v10 = v10 + 1;
        };
    }

    public fun mint_whitelist_object(arg0: &0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::AdminCap, arg1: &0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::Warehouse, arg2: &mut SalePlanManager, arg3: vector<0x2::object::ID>, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::is_admincap_valid(arg1, arg0), 30013);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) > 0, 30009);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v1 = 0x1::vector::borrow<0x2::object::ID>(&arg3, v0);
            assert!(0x2::vec_map::contains<0x2::object::ID, SalePlan>(&arg2.sale_plans, v1), 30011);
            assert!(0x2::vec_map::get<0x2::object::ID, SalePlan>(&arg2.sale_plans, v1).has_whitelist, 30005);
            v0 = v0 + 1;
        };
        let v2 = WhitelistObject{
            id            : 0x2::object::new(arg7),
            sale_plan_ids : arg3,
            quantity      : arg4,
            expired_at    : arg5,
        };
        0x2::transfer::public_transfer<WhitelistObject>(v2, arg6);
        0x2::object::id<WhitelistObject>(&v2)
    }

    fun process_pack_purchase(arg0: &mut 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::Warehouse, arg1: &0x2::vec_map::VecMap<0x2::object::ID, SalePlan>, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::option::Option<WhitelistObject>, arg5: &0x2::clock::Clock, arg6: &0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::get<0x2::object::ID, SalePlan>(arg1, &arg2);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 >= v0.start_time && v1 <= v0.end_time, 30005);
        assert!(arg3 > 0, 30003);
        assert!(arg3 <= v0.remaining_supply, 30007);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg6) >= arg3 * v0.price, 30004);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = if (0x2::table::contains<address, u64>(&v0.purchases, v2)) {
            *0x2::table::borrow<address, u64>(&v0.purchases, v2)
        } else {
            0
        };
        if (v0.purchase_limit_per_wallet > 0) {
            assert!(v3 + arg3 <= v0.purchase_limit_per_wallet, 30006);
        };
        if (v0.has_whitelist) {
            if (0x1::option::is_some<WhitelistObject>(&arg4)) {
                let v4 = 0x1::option::destroy_some<WhitelistObject>(arg4);
                assert!(v4.quantity >= arg3, 30008);
                assert!(0x1::vector::contains<0x2::object::ID>(&v4.sale_plan_ids, &v0.id), 30009);
                assert!(0x2::clock::timestamp_ms(arg5) <= v4.expired_at, 30010);
                if (v4.quantity > arg3) {
                    v4.quantity = v4.quantity - arg3;
                    0x2::transfer::transfer<WhitelistObject>(v4, 0x2::tx_context::sender(arg7));
                } else {
                    0x2::object::id<WhitelistObject>(&v4);
                    let WhitelistObject {
                        id            : v5,
                        sale_plan_ids : _,
                        quantity      : _,
                        expired_at    : _,
                    } = v4;
                    0x2::object::delete(v5);
                };
            } else {
                0x1::option::destroy_none<WhitelistObject>(arg4);
                abort 30009
            };
        } else {
            0x1::option::destroy_none<WhitelistObject>(arg4);
        };
        let v9 = 0x1::vector::empty<0x2::object::ID>();
        let v10 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg0, v0.card_pack_template_id);
        let v11 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_card_templates_and_weights(v10);
        let v12 = (arg3 + 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_unopened_pack_count(v10)) * 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_cards_per_pack(v10);
        let v13 = 0;
        while (v13 < 0x2::vec_map::size<0x2::object::ID, u64>(v11)) {
            let (v14, _) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u64>(v11, v13);
            0x1::vector::push_back<0x2::object::ID>(&mut v9, *v14);
            v13 = v13 + 1;
        };
        let v16 = 0x1::vector::empty<0x2::object::ID>();
        let v17 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_linked_pack_template_ids(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg0, v0.card_pack_template_id));
        let v18 = 0;
        while (v18 < 0x1::vector::length<0x2::object::ID>(v17)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v16, *0x1::vector::borrow<0x2::object::ID>(v17, v18));
            v18 = v18 + 1;
        };
        let v19 = 0;
        while (v19 < 0x1::vector::length<0x2::object::ID>(&v16)) {
            let v20 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_pack_template(arg0, *0x1::vector::borrow<0x2::object::ID>(&v16, v19));
            let v21 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_card_templates_and_weights(v20);
            v12 = v12 + (arg3 + 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_unopened_pack_count(v20)) * 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_pack_template_cards_per_pack(v20);
            let v22 = 0;
            while (v22 < 0x2::vec_map::size<0x2::object::ID, u64>(v21)) {
                let (v23, _) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u64>(v21, v22);
                0x1::vector::push_back<0x2::object::ID>(&mut v9, *v23);
                v22 = v22 + 1;
            };
            v19 = v19 + 1;
        };
        while (!0x1::vector::is_empty<0x2::object::ID>(&v16)) {
            0x1::vector::pop_back<0x2::object::ID>(&mut v16);
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v16);
        let v25 = 0;
        let v26 = 0;
        while (v26 < 0x1::vector::length<0x2::object::ID>(&v9)) {
            let v27 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::borrow_card_template(arg0, *0x1::vector::borrow<0x2::object::ID>(&v9, v26));
            let v28 = 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_template_max_supply(v27);
            let v29 = if (v28 == 0) {
                v12
            } else {
                v28 - 0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::get_template_current_supply(v27)
            };
            v25 = v25 + v29;
            v26 = v26 + 1;
        };
        assert!(v25 >= v12, 30012);
    }

    public fun update_sale_plan(arg0: &0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::AdminCap, arg1: &0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::Warehouse, arg2: &mut SalePlanManager, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: address, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: bool) {
        assert!(0x2261155052b4e4b7e7e1ab43f40619381ded10242aa0d6e38932e88873bd4e6f::warehouse::is_admincap_valid(arg1, arg0), 30013);
        assert!(0x2::vec_map::contains<0x2::object::ID, SalePlan>(&arg2.sale_plans, &arg3), 30011);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, SalePlan>(&mut arg2.sale_plans, &arg3);
        assert!(arg9 >= 0, 30001);
        assert!(arg7 < arg8, 30002);
        assert!(arg10 >= v0.max_supply - v0.remaining_supply, 30003);
        v0.receiving_address = arg5;
        v0.name = arg6;
        v0.start_time = arg7;
        v0.end_time = arg8;
        v0.price = arg9;
        v0.remaining_supply = arg10 - v0.max_supply - v0.remaining_supply;
        v0.max_supply = arg10;
        v0.purchase_limit_per_wallet = arg11;
        v0.has_whitelist = arg12;
        v0.card_pack_template_id = arg4;
    }

    // decompiled from Move bytecode v6
}

