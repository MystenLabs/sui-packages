module 0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::dpp {
    struct ESGData has copy, drop, store {
        carbon_footprint: 0x1::string::String,
        material_origin: 0x1::string::String,
        recyclability: 0x1::string::String,
        certifications: 0x1::string::String,
    }

    struct DPPData has copy, drop, store {
        product_type: 0x1::string::String,
        brand: 0x1::string::String,
        model: 0x1::string::String,
        serial_number: 0x1::string::String,
        manufacture_date: 0x1::string::String,
        expiration_date: 0x1::string::String,
        extra_metadata_uri: 0x1::string::String,
    }

    struct HistoryEvent has copy, drop, store {
        timestamp_ms: u64,
        actor: address,
        action: 0x1::string::String,
        details: 0x1::string::String,
    }

    struct Product has store, key {
        id: 0x2::object::UID,
        dpp: DPPData,
        esg: ESGData,
        history: vector<HistoryEvent>,
        product_id: 0x1::string::String,
    }

    struct DppRegistry has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>,
        min_fee: u64,
        admin: address,
    }

    struct DppAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RecallCap has store, key {
        id: 0x2::object::UID,
        product_id: 0x2::object::ID,
    }

    struct ProductCreated has copy, drop {
        object_id: 0x2::object::ID,
        product_id: 0x1::string::String,
        product_type: 0x1::string::String,
        brand: 0x1::string::String,
        creator: address,
    }

    struct ProductUpdated has copy, drop {
        object_id: 0x2::object::ID,
        product_id: 0x1::string::String,
        action: 0x1::string::String,
        updater: address,
    }

    struct HistoryRecorded has copy, drop {
        product_id: 0x1::string::String,
        event_type: 0x1::string::String,
        details: 0x1::string::String,
        actor: address,
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
        product_id: 0x2::object::ID,
        recall_type: 0x1::string::String,
        details: 0x1::string::String,
        issuer: address,
        timestamp_ms: u64,
    }

    public entry fun admin_create_product(arg0: &DppAdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        mint_product(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public entry fun admin_update_dpp(arg0: &DppAdminCap, arg1: &mut Product, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        mutate_dpp(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun admin_update_esg(arg0: &DppAdminCap, arg1: &mut Product, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        mutate_esg(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun collect_fee(arg0: &mut DppRegistry, arg1: 0x2::coin::Coin<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>(&arg1) >= arg0.min_fee, 1);
        0x2::balance::join<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>(&mut arg0.balance, 0x2::coin::into_balance<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>(0x2::coin::split<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>(&mut arg1, arg0.min_fee, arg3)));
        let v1 = FeeCollected{
            amount  : arg0.min_fee,
            payer   : v0,
            tx_type : 0x1::string::utf8(arg2),
        };
        0x2::event::emit<FeeCollected>(v1);
        if (0x2::coin::value<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>(arg1);
        };
    }

    public entry fun create_admin_cap(arg0: &DppRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        let v0 = DppAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<DppAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_product(arg0: &mut DppRegistry, arg1: 0x2::coin::Coin<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        collect_fee(arg0, arg1, b"CREATE", arg15);
        mint_product(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public fun get_balance(arg0: &DppRegistry) : u64 {
        0x2::balance::value<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>(&arg0.balance)
    }

    public fun get_dpp(arg0: &Product) : &DPPData {
        &arg0.dpp
    }

    public fun get_esg(arg0: &Product) : &ESGData {
        &arg0.esg
    }

    public fun get_history(arg0: &Product) : &vector<HistoryEvent> {
        &arg0.history
    }

    public fun get_min_fee(arg0: &DppRegistry) : u64 {
        arg0.min_fee
    }

    public fun get_product_id(arg0: &Product) : &0x1::string::String {
        &arg0.product_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DppRegistry{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>(),
            min_fee : 10000,
            admin   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<DppRegistry>(v0);
    }

    public entry fun manufacturer_recall(arg0: &mut DppRegistry, arg1: &RecallCap, arg2: 0x2::coin::Coin<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        collect_fee(arg0, arg2, b"RECALL", arg6);
        let v0 = RecallNotice{
            product_id   : arg1.product_id,
            recall_type  : 0x1::string::utf8(arg3),
            details      : 0x1::string::utf8(arg4),
            issuer       : 0x2::tx_context::sender(arg6),
            timestamp_ms : arg5,
        };
        0x2::event::emit<RecallNotice>(v0);
    }

    fun mint_product(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = DPPData{
            product_type       : 0x1::string::utf8(arg1),
            brand              : 0x1::string::utf8(arg2),
            model              : 0x1::string::utf8(arg3),
            serial_number      : 0x1::string::utf8(arg4),
            manufacture_date   : 0x1::string::utf8(arg5),
            expiration_date    : 0x1::string::utf8(arg6),
            extra_metadata_uri : 0x1::string::utf8(arg7),
        };
        let v2 = ESGData{
            carbon_footprint : 0x1::string::utf8(arg8),
            material_origin  : 0x1::string::utf8(arg9),
            recyclability    : 0x1::string::utf8(arg10),
            certifications   : 0x1::string::utf8(arg11),
        };
        let v3 = Product{
            id         : 0x2::object::new(arg13),
            dpp        : v1,
            esg        : v2,
            history    : 0x1::vector::empty<HistoryEvent>(),
            product_id : 0x1::string::utf8(arg0),
        };
        let v4 = &mut v3;
        push_history(v4, arg12, v0, 0x1::string::utf8(b"CREATED"), 0x1::string::utf8(b"Initial DPP + ESG data"));
        let v5 = ProductCreated{
            object_id    : 0x2::object::id<Product>(&v3),
            product_id   : v3.product_id,
            product_type : v3.dpp.product_type,
            brand        : v3.dpp.brand,
            creator      : v0,
        };
        0x2::event::emit<ProductCreated>(v5);
        let v6 = RecallCap{
            id         : 0x2::object::new(arg13),
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

    fun mutate_dpp(arg0: &mut Product, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        arg0.dpp.product_type = 0x1::string::utf8(arg1);
        arg0.dpp.brand = 0x1::string::utf8(arg2);
        arg0.dpp.model = 0x1::string::utf8(arg3);
        arg0.dpp.serial_number = 0x1::string::utf8(arg4);
        arg0.dpp.manufacture_date = 0x1::string::utf8(arg5);
        arg0.dpp.expiration_date = 0x1::string::utf8(arg6);
        arg0.dpp.extra_metadata_uri = 0x1::string::utf8(arg7);
        push_history(arg0, arg9, v0, 0x1::string::utf8(b"DPP_UPDATED"), 0x1::string::utf8(arg8));
        let v1 = ProductUpdated{
            object_id  : 0x2::object::id<Product>(arg0),
            product_id : arg0.product_id,
            action     : 0x1::string::utf8(b"DPP_UPDATED"),
            updater    : v0,
        };
        0x2::event::emit<ProductUpdated>(v1);
    }

    fun mutate_esg(arg0: &mut Product, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        arg0.esg.carbon_footprint = 0x1::string::utf8(arg1);
        arg0.esg.material_origin = 0x1::string::utf8(arg2);
        arg0.esg.recyclability = 0x1::string::utf8(arg3);
        arg0.esg.certifications = 0x1::string::utf8(arg4);
        push_history(arg0, arg6, v0, 0x1::string::utf8(b"ESG_UPDATED"), 0x1::string::utf8(arg5));
        let v1 = ProductUpdated{
            object_id  : 0x2::object::id<Product>(arg0),
            product_id : arg0.product_id,
            action     : 0x1::string::utf8(b"ESG_UPDATED"),
            updater    : v0,
        };
        0x2::event::emit<ProductUpdated>(v1);
    }

    fun push_history(arg0: &mut Product, arg1: u64, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = HistoryEvent{
            timestamp_ms : arg1,
            actor        : arg2,
            action       : arg3,
            details      : arg4,
        };
        0x1::vector::push_back<HistoryEvent>(&mut arg0.history, v0);
    }

    public entry fun record_event(arg0: &mut DppRegistry, arg1: &mut Product, arg2: 0x2::coin::Coin<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        collect_fee(arg0, arg2, b"RECORD_EVENT", arg6);
        push_history(arg1, arg5, v0, 0x1::string::utf8(arg3), 0x1::string::utf8(arg4));
        let v1 = HistoryRecorded{
            product_id   : arg1.product_id,
            event_type   : 0x1::string::utf8(arg3),
            details      : 0x1::string::utf8(arg4),
            actor        : v0,
            timestamp_ms : arg5,
        };
        0x2::event::emit<HistoryRecorded>(v1);
    }

    public entry fun set_min_fee(arg0: &mut DppRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.min_fee = arg1;
    }

    public entry fun transfer_custody(arg0: &mut DppRegistry, arg1: Product, arg2: 0x2::coin::Coin<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        collect_fee(arg0, arg2, b"TRANSFER_CUSTODY", arg7);
        let v1 = &mut arg1;
        push_history(v1, arg5, v0, 0x1::string::utf8(arg3), 0x1::string::utf8(arg4));
        let v2 = HistoryRecorded{
            product_id   : arg1.product_id,
            event_type   : 0x1::string::utf8(arg3),
            details      : 0x1::string::utf8(arg4),
            actor        : v0,
            timestamp_ms : arg5,
        };
        0x2::event::emit<HistoryRecorded>(v2);
        0x2::transfer::public_transfer<Product>(arg1, arg6);
    }

    public entry fun update_dpp(arg0: &mut DppRegistry, arg1: &mut Product, arg2: 0x2::coin::Coin<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        collect_fee(arg0, arg2, b"UPDATE_DPP", arg12);
        mutate_dpp(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun update_esg(arg0: &mut DppRegistry, arg1: &mut Product, arg2: 0x2::coin::Coin<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        collect_fee(arg0, arg2, b"UPDATE_ESG", arg9);
        mutate_esg(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun withdraw_fees(arg0: &mut DppRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>>(0x2::coin::from_balance<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>(0x2::balance::split<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>(&mut arg0.balance, 0x2::balance::value<0x47cb562e949c4f4a777aae1e675336dbd037763ca1208ac3ff16fde8a12036f0::gri::GRI>(&arg0.balance)), arg2), arg1);
    }

    // decompiled from Move bytecode v6
}

