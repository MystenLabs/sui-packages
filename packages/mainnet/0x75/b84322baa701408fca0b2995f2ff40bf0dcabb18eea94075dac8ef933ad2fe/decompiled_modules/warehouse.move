module 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CardTemplate has copy, drop, store {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x1::string::String,
        metadata: 0x1::string::String,
        max_supply: u64,
        current_supply: u64,
    }

    struct CardPackTemplate has copy, drop, store {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x1::string::String,
        metadata: 0x1::string::String,
        max_supply: u64,
        current_supply: u64,
        unopened_pack_count: u64,
        cards_per_pack: u64,
        card_templates_and_weights: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        total_weight: u64,
        open_until: u64,
        linked_pack_template_ids: vector<0x2::object::ID>,
    }

    struct Warehouse has key {
        id: 0x2::object::UID,
        version: u64,
        card_templates: 0x2::vec_map::VecMap<0x2::object::ID, CardTemplate>,
        card_pack_templates: 0x2::vec_map::VecMap<0x2::object::ID, CardPackTemplate>,
        revoked_admincap_objs: 0x2::vec_map::VecMap<0x2::object::ID, bool>,
    }

    public fun add_card_template_to_pack(arg0: &AdminCap, arg1: &mut Warehouse, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64) {
        assert!(is_admincap_valid(arg1, arg0), 10002);
        assert!(arg4 > 0, 3);
        assert!(0x2::vec_map::contains<0x2::object::ID, CardPackTemplate>(&arg1.card_pack_templates, &arg2), 4);
        assert!(0x2::vec_map::contains<0x2::object::ID, CardTemplate>(&arg1.card_templates, &arg3), 4);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, CardPackTemplate>(&mut arg1.card_pack_templates, &arg2);
        if (0x2::vec_map::contains<0x2::object::ID, u64>(&v0.card_templates_and_weights, &arg3)) {
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut v0.card_templates_and_weights, &arg3) = arg4;
        } else {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v0.card_templates_and_weights, arg3, arg4);
        };
        update_pack_template_total_weight(v0);
    }

    public fun add_linked_pack_template(arg0: &AdminCap, arg1: &mut Warehouse, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(is_admincap_valid(arg1, arg0), 10002);
        assert!(0x2::vec_map::contains<0x2::object::ID, CardPackTemplate>(&arg1.card_pack_templates, &arg2), 4);
        assert!(0x2::vec_map::contains<0x2::object::ID, CardPackTemplate>(&arg1.card_pack_templates, &arg3), 4);
        assert!(arg2 != arg3, 10003);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, CardPackTemplate>(&mut arg1.card_pack_templates, &arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0.linked_pack_template_ids)) {
            assert!(*0x1::vector::borrow<0x2::object::ID>(&v0.linked_pack_template_ids, v1) != arg3, 10004);
            v1 = v1 + 1;
        };
        0x1::vector::push_back<0x2::object::ID>(&mut v0.linked_pack_template_ids, arg3);
    }

    public(friend) fun borrow_card_pack_template(arg0: &mut Warehouse, arg1: 0x2::object::ID) : &mut CardPackTemplate {
        assert!(0x2::vec_map::contains<0x2::object::ID, CardPackTemplate>(&arg0.card_pack_templates, &arg1), 4);
        0x2::vec_map::get_mut<0x2::object::ID, CardPackTemplate>(&mut arg0.card_pack_templates, &arg1)
    }

    public(friend) fun borrow_card_template(arg0: &mut Warehouse, arg1: 0x2::object::ID) : &mut CardTemplate {
        assert!(0x2::vec_map::contains<0x2::object::ID, CardTemplate>(&arg0.card_templates, &arg1), 4);
        0x2::vec_map::get_mut<0x2::object::ID, CardTemplate>(&mut arg0.card_templates, &arg1)
    }

    public fun create_admin_cap(arg0: &SuperAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public fun create_card_pack_template(arg0: &AdminCap, arg1: &mut Warehouse, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(is_admincap_valid(arg1, arg0), 10002);
        assert!(arg8 > 0, 2);
        let v0 = 0x2::object::new(arg10);
        let v1 = 0x2::object::id_from_address(0x2::object::uid_to_address(&v0));
        0x2::object::delete(v0);
        let v2 = CardPackTemplate{
            id                         : v1,
            name                       : arg2,
            description                : arg3,
            image_url                  : arg4,
            url                        : arg5,
            metadata                   : arg6,
            max_supply                 : arg7,
            current_supply             : 0,
            unopened_pack_count        : 0,
            cards_per_pack             : arg8,
            card_templates_and_weights : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            total_weight               : 0,
            open_until                 : arg9,
            linked_pack_template_ids   : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::vec_map::insert<0x2::object::ID, CardPackTemplate>(&mut arg1.card_pack_templates, v1, v2);
        v1
    }

    public fun create_card_template(arg0: &AdminCap, arg1: &mut Warehouse, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(is_admincap_valid(arg1, arg0), 10002);
        let v0 = 0x2::object::new(arg8);
        let v1 = 0x2::object::id_from_address(0x2::object::uid_to_address(&v0));
        0x2::object::delete(v0);
        let v2 = CardTemplate{
            id             : v1,
            name           : arg2,
            description    : arg3,
            image_url      : arg4,
            url            : arg5,
            metadata       : arg6,
            max_supply     : arg7,
            current_supply : 0,
        };
        0x2::vec_map::insert<0x2::object::ID, CardTemplate>(&mut arg1.card_templates, v1, v2);
        v1
    }

    public(friend) fun decrement_pack_template_unopened_pack_count(arg0: &mut CardPackTemplate, arg1: u64) {
        assert!(arg0.unopened_pack_count >= arg1, 10001);
        arg0.unopened_pack_count = arg0.unopened_pack_count - arg1;
    }

    public fun delete_card_pack_template(arg0: &AdminCap, arg1: &mut Warehouse, arg2: 0x2::object::ID) {
        assert!(is_admincap_valid(arg1, arg0), 10002);
        assert!(0x2::vec_map::contains<0x2::object::ID, CardPackTemplate>(&arg1.card_pack_templates, &arg2), 4);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, CardPackTemplate>(&mut arg1.card_pack_templates, &arg2);
    }

    public fun delete_card_template(arg0: &AdminCap, arg1: &mut Warehouse, arg2: 0x2::object::ID) {
        assert!(is_admincap_valid(arg1, arg0), 10002);
        assert!(0x2::vec_map::contains<0x2::object::ID, CardTemplate>(&arg1.card_templates, &arg2), 4);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, CardTemplate>(&mut arg1.card_templates, &arg2);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 < 0x2::vec_map::size<0x2::object::ID, CardPackTemplate>(&arg1.card_pack_templates)) {
            let (v4, _) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, CardPackTemplate>(&arg1.card_pack_templates, v3);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, *v4);
            v3 = v3 + 1;
        };
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x2::object::ID>(&v2)) {
            let v7 = 0x2::vec_map::get_mut<0x2::object::ID, CardPackTemplate>(&mut arg1.card_pack_templates, 0x1::vector::borrow<0x2::object::ID>(&v2, v6));
            if (0x2::vec_map::contains<0x2::object::ID, u64>(&v7.card_templates_and_weights, &arg2)) {
                let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut v7.card_templates_and_weights, &arg2);
                update_pack_template_total_weight(v7);
            };
            v6 = v6 + 1;
        };
    }

    public(friend) fun get_linked_pack_template_ids(arg0: &CardPackTemplate) : &vector<0x2::object::ID> {
        &arg0.linked_pack_template_ids
    }

    public(friend) fun get_next_id_for_template(arg0: &CardTemplate) : u64 {
        arg0.current_supply + 1
    }

    public(friend) fun get_pack_template_card_templates_and_weights(arg0: &CardPackTemplate) : &0x2::vec_map::VecMap<0x2::object::ID, u64> {
        &arg0.card_templates_and_weights
    }

    public(friend) fun get_pack_template_cards_per_pack(arg0: &CardPackTemplate) : u64 {
        arg0.cards_per_pack
    }

    public(friend) fun get_pack_template_current_supply(arg0: &CardPackTemplate) : u64 {
        arg0.current_supply
    }

    public(friend) fun get_pack_template_description(arg0: &CardPackTemplate) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun get_pack_template_id(arg0: &CardPackTemplate) : 0x2::object::ID {
        arg0.id
    }

    public(friend) fun get_pack_template_image_url(arg0: &CardPackTemplate) : 0x1::string::String {
        arg0.image_url
    }

    public(friend) fun get_pack_template_max_supply(arg0: &CardPackTemplate) : u64 {
        arg0.max_supply
    }

    public(friend) fun get_pack_template_metadata(arg0: &CardPackTemplate) : 0x1::string::String {
        arg0.metadata
    }

    public(friend) fun get_pack_template_name(arg0: &CardPackTemplate) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun get_pack_template_open_until(arg0: &CardPackTemplate) : u64 {
        arg0.open_until
    }

    public(friend) fun get_pack_template_total_weight(arg0: &CardPackTemplate) : u64 {
        arg0.total_weight
    }

    public(friend) fun get_pack_template_unopened_pack_count(arg0: &CardPackTemplate) : u64 {
        arg0.unopened_pack_count
    }

    public(friend) fun get_pack_template_url(arg0: &CardPackTemplate) : 0x1::string::String {
        arg0.url
    }

    public(friend) fun get_template_current_supply(arg0: &CardTemplate) : u64 {
        arg0.current_supply
    }

    public(friend) fun get_template_description(arg0: &CardTemplate) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun get_template_image_url(arg0: &CardTemplate) : 0x1::string::String {
        arg0.image_url
    }

    public(friend) fun get_template_max_supply(arg0: &CardTemplate) : u64 {
        arg0.max_supply
    }

    public(friend) fun get_template_metadata(arg0: &CardTemplate) : 0x1::string::String {
        arg0.metadata
    }

    public(friend) fun get_template_name(arg0: &CardTemplate) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun get_template_url(arg0: &CardTemplate) : 0x1::string::String {
        arg0.url
    }

    public(friend) fun increment_pack_template_counter(arg0: &mut CardPackTemplate) {
        if (arg0.max_supply > 0) {
            assert!(arg0.current_supply < arg0.max_supply, 6);
        };
        arg0.current_supply = arg0.current_supply + 1;
    }

    public(friend) fun increment_pack_template_unopened_pack_count(arg0: &mut CardPackTemplate, arg1: u64) {
        arg0.unopened_pack_count = arg0.unopened_pack_count + arg1;
    }

    public(friend) fun increment_template_counter(arg0: &mut CardTemplate) {
        if (arg0.max_supply > 0) {
            assert!(arg0.current_supply < arg0.max_supply, 6);
        };
        arg0.current_supply = arg0.current_supply + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdminCap{id: 0x2::object::new(arg0)};
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = Warehouse{
            id                    : 0x2::object::new(arg0),
            version               : 1,
            card_templates        : 0x2::vec_map::empty<0x2::object::ID, CardTemplate>(),
            card_pack_templates   : 0x2::vec_map::empty<0x2::object::ID, CardPackTemplate>(),
            revoked_admincap_objs : 0x2::vec_map::empty<0x2::object::ID, bool>(),
        };
        0x2::transfer::transfer<SuperAdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Warehouse>(v2);
    }

    public fun is_admincap_valid(arg0: &Warehouse, arg1: &AdminCap) : bool {
        let v0 = 0x2::object::id<AdminCap>(arg1);
        !0x2::vec_map::contains<0x2::object::ID, bool>(&arg0.revoked_admincap_objs, &v0)
    }

    public fun remove_card_template_from_pack(arg0: &AdminCap, arg1: &mut Warehouse, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(is_admincap_valid(arg1, arg0), 10002);
        assert!(0x2::vec_map::contains<0x2::object::ID, CardPackTemplate>(&arg1.card_pack_templates, &arg2), 4);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, CardPackTemplate>(&mut arg1.card_pack_templates, &arg2);
        if (0x2::vec_map::contains<0x2::object::ID, u64>(&v0.card_templates_and_weights, &arg3)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut v0.card_templates_and_weights, &arg3);
            update_pack_template_total_weight(v0);
        };
    }

    public fun remove_linked_pack_template(arg0: &AdminCap, arg1: &mut Warehouse, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(is_admincap_valid(arg1, arg0), 10002);
        assert!(0x2::vec_map::contains<0x2::object::ID, CardPackTemplate>(&arg1.card_pack_templates, &arg2), 4);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, CardPackTemplate>(&mut arg1.card_pack_templates, &arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0.linked_pack_template_ids)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&v0.linked_pack_template_ids, v1) == arg3) {
                0x1::vector::remove<0x2::object::ID>(&mut v0.linked_pack_template_ids, v1);
                return
            };
            v1 = v1 + 1;
        };
    }

    public fun revoke_admin_cap(arg0: &SuperAdminCap, arg1: &mut Warehouse, arg2: 0x2::object::ID) {
        0x2::vec_map::insert<0x2::object::ID, bool>(&mut arg1.revoked_admincap_objs, arg2, true);
    }

    public fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun update_card_pack_template(arg0: &AdminCap, arg1: &mut Warehouse, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64) {
        assert!(is_admincap_valid(arg1, arg0), 10002);
        assert!(0x2::vec_map::contains<0x2::object::ID, CardPackTemplate>(&arg1.card_pack_templates, &arg2), 4);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, CardPackTemplate>(&mut arg1.card_pack_templates, &arg2);
        v0.name = arg3;
        v0.description = arg4;
        v0.image_url = arg5;
        v0.url = arg6;
        v0.metadata = arg7;
        v0.open_until = arg8;
        v0.max_supply = arg9;
        v0.cards_per_pack = arg10;
    }

    public fun update_card_template(arg0: &AdminCap, arg1: &mut Warehouse, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64) {
        assert!(is_admincap_valid(arg1, arg0), 10002);
        assert!(0x2::vec_map::contains<0x2::object::ID, CardTemplate>(&arg1.card_templates, &arg2), 4);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, CardTemplate>(&mut arg1.card_templates, &arg2);
        v0.name = arg3;
        v0.description = arg4;
        v0.image_url = arg5;
        v0.url = arg6;
        v0.metadata = arg7;
        v0.max_supply = arg8;
    }

    fun update_pack_template_total_weight(arg0: &mut CardPackTemplate) {
        let v0 = &arg0.card_templates_and_weights;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x2::vec_map::size<0x2::object::ID, u64>(v0)) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u64>(v0, v2);
            v1 = v1 + *v4;
            v2 = v2 + 1;
        };
        arg0.total_weight = v1;
    }

    // decompiled from Move bytecode v6
}

