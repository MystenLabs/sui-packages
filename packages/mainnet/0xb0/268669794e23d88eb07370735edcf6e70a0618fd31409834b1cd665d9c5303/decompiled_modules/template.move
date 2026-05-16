module 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    struct RoyaltyRule has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig has copy, drop, store {
        bps: u16,
        min_amount_mist: u64,
    }

    struct FormTemplate has store, key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        category: u8,
        schema: vector<u8>,
        theme: vector<u8>,
        preview_blob_id: 0x1::option::Option<vector<u8>>,
        tags: vector<0x1::string::String>,
        created_at_ms: u64,
        clone_count: u64,
    }

    struct PlatformTreasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PlatformAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TemplateListing has key {
        id: 0x2::object::UID,
        template_id: address,
        creator: address,
        price_mist: u64,
    }

    public fun id_address(arg0: &FormTemplate) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun schema(arg0: &FormTemplate) : &vector<u8> {
        &arg0.schema
    }

    public fun theme(arg0: &FormTemplate) : &vector<u8> {
        &arg0.theme
    }

    fun add_royalty_rule_internal(arg0: &mut 0x2::transfer_policy::TransferPolicy<FormTemplate>, arg1: &0x2::transfer_policy::TransferPolicyCap<FormTemplate>, arg2: u16, arg3: u64) {
        let v0 = RoyaltyRule{dummy_field: false};
        let v1 = RoyaltyConfig{
            bps             : arg2,
            min_amount_mist : arg3,
        };
        0x2::transfer_policy::add_rule<FormTemplate, RoyaltyRule, RoyaltyConfig>(v0, arg0, arg1, v1);
    }

    public fun category(arg0: &FormTemplate) : u8 {
        arg0.category
    }

    public fun clone_count(arg0: &FormTemplate) : u64 {
        arg0.clone_count
    }

    public fun clone_free(arg0: &mut FormTemplate, arg1: 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::FormSettings, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap) {
        let (v0, v1) = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::mint_from_template(0x2::tx_context::sender(arg4), arg2, arg0.schema, arg0.theme, arg1, 0x2::clock::timestamp_ms(arg3), arg4);
        let v2 = v0;
        arg0.clone_count = arg0.clone_count + 1;
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_template_cloned(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_template_cloned(0x2::object::uid_to_address(&arg0.id), 0x2::tx_context::sender(arg4), 0, 0, 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(&v2)));
        (v2, v1)
    }

    public fun clone_free_and_share(arg0: &mut FormTemplate, arg1: 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::FormSettings, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = clone_free(arg0, arg1, arg2, arg3, arg4);
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::share(v0);
        0x2::transfer::public_transfer<0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun clone_paid(arg0: &mut FormTemplate, arg1: &TemplateListing, arg2: &mut PlatformTreasury, arg3: &0x2::transfer_policy::TransferPolicy<FormTemplate>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::FormSettings, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap) {
        assert!(arg1.template_id == 0x2::object::uid_to_address(&arg0.id), 6);
        let v0 = arg1.price_mist;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v0, 7);
        let v1 = RoyaltyRule{dummy_field: false};
        let v2 = royalty_due(0x2::transfer_policy::get_rule<FormTemplate, RoyaltyRule, RoyaltyConfig>(v1, arg3), v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg1.creator);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        let (v3, v4) = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::mint_from_template(0x2::tx_context::sender(arg9), arg7, arg0.schema, arg0.theme, arg6, 0x2::clock::timestamp_ms(arg8), arg9);
        let v5 = v3;
        arg0.clone_count = arg0.clone_count + 1;
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_template_cloned(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_template_cloned(0x2::object::uid_to_address(&arg0.id), 0x2::tx_context::sender(arg9), v0, v2, 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(&v5)));
        (v5, v4)
    }

    public fun clone_paid_and_share(arg0: &mut FormTemplate, arg1: &TemplateListing, arg2: &mut PlatformTreasury, arg3: &0x2::transfer_policy::TransferPolicy<FormTemplate>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::FormSettings, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = clone_paid(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::share(v0);
        0x2::transfer::public_transfer<0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap>(v1, 0x2::tx_context::sender(arg9));
    }

    public fun create_listing(arg0: &FormTemplate, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : TemplateListing {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 5);
        assert!(arg1 > 0, 4);
        TemplateListing{
            id          : 0x2::object::new(arg2),
            template_id : 0x2::object::uid_to_address(&arg0.id),
            creator     : arg0.creator,
            price_mist  : arg1,
        }
    }

    public fun create_listing_and_share(arg0: &FormTemplate, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<TemplateListing>(create_listing(arg0, arg1, arg2));
    }

    public fun creator(arg0: &FormTemplate) : address {
        arg0.creator
    }

    public fun description(arg0: &FormTemplate) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TEMPLATE>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<FormTemplate>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        add_royalty_rule_internal(v5, &v3, 1000, 50000000);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<FormTemplate>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<FormTemplate>>(v3, 0x2::tx_context::sender(arg1));
        let v6 = PlatformTreasury{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<PlatformTreasury>(v6);
        let v7 = PlatformAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<PlatformAdminCap>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun listing_creator(arg0: &TemplateListing) : address {
        arg0.creator
    }

    public fun listing_price_mist(arg0: &TemplateListing) : u64 {
        arg0.price_mist
    }

    public fun listing_template_id(arg0: &TemplateListing) : address {
        arg0.template_id
    }

    public fun place_and_list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: FormTemplate, arg3: u64) {
        assert!(arg3 > 0, 4);
        0x2::kiosk::place<FormTemplate>(arg0, arg1, arg2);
        0x2::kiosk::list<FormTemplate>(arg0, arg1, 0x2::object::id<FormTemplate>(&arg2), arg3);
    }

    public fun platform_balance(arg0: &PlatformTreasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun platform_min_royalty_mist() : u64 {
        50000000
    }

    public fun platform_royalty_bps() : u16 {
        1000
    }

    public fun publish_template(arg0: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: 0x1::option::Option<vector<u8>>, arg6: vector<0x1::string::String>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : FormTemplate {
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::assert_for(arg0, 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(arg1));
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::object::new(arg8);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = FormTemplate{
            id              : v1,
            creator         : v2,
            title           : arg2,
            description     : arg3,
            category        : arg4,
            schema          : *0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::schema(arg1),
            theme           : *0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::theme(arg1),
            preview_blob_id : arg5,
            tags            : arg6,
            created_at_ms   : v0,
            clone_count     : 0,
        };
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_template_published(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_template_published(0x2::object::uid_to_address(&v1), v2, v3.title, arg4, v0));
        v3
    }

    public fun purchase_template(arg0: &mut 0x2::kiosk::Kiosk, arg1: address, arg2: &mut 0x2::transfer_policy::TransferPolicy<FormTemplate>, arg3: &mut PlatformTreasury, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::FormSettings, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        let (v1, v2) = 0x2::kiosk::purchase<FormTemplate>(arg0, 0x2::object::id_from_address(arg1), arg4);
        let v3 = v2;
        let v4 = RoyaltyRule{dummy_field: false};
        let v5 = royalty_due(0x2::transfer_policy::get_rule<FormTemplate, RoyaltyRule, RoyaltyConfig>(v4, arg2), v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v5, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        let v6 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<FormTemplate, RoyaltyRule>(v6, &mut v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<FormTemplate>(arg2, v3);
        let FormTemplate {
            id              : v10,
            creator         : _,
            title           : _,
            description     : _,
            category        : _,
            schema          : v15,
            theme           : v16,
            preview_blob_id : _,
            tags            : _,
            created_at_ms   : _,
            clone_count     : _,
        } = v1;
        let v21 = v10;
        0x2::object::delete(v21);
        let (v22, v23) = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::mint_from_template(0x2::tx_context::sender(arg9), arg7, v15, v16, arg6, 0x2::clock::timestamp_ms(arg8), arg9);
        let v24 = v22;
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_template_cloned(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_template_cloned(0x2::object::uid_to_address(&v21), 0x2::tx_context::sender(arg9), v0, v5, 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(&v24)));
        (v24, v23)
    }

    public fun purchase_template_and_share(arg0: &mut 0x2::kiosk::Kiosk, arg1: address, arg2: &mut 0x2::transfer_policy::TransferPolicy<FormTemplate>, arg3: &mut PlatformTreasury, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::FormSettings, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = purchase_template(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::share(v0);
        0x2::transfer::public_transfer<0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap>(v1, 0x2::tx_context::sender(arg9));
    }

    public fun purchase_template_only(arg0: &mut FormTemplate, arg1: &TemplateListing, arg2: &mut PlatformTreasury, arg3: &0x2::transfer_policy::TransferPolicy<FormTemplate>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.template_id == 0x2::object::uid_to_address(&arg0.id), 6);
        let v0 = arg1.price_mist;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v0, 7);
        let v1 = RoyaltyRule{dummy_field: false};
        let v2 = royalty_due(0x2::transfer_policy::get_rule<FormTemplate, RoyaltyRule, RoyaltyConfig>(v1, arg3), v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg1.creator);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        arg0.clone_count = arg0.clone_count + 1;
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_template_cloned(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_template_cloned(0x2::object::uid_to_address(&arg0.id), 0x2::tx_context::sender(arg7), v0, v2, @0x0));
    }

    public fun record_free_clone(arg0: &mut FormTemplate, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        arg0.clone_count = arg0.clone_count + 1;
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_template_cloned(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_template_cloned(0x2::object::uid_to_address(&arg0.id), 0x2::tx_context::sender(arg2), 0, 0, @0x0));
    }

    fun royalty_due(arg0: &RoyaltyConfig, arg1: u64) : u64 {
        let v0 = (((arg1 as u128) * (arg0.bps as u128) / 10000) as u64);
        if (v0 < arg0.min_amount_mist) {
            arg0.min_amount_mist
        } else {
            v0
        }
    }

    public fun tags(arg0: &FormTemplate) : &vector<0x1::string::String> {
        &arg0.tags
    }

    public fun title(arg0: &FormTemplate) : &0x1::string::String {
        &arg0.title
    }

    public fun update_listing_price(arg0: &mut TemplateListing, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 5);
        assert!(arg1 > 0, 4);
        arg0.price_mist = arg1;
    }

    public fun withdraw_platform(arg0: &PlatformAdminCap, arg1: &mut PlatformTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_platform_withdrawn(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_platform_withdrawn(0x2::tx_context::sender(arg3), arg2));
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

