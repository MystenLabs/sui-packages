module 0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::dpp {
    struct DPP has drop {
        dummy_field: bool,
    }

    struct RegistryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DppAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RecallCap has store, key {
        id: 0x2::object::UID,
        product_id: 0x2::object::ID,
    }

    struct ESGData has copy, drop, store {
        schema_version: u8,
        carbon_footprint: 0x1::string::String,
        material_origin: 0x1::string::String,
        recyclability: 0x1::string::String,
        certifications: 0x1::string::String,
    }

    struct DPPData has copy, drop, store {
        schema_version: u8,
        product_type: 0x1::string::String,
        brand: 0x1::string::String,
        model: 0x1::string::String,
        serial_number: 0x1::string::String,
        manufacture_date: 0x1::string::String,
        expiration_date: 0x1::string::String,
        extra_metadata_uri: 0x1::string::String,
        content_hash: vector<u8>,
    }

    struct HistoryEvent has copy, drop, store {
        seq: u64,
        timestamp_ms: u64,
        actor: address,
        action: 0x1::string::String,
        details: 0x1::string::String,
    }

    struct RecallEntry has copy, drop, store {
        recall_type: 0x1::string::String,
        details: 0x1::string::String,
        issuer: address,
        timestamp_ms: u64,
    }

    struct Product has store, key {
        id: 0x2::object::UID,
        schema_version: u8,
        product_id: 0x1::string::String,
        dpp: DPPData,
        esg: ESGData,
        history_count: u64,
        history: 0x2::table::Table<u64, HistoryEvent>,
    }

    struct DppRegistry has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>,
        min_fee: u64,
        issued_admin_caps: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct RecallRegistry has key {
        id: 0x2::object::UID,
        recalls: 0x2::table::Table<0x2::object::ID, RecallEntry>,
    }

    struct ProductCreated has copy, drop {
        object_id: 0x2::object::ID,
        product_id: 0x1::string::String,
        product_type: 0x1::string::String,
        brand: 0x1::string::String,
        creator: address,
        schema_version: u8,
    }

    struct ProductUpdated has copy, drop {
        object_id: 0x2::object::ID,
        product_id: 0x1::string::String,
        action: 0x1::string::String,
        updater: address,
    }

    struct HistoryRecorded has copy, drop {
        object_id: 0x2::object::ID,
        product_id: 0x1::string::String,
        event_type: 0x1::string::String,
        details: 0x1::string::String,
        actor: address,
        seq: u64,
        timestamp_ms: u64,
    }

    struct FeeCollected has copy, drop {
        amount: u64,
        payer: address,
        tx_type: 0x1::string::String,
    }

    struct RecallCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        issuer: address,
    }

    struct RecallNotice has copy, drop {
        object_id: 0x2::object::ID,
        product_id: 0x1::string::String,
        recall_type: 0x1::string::String,
        details: 0x1::string::String,
        issuer: address,
        timestamp_ms: u64,
    }

    struct AdminCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        issued_to: address,
    }

    struct AdminCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct RegistryAdminTransferred has copy, drop {
        new_admin: address,
    }

    public entry fun admin_create_product(arg0: &DppAdminCap, arg1: &DppRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap_active(arg1, arg0);
        mint_product(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public entry fun admin_recall(arg0: &RegistryAdminCap, arg1: &mut RecallRegistry, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::table::contains<0x2::object::ID, RecallEntry>(&arg1.recalls, arg2), 3);
        let v1 = RecallEntry{
            recall_type  : 0x1::string::utf8(arg3),
            details      : 0x1::string::utf8(arg4),
            issuer       : v0,
            timestamp_ms : arg5,
        };
        0x2::table::add<0x2::object::ID, RecallEntry>(&mut arg1.recalls, arg2, v1);
        let v2 = RecallNotice{
            object_id    : arg2,
            product_id   : 0x1::string::utf8(b""),
            recall_type  : 0x1::string::utf8(arg3),
            details      : 0x1::string::utf8(arg4),
            issuer       : v0,
            timestamp_ms : arg5,
        };
        0x2::event::emit<RecallNotice>(v2);
    }

    public entry fun admin_update_dpp(arg0: &DppAdminCap, arg1: &DppRegistry, arg2: &mut Product, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap_active(arg1, arg0);
        mutate_dpp(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun admin_update_esg(arg0: &DppAdminCap, arg1: &DppRegistry, arg2: &mut Product, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap_active(arg1, arg0);
        mutate_esg(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun assert_admin_cap_active(arg0: &DppRegistry, arg1: &DppAdminCap) {
        let v0 = 0x2::object::id<DppAdminCap>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.issued_admin_caps, v0), 4);
        assert!(*0x2::table::borrow<0x2::object::ID, bool>(&arg0.issued_admin_caps, v0), 4);
    }

    fun collect_fee(arg0: &mut DppRegistry, arg1: 0x2::coin::Coin<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>(&arg1) >= arg0.min_fee, 1);
        0x2::balance::join<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>(&mut arg0.balance, 0x2::coin::into_balance<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>(0x2::coin::split<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>(&mut arg1, arg0.min_fee, arg3)));
        let v1 = FeeCollected{
            amount  : arg0.min_fee,
            payer   : v0,
            tx_type : 0x1::string::utf8(arg2),
        };
        0x2::event::emit<FeeCollected>(v1);
        if (0x2::coin::value<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>(arg1);
        };
    }

    public entry fun create_product(arg0: &mut DppRegistry, arg1: 0x2::coin::Coin<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        collect_fee(arg0, arg1, b"CREATE", arg16);
        mint_product(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public fun get_balance(arg0: &DppRegistry) : u64 {
        0x2::balance::value<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>(&arg0.balance)
    }

    public fun get_dpp(arg0: &Product) : &DPPData {
        &arg0.dpp
    }

    public fun get_esg(arg0: &Product) : &ESGData {
        &arg0.esg
    }

    public fun get_history_event(arg0: &Product, arg1: u64) : &HistoryEvent {
        0x2::table::borrow<u64, HistoryEvent>(&arg0.history, arg1)
    }

    public fun get_min_fee(arg0: &DppRegistry) : u64 {
        arg0.min_fee
    }

    public fun get_product_id(arg0: &Product) : &0x1::string::String {
        &arg0.product_id
    }

    public fun get_recall(arg0: &RecallRegistry, arg1: 0x2::object::ID) : &RecallEntry {
        0x2::table::borrow<0x2::object::ID, RecallEntry>(&arg0.recalls, arg1)
    }

    public fun get_schema_version(arg0: &Product) : u8 {
        arg0.schema_version
    }

    public fun history_count(arg0: &Product) : u64 {
        arg0.history_count
    }

    fun init(arg0: DPP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DPP>(arg0, arg1);
        let v1 = 0x2::display::new<Product>(&v0, arg1);
        0x2::display::add<Product>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{dpp.brand} {dpp.model}"));
        0x2::display::add<Product>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"OrigoVero Digital Product Passport ({product_id})"));
        0x2::display::add<Product>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://www.origovero.com/b2c/product/{id}"));
        0x2::display::add<Product>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://www.origovero.com/b2c/passport/{product_id}/image"));
        0x2::display::add<Product>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://www.origovero.com"));
        0x2::display::add<Product>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"OrigoVero"));
        0x2::display::update_version<Product>(&mut v1);
        let v2 = DppRegistry{
            id                : 0x2::object::new(arg1),
            balance           : 0x2::balance::zero<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>(),
            min_fee           : 10000,
            issued_admin_caps : 0x2::table::new<0x2::object::ID, bool>(arg1),
        };
        let v3 = RecallRegistry{
            id      : 0x2::object::new(arg1),
            recalls : 0x2::table::new<0x2::object::ID, RecallEntry>(arg1),
        };
        let v4 = RegistryAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<DppRegistry>(v2);
        0x2::transfer::share_object<RecallRegistry>(v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Product>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<RegistryAdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun is_admin_cap_active(arg0: &DppRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.issued_admin_caps, arg1) && *0x2::table::borrow<0x2::object::ID, bool>(&arg0.issued_admin_caps, arg1)
    }

    public fun is_recalled(arg0: &RecallRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, RecallEntry>(&arg0.recalls, arg1)
    }

    public entry fun manufacturer_recall(arg0: &mut DppRegistry, arg1: &mut RecallRegistry, arg2: &RecallCap, arg3: 0x2::coin::Coin<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        collect_fee(arg0, arg3, b"RECALL", arg7);
        let v1 = arg2.product_id;
        assert!(!0x2::table::contains<0x2::object::ID, RecallEntry>(&arg1.recalls, v1), 3);
        let v2 = RecallEntry{
            recall_type  : 0x1::string::utf8(arg4),
            details      : 0x1::string::utf8(arg5),
            issuer       : v0,
            timestamp_ms : arg6,
        };
        0x2::table::add<0x2::object::ID, RecallEntry>(&mut arg1.recalls, v1, v2);
        let v3 = RecallNotice{
            object_id    : v1,
            product_id   : 0x1::string::utf8(b""),
            recall_type  : 0x1::string::utf8(arg4),
            details      : 0x1::string::utf8(arg5),
            issuer       : v0,
            timestamp_ms : arg6,
        };
        0x2::event::emit<RecallNotice>(v3);
    }

    public entry fun mint_admin_cap(arg0: &RegistryAdminCap, arg1: &mut DppRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DppAdminCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<DppAdminCap>(&v0);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.issued_admin_caps, v1, true);
        let v2 = AdminCapIssued{
            cap_id    : v1,
            issued_to : arg2,
        };
        0x2::event::emit<AdminCapIssued>(v2);
        0x2::transfer::public_transfer<DppAdminCap>(v0, arg2);
    }

    fun mint_product(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg14);
        let v1 = DPPData{
            schema_version     : 2,
            product_type       : 0x1::string::utf8(arg1),
            brand              : 0x1::string::utf8(arg2),
            model              : 0x1::string::utf8(arg3),
            serial_number      : 0x1::string::utf8(arg4),
            manufacture_date   : 0x1::string::utf8(arg5),
            expiration_date    : 0x1::string::utf8(arg6),
            extra_metadata_uri : 0x1::string::utf8(arg7),
            content_hash       : arg8,
        };
        let v2 = ESGData{
            schema_version   : 2,
            carbon_footprint : 0x1::string::utf8(arg9),
            material_origin  : 0x1::string::utf8(arg10),
            recyclability    : 0x1::string::utf8(arg11),
            certifications   : 0x1::string::utf8(arg12),
        };
        let v3 = Product{
            id             : 0x2::object::new(arg14),
            schema_version : 2,
            product_id     : 0x1::string::utf8(arg0),
            dpp            : v1,
            esg            : v2,
            history_count  : 0,
            history        : 0x2::table::new<u64, HistoryEvent>(arg14),
        };
        let v4 = &mut v3;
        push_history(v4, arg13, v0, 0x1::string::utf8(b"CREATED"), 0x1::string::utf8(b"Initial DPP + ESG data"));
        let v5 = ProductCreated{
            object_id      : 0x2::object::id<Product>(&v3),
            product_id     : v3.product_id,
            product_type   : v3.dpp.product_type,
            brand          : v3.dpp.brand,
            creator        : v0,
            schema_version : 2,
        };
        0x2::event::emit<ProductCreated>(v5);
        let v6 = RecallCap{
            id         : 0x2::object::new(arg14),
            product_id : 0x2::object::id<Product>(&v3),
        };
        let v7 = RecallCapIssued{
            cap_id     : 0x2::object::id<RecallCap>(&v6),
            product_id : 0x2::object::id<Product>(&v3),
            issuer     : v0,
        };
        0x2::event::emit<RecallCapIssued>(v7);
        0x2::transfer::public_transfer<RecallCap>(v6, v0);
        0x2::transfer::public_transfer<Product>(v3, v0);
    }

    fun mutate_dpp(arg0: &mut Product, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        arg0.dpp.product_type = 0x1::string::utf8(arg1);
        arg0.dpp.brand = 0x1::string::utf8(arg2);
        arg0.dpp.model = 0x1::string::utf8(arg3);
        arg0.dpp.serial_number = 0x1::string::utf8(arg4);
        arg0.dpp.manufacture_date = 0x1::string::utf8(arg5);
        arg0.dpp.expiration_date = 0x1::string::utf8(arg6);
        arg0.dpp.extra_metadata_uri = 0x1::string::utf8(arg7);
        arg0.dpp.content_hash = arg8;
        let v1 = push_history(arg0, arg10, v0, 0x1::string::utf8(b"DPP_UPDATED"), 0x1::string::utf8(arg9));
        let v2 = ProductUpdated{
            object_id  : 0x2::object::id<Product>(arg0),
            product_id : arg0.product_id,
            action     : 0x1::string::utf8(b"DPP_UPDATED"),
            updater    : v0,
        };
        0x2::event::emit<ProductUpdated>(v2);
        let v3 = HistoryRecorded{
            object_id    : 0x2::object::id<Product>(arg0),
            product_id   : arg0.product_id,
            event_type   : 0x1::string::utf8(b"DPP_UPDATED"),
            details      : 0x1::string::utf8(arg9),
            actor        : v0,
            seq          : v1,
            timestamp_ms : arg10,
        };
        0x2::event::emit<HistoryRecorded>(v3);
    }

    fun mutate_esg(arg0: &mut Product, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        arg0.esg.carbon_footprint = 0x1::string::utf8(arg1);
        arg0.esg.material_origin = 0x1::string::utf8(arg2);
        arg0.esg.recyclability = 0x1::string::utf8(arg3);
        arg0.esg.certifications = 0x1::string::utf8(arg4);
        let v1 = push_history(arg0, arg6, v0, 0x1::string::utf8(b"ESG_UPDATED"), 0x1::string::utf8(arg5));
        let v2 = ProductUpdated{
            object_id  : 0x2::object::id<Product>(arg0),
            product_id : arg0.product_id,
            action     : 0x1::string::utf8(b"ESG_UPDATED"),
            updater    : v0,
        };
        0x2::event::emit<ProductUpdated>(v2);
        let v3 = HistoryRecorded{
            object_id    : 0x2::object::id<Product>(arg0),
            product_id   : arg0.product_id,
            event_type   : 0x1::string::utf8(b"ESG_UPDATED"),
            details      : 0x1::string::utf8(arg5),
            actor        : v0,
            seq          : v1,
            timestamp_ms : arg6,
        };
        0x2::event::emit<HistoryRecorded>(v3);
    }

    fun push_history(arg0: &mut Product, arg1: u64, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String) : u64 {
        let v0 = arg0.history_count;
        let v1 = HistoryEvent{
            seq          : v0,
            timestamp_ms : arg1,
            actor        : arg2,
            action       : arg3,
            details      : arg4,
        };
        0x2::table::add<u64, HistoryEvent>(&mut arg0.history, v0, v1);
        arg0.history_count = v0 + 1;
        v0
    }

    public entry fun record_event(arg0: &mut DppRegistry, arg1: &mut Product, arg2: 0x2::coin::Coin<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        collect_fee(arg0, arg2, b"RECORD_EVENT", arg6);
        let v1 = push_history(arg1, arg5, v0, 0x1::string::utf8(arg3), 0x1::string::utf8(arg4));
        let v2 = HistoryRecorded{
            object_id    : 0x2::object::id<Product>(arg1),
            product_id   : arg1.product_id,
            event_type   : 0x1::string::utf8(arg3),
            details      : 0x1::string::utf8(arg4),
            actor        : v0,
            seq          : v1,
            timestamp_ms : arg5,
        };
        0x2::event::emit<HistoryRecorded>(v2);
    }

    public entry fun revoke_admin_cap(arg0: &RegistryAdminCap, arg1: &mut DppRegistry, arg2: 0x2::object::ID) {
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.issued_admin_caps, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg1.issued_admin_caps, arg2) = false;
            let v0 = AdminCapRevoked{cap_id: arg2};
            0x2::event::emit<AdminCapRevoked>(v0);
        };
    }

    public entry fun set_min_fee(arg0: &RegistryAdminCap, arg1: &mut DppRegistry, arg2: u64) {
        arg1.min_fee = arg2;
    }

    public entry fun transfer_custody(arg0: &mut DppRegistry, arg1: Product, arg2: 0x2::coin::Coin<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        collect_fee(arg0, arg2, b"TRANSFER_CUSTODY", arg7);
        let v1 = &mut arg1;
        let v2 = HistoryRecorded{
            object_id    : 0x2::object::id<Product>(&arg1),
            product_id   : arg1.product_id,
            event_type   : 0x1::string::utf8(arg3),
            details      : 0x1::string::utf8(arg4),
            actor        : v0,
            seq          : push_history(v1, arg5, v0, 0x1::string::utf8(arg3), 0x1::string::utf8(arg4)),
            timestamp_ms : arg5,
        };
        0x2::event::emit<HistoryRecorded>(v2);
        0x2::transfer::public_transfer<Product>(arg1, arg6);
    }

    public entry fun transfer_registry_admin(arg0: RegistryAdminCap, arg1: address) {
        let v0 = RegistryAdminTransferred{new_admin: arg1};
        0x2::event::emit<RegistryAdminTransferred>(v0);
        0x2::transfer::public_transfer<RegistryAdminCap>(arg0, arg1);
    }

    public entry fun update_dpp(arg0: &mut DppRegistry, arg1: &mut Product, arg2: 0x2::coin::Coin<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        collect_fee(arg0, arg2, b"UPDATE_DPP", arg13);
        mutate_dpp(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun update_esg(arg0: &mut DppRegistry, arg1: &mut Product, arg2: 0x2::coin::Coin<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        collect_fee(arg0, arg2, b"UPDATE_ESG", arg9);
        mutate_esg(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun withdraw_fees(arg0: &RegistryAdminCap, arg1: &mut DppRegistry, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>>(0x2::coin::from_balance<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>(0x2::balance::split<0xae08c9b87fb482a4e53592592f055214967bb223154a7afdcc76a9ccc83bc461::gri::GRI>(&mut arg1.balance, arg3), arg4), arg2);
    }

    // decompiled from Move bytecode v7
}

