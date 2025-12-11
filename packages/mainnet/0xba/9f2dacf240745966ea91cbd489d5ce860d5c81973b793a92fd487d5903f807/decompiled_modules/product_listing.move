module 0xba9f2dacf240745966ea91cbd489d5ce860d5c81973b793a92fd487d5903f807::product_listing {
    struct PriceRecord has copy, drop, store {
        shopper_price: u64,
        merchant_price: u64,
        timestamp: u64,
    }

    struct TelephoneProduct has store, key {
        id: 0x2::object::UID,
        merchant: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        device_description: 0x1::string::String,
        sku: 0x1::string::String,
        brand: 0x1::string::String,
        condition: 0x1::string::String,
        internal_storage: 0x1::string::String,
        ram: 0x1::string::String,
        color: 0x1::string::String,
        sim: 0x1::string::String,
        display_size: 0x1::string::String,
        operating_system: 0x1::string::String,
        network: 0x1::string::String,
        shopper_price: u64,
        merchant_price: u64,
        discount_price: u64,
        currency: 0x1::string::String,
        availability_status: 0x1::string::String,
        estimated_stock_level: u64,
        images: vector<0x1::string::String>,
        key_features: vector<0x1::string::String>,
        whats_in_box: vector<0x1::string::String>,
        shop_with_confidence: vector<0x1::string::String>,
        price_history: vector<PriceRecord>,
        is_active: bool,
        is_featured: bool,
        is_on_sale: bool,
        created_at: u64,
        updated_at: u64,
    }

    struct ProductRegistry has key {
        id: 0x2::object::UID,
        total_listings: u64,
        total_merchants: u64,
    }

    struct ProductListed has copy, drop {
        product_id: 0x2::object::ID,
        merchant: address,
        name: 0x1::string::String,
        brand: 0x1::string::String,
        shopper_price: u64,
        sku: 0x1::string::String,
        timestamp: u64,
    }

    struct ProductUpdated has copy, drop {
        product_id: 0x2::object::ID,
        merchant: address,
        shopper_price: u64,
        availability_status: 0x1::string::String,
        timestamp: u64,
    }

    public entry fun activate_product(arg0: &mut TelephoneProduct, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.merchant == 0x2::tx_context::sender(arg1), 2);
        arg0.is_active = true;
    }

    public entry fun deactivate_product(arg0: &mut TelephoneProduct, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.merchant == 0x2::tx_context::sender(arg1), 2);
        arg0.is_active = false;
    }

    public fun get_price_history(arg0: &TelephoneProduct) : vector<PriceRecord> {
        arg0.price_history
    }

    public fun get_product_availability(arg0: &TelephoneProduct) : (0x1::string::String, u64, bool) {
        (arg0.availability_status, arg0.estimated_stock_level, arg0.is_active)
    }

    public fun get_product_info(arg0: &TelephoneProduct) : (0x1::string::String, 0x1::string::String, 0x1::string::String, address, u64, u64) {
        (arg0.name, arg0.brand, arg0.sku, arg0.merchant, arg0.shopper_price, arg0.merchant_price)
    }

    public fun get_product_pricing(arg0: &TelephoneProduct) : (u64, u64, u64, bool, 0x1::string::String) {
        (arg0.shopper_price, arg0.merchant_price, arg0.discount_price, arg0.is_on_sale, arg0.currency)
    }

    public fun get_product_specs(arg0: &TelephoneProduct) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (arg0.condition, arg0.internal_storage, arg0.ram, arg0.color, arg0.sim, arg0.display_size, arg0.operating_system)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProductRegistry{
            id              : 0x2::object::new(arg0),
            total_listings  : 0,
            total_merchants : 0,
        };
        0x2::transfer::share_object<ProductRegistry>(v0);
    }

    public entry fun list_telephone_product(arg0: &mut ProductRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: u64, arg15: u64, arg16: u64, arg17: 0x1::string::String, arg18: 0x1::string::String, arg19: u64, arg20: vector<0x1::string::String>, arg21: vector<0x1::string::String>, arg22: vector<0x1::string::String>, arg23: vector<0x1::string::String>, arg24: bool, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) > 0, 3);
        assert!(0x1::string::length(&arg5) > 0, 3);
        assert!(arg14 > 0, 1);
        assert!(arg15 <= arg14, 2);
        let v0 = 0x2::tx_context::sender(arg26);
        let v1 = 0x2::clock::timestamp_ms(arg25);
        let v2 = if (0x1::string::length(&arg17) == 0) {
            0x1::string::utf8(b"NGN")
        } else {
            arg17
        };
        let v3 = TelephoneProduct{
            id                    : 0x2::object::new(arg26),
            merchant              : v0,
            name                  : arg1,
            description           : arg2,
            device_description    : arg3,
            sku                   : arg4,
            brand                 : arg5,
            condition             : arg6,
            internal_storage      : arg7,
            ram                   : arg8,
            color                 : arg9,
            sim                   : arg10,
            display_size          : arg11,
            operating_system      : arg12,
            network               : arg13,
            shopper_price         : arg14,
            merchant_price        : arg15,
            discount_price        : arg16,
            currency              : v2,
            availability_status   : arg18,
            estimated_stock_level : arg19,
            images                : arg20,
            key_features          : arg21,
            whats_in_box          : arg22,
            shop_with_confidence  : arg23,
            price_history         : 0x1::vector::empty<PriceRecord>(),
            is_active             : true,
            is_featured           : false,
            is_on_sale            : arg24,
            created_at            : v1,
            updated_at            : v1,
        };
        let v4 = ProductListed{
            product_id    : 0x2::object::id<TelephoneProduct>(&v3),
            merchant      : v0,
            name          : v3.name,
            brand         : v3.brand,
            shopper_price : arg14,
            sku           : v3.sku,
            timestamp     : v1,
        };
        0x2::event::emit<ProductListed>(v4);
        arg0.total_listings = arg0.total_listings + 1;
        0x2::transfer::transfer<TelephoneProduct>(v3, v0);
    }

    public entry fun update_product(arg0: &mut TelephoneProduct, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(arg0.merchant == 0x2::tx_context::sender(arg8), 2);
        assert!(arg1 > 0, 1);
        assert!(arg2 <= arg1, 2);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = PriceRecord{
            shopper_price  : arg0.shopper_price,
            merchant_price : arg0.merchant_price,
            timestamp      : arg0.updated_at,
        };
        0x1::vector::push_back<PriceRecord>(&mut arg0.price_history, v1);
        arg0.shopper_price = arg1;
        arg0.merchant_price = arg2;
        arg0.discount_price = arg3;
        arg0.availability_status = arg4;
        arg0.estimated_stock_level = arg5;
        arg0.is_on_sale = arg6;
        arg0.updated_at = v0;
        let v2 = ProductUpdated{
            product_id          : 0x2::object::id<TelephoneProduct>(arg0),
            merchant            : arg0.merchant,
            shopper_price       : arg1,
            availability_status : arg0.availability_status,
            timestamp           : v0,
        };
        0x2::event::emit<ProductUpdated>(v2);
    }

    // decompiled from Move bytecode v6
}

