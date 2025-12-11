module 0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::device_provenance {
    struct Device has key {
        id: 0x2::object::UID,
        imei: 0x1::string::String,
        serial_number: 0x1::string::String,
        brand: 0x1::string::String,
        model: 0x1::string::String,
        storage: 0x1::string::String,
        color: 0x1::string::String,
        original_purchase_date: u64,
        original_price: u64,
        original_currency: 0x1::string::String,
        original_region: 0x1::string::String,
        distribution_parent: 0x1::option::Option<0x2::object::ID>,
        current_owner: address,
        current_listing_price: u64,
        is_for_sale: bool,
        ownership_history: vector<OwnershipRecord>,
        price_history: vector<PriceRecord>,
        condition_history: vector<ConditionRecord>,
        warranty_expiry: u64,
        is_blacklisted: bool,
        blacklist_reason: 0x1::string::String,
        registered_at: u64,
        updated_at: u64,
    }

    struct OwnershipRecord has copy, drop, store {
        previous_owner: address,
        new_owner: address,
        transfer_date: u64,
        transfer_price: u64,
        transfer_currency: 0x1::string::String,
        transfer_location: 0x1::string::String,
    }

    struct PriceRecord has copy, drop, store {
        price: u64,
        currency: 0x1::string::String,
        listed_date: u64,
        merchant: address,
        condition_at_listing: 0x1::string::String,
        location: 0x1::string::String,
    }

    struct ConditionRecord has copy, drop, store {
        condition: 0x1::string::String,
        assessed_by: address,
        assessment_date: u64,
        notes: 0x1::string::String,
    }

    struct DeviceRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        total_devices: u64,
        total_transfers: u64,
        blacklisted_count: u64,
        imei_registry: 0x2::table::Table<0x1::string::String, vector<0x2::object::ID>>,
    }

    struct DeviceRegistered has copy, drop {
        device_id: 0x2::object::ID,
        imei: 0x1::string::String,
        brand: 0x1::string::String,
        model: 0x1::string::String,
        owner: address,
        timestamp: u64,
    }

    struct DeviceTransferred has copy, drop {
        device_id: 0x2::object::ID,
        imei: 0x1::string::String,
        previous_owner: address,
        new_owner: address,
        sale_price: u64,
        timestamp: u64,
    }

    struct DeviceConditionUpdated has copy, drop {
        device_id: 0x2::object::ID,
        imei: 0x1::string::String,
        old_condition: 0x1::string::String,
        new_condition: 0x1::string::String,
        assessed_by: address,
        timestamp: u64,
    }

    struct DeviceBlacklisted has copy, drop {
        device_id: 0x2::object::ID,
        imei: 0x1::string::String,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct DeviceListedForSale has copy, drop {
        device_id: 0x2::object::ID,
        imei: 0x1::string::String,
        asking_price: u64,
        condition: 0x1::string::String,
        owner: address,
        timestamp: u64,
    }

    entry fun blacklist_device(arg0: &mut DeviceRegistry, arg1: &mut Device, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 5);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg1.is_blacklisted = true;
        arg1.blacklist_reason = arg2;
        arg1.is_for_sale = false;
        arg1.updated_at = v0;
        let v1 = DeviceBlacklisted{
            device_id : 0x2::object::id<Device>(arg1),
            imei      : arg1.imei,
            reason    : arg2,
            timestamp : v0,
        };
        0x2::event::emit<DeviceBlacklisted>(v1);
        arg0.blacklisted_count = arg0.blacklisted_count + 1;
    }

    public fun get_current_condition(arg0: &Device) : 0x1::string::String {
        if (0x1::vector::length<ConditionRecord>(&arg0.condition_history) > 0) {
            0x1::vector::borrow<ConditionRecord>(&arg0.condition_history, 0x1::vector::length<ConditionRecord>(&arg0.condition_history) - 1).condition
        } else {
            0x1::string::utf8(b"Unknown")
        }
    }

    public fun get_device_age_days(arg0: &Device, arg1: &0x2::clock::Clock) : u64 {
        (0x2::clock::timestamp_ms(arg1) - arg0.original_purchase_date) / 86400000
    }

    public fun get_device_info(arg0: &Device) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, address, bool) {
        (arg0.imei, arg0.brand, arg0.model, arg0.serial_number, arg0.current_owner, arg0.is_blacklisted)
    }

    public fun get_device_pricing(arg0: &Device) : (u64, u64, bool, 0x1::string::String) {
        (arg0.original_price, arg0.current_listing_price, arg0.is_for_sale, arg0.original_currency)
    }

    public fun get_ownership_count(arg0: &Device) : u64 {
        0x1::vector::length<OwnershipRecord>(&arg0.ownership_history)
    }

    public fun get_price_history_count(arg0: &Device) : u64 {
        0x1::vector::length<PriceRecord>(&arg0.price_history)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeviceRegistry{
            id                : 0x2::object::new(arg0),
            admin             : 0x2::tx_context::sender(arg0),
            total_devices     : 0,
            total_transfers   : 0,
            blacklisted_count : 0,
            imei_registry     : 0x2::table::new<0x1::string::String, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<DeviceRegistry>(v0);
    }

    public fun is_warranty_valid(arg0: &Device, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.warranty_expiry
    }

    public entry fun list_device_for_sale(arg0: &mut Device, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.current_owner == 0x2::tx_context::sender(arg5), 3);
        assert!(!arg0.is_blacklisted, 2);
        assert!(arg1 > 0, 4);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = if (0x1::vector::length<ConditionRecord>(&arg0.condition_history) > 0) {
            0x1::vector::borrow<ConditionRecord>(&arg0.condition_history, 0x1::vector::length<ConditionRecord>(&arg0.condition_history) - 1).condition
        } else {
            0x1::string::utf8(b"Unknown")
        };
        let v2 = PriceRecord{
            price                : arg1,
            currency             : arg2,
            listed_date          : v0,
            merchant             : 0x2::tx_context::sender(arg5),
            condition_at_listing : v1,
            location             : arg3,
        };
        0x1::vector::push_back<PriceRecord>(&mut arg0.price_history, v2);
        arg0.is_for_sale = true;
        arg0.current_listing_price = arg1;
        arg0.updated_at = v0;
        let v3 = DeviceListedForSale{
            device_id    : 0x2::object::id<Device>(arg0),
            imei         : arg0.imei,
            asking_price : arg1,
            condition    : v1,
            owner        : arg0.current_owner,
            timestamp    : v0,
        };
        0x2::event::emit<DeviceListedForSale>(v3);
    }

    public entry fun register_device(arg0: &mut DeviceRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: 0x1::string::String, arg12: 0x1::option::Option<0x2::object::ID>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) > 0, 1);
        assert!(arg7 > 0, 4);
        let v0 = 0x2::clock::timestamp_ms(arg13);
        let v1 = 0x2::tx_context::sender(arg14);
        let v2 = 0x1::vector::empty<ConditionRecord>();
        let v3 = ConditionRecord{
            condition       : arg11,
            assessed_by     : v1,
            assessment_date : v0,
            notes           : 0x1::string::utf8(b"Initial registration"),
        };
        0x1::vector::push_back<ConditionRecord>(&mut v2, v3);
        let v4 = Device{
            id                     : 0x2::object::new(arg14),
            imei                   : arg1,
            serial_number          : arg2,
            brand                  : arg3,
            model                  : arg4,
            storage                : arg5,
            color                  : arg6,
            original_purchase_date : v0,
            original_price         : arg7,
            original_currency      : arg8,
            original_region        : arg9,
            distribution_parent    : arg12,
            current_owner          : v1,
            current_listing_price  : 0,
            is_for_sale            : false,
            ownership_history      : 0x1::vector::empty<OwnershipRecord>(),
            price_history          : 0x1::vector::empty<PriceRecord>(),
            condition_history      : v2,
            warranty_expiry        : v0 + arg10 * 30 * 24 * 60 * 60 * 1000,
            is_blacklisted         : false,
            blacklist_reason       : 0x1::string::utf8(b""),
            registered_at          : v0,
            updated_at             : v0,
        };
        let v5 = 0x2::object::id<Device>(&v4);
        let v6 = DeviceRegistered{
            device_id : v5,
            imei      : v4.imei,
            brand     : v4.brand,
            model     : v4.model,
            owner     : v1,
            timestamp : v0,
        };
        0x2::event::emit<DeviceRegistered>(v6);
        arg0.total_devices = arg0.total_devices + 1;
        if (0x2::table::contains<0x1::string::String, vector<0x2::object::ID>>(&arg0.imei_registry, v4.imei)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x1::string::String, vector<0x2::object::ID>>(&mut arg0.imei_registry, v4.imei), v5);
        } else {
            let v7 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v7, v5);
            0x2::table::add<0x1::string::String, vector<0x2::object::ID>>(&mut arg0.imei_registry, v4.imei, v7);
        };
        0x2::transfer::transfer<Device>(v4, v1);
    }

    entry fun transfer_device(arg0: &mut DeviceRegistry, arg1: &mut Device, arg2: address, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg1.current_owner == 0x2::tx_context::sender(arg7), 3);
        assert!(!arg1.is_blacklisted, 2);
        assert!(arg3 > 0, 4);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = arg1.current_owner;
        let v2 = OwnershipRecord{
            previous_owner    : v1,
            new_owner         : arg2,
            transfer_date     : v0,
            transfer_price    : arg3,
            transfer_currency : arg4,
            transfer_location : arg5,
        };
        0x1::vector::push_back<OwnershipRecord>(&mut arg1.ownership_history, v2);
        arg1.current_owner = arg2;
        arg1.is_for_sale = false;
        arg1.current_listing_price = 0;
        arg1.updated_at = v0;
        let v3 = DeviceTransferred{
            device_id      : 0x2::object::id<Device>(arg1),
            imei           : arg1.imei,
            previous_owner : v1,
            new_owner      : arg2,
            sale_price     : arg3,
            timestamp      : v0,
        };
        0x2::event::emit<DeviceTransferred>(v3);
        arg0.total_transfers = arg0.total_transfers + 1;
    }

    public entry fun unlist_device(arg0: &mut Device, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.current_owner == 0x2::tx_context::sender(arg2), 3);
        arg0.is_for_sale = false;
        arg0.current_listing_price = 0;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg1);
    }

    entry fun update_device_condition(arg0: &mut Device, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.current_owner == 0x2::tx_context::sender(arg4), 3);
        assert!(!arg0.is_blacklisted, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = if (0x1::vector::length<ConditionRecord>(&arg0.condition_history) > 0) {
            0x1::vector::borrow<ConditionRecord>(&arg0.condition_history, 0x1::vector::length<ConditionRecord>(&arg0.condition_history) - 1).condition
        } else {
            0x1::string::utf8(b"Unknown")
        };
        let v2 = ConditionRecord{
            condition       : arg1,
            assessed_by     : 0x2::tx_context::sender(arg4),
            assessment_date : v0,
            notes           : arg2,
        };
        0x1::vector::push_back<ConditionRecord>(&mut arg0.condition_history, v2);
        arg0.updated_at = v0;
        let v3 = DeviceConditionUpdated{
            device_id     : 0x2::object::id<Device>(arg0),
            imei          : arg0.imei,
            old_condition : v1,
            new_condition : arg1,
            assessed_by   : 0x2::tx_context::sender(arg4),
            timestamp     : v0,
        };
        0x2::event::emit<DeviceConditionUpdated>(v3);
    }

    // decompiled from Move bytecode v6
}

