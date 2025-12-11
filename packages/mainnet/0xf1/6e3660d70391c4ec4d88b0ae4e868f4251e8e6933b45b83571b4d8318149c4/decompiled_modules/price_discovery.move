module 0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::price_discovery {
    struct PriceRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        total_products: u64,
        total_offers: u64,
    }

    struct ProductListing has key {
        id: 0x2::object::UID,
        sku: 0x1::string::String,
        name: 0x1::string::String,
        brand: 0x1::string::String,
        storage: 0x1::string::String,
        condition: 0x1::string::String,
        lowest_price: u64,
        average_price: u64,
        highest_price: u64,
        platform_price: u64,
        total_active_offers: u64,
        created_at: u64,
        updated_at: u64,
    }

    struct MerchantPriceOffer has store, key {
        id: 0x2::object::UID,
        sku: 0x1::string::String,
        merchant: address,
        shopper_price: u64,
        merchant_price: u64,
        availability_status: 0x1::string::String,
        estimated_stock_level: u64,
        location: 0x1::string::String,
        delivery_days: u8,
        is_active: bool,
        submitted_at: u64,
        expires_at: u64,
    }

    struct ProductListingCreated has copy, drop {
        listing_id: 0x2::object::ID,
        sku: 0x1::string::String,
        name: 0x1::string::String,
        brand: 0x1::string::String,
        timestamp: u64,
    }

    struct PriceOfferSubmitted has copy, drop {
        offer_id: 0x2::object::ID,
        sku: 0x1::string::String,
        merchant: address,
        shopper_price: u64,
        merchant_price: u64,
        timestamp: u64,
    }

    struct AggregatedPricingUpdated has copy, drop {
        sku: 0x1::string::String,
        lowest_price: u64,
        average_price: u64,
        highest_price: u64,
        total_active_offers: u64,
        timestamp: u64,
    }

    entry fun create_product_listing(arg0: &mut PriceRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) > 0, 3);
        assert!(0x1::string::length(&arg2) > 0, 3);
        assert!(0x1::string::length(&arg3) > 0, 3);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = ProductListing{
            id                  : 0x2::object::new(arg7),
            sku                 : arg1,
            name                : arg2,
            brand               : arg3,
            storage             : arg4,
            condition           : arg5,
            lowest_price        : 0,
            average_price       : 0,
            highest_price       : 0,
            platform_price      : 0,
            total_active_offers : 0,
            created_at          : v0,
            updated_at          : v0,
        };
        let v2 = ProductListingCreated{
            listing_id : 0x2::object::id<ProductListing>(&v1),
            sku        : v1.sku,
            name       : v1.name,
            brand      : v1.brand,
            timestamp  : v0,
        };
        0x2::event::emit<ProductListingCreated>(v2);
        arg0.total_products = arg0.total_products + 1;
        0x2::transfer::share_object<ProductListing>(v1);
    }

    public fun get_aggregated_pricing(arg0: &ProductListing) : (u64, u64, u64, u64, u64) {
        (arg0.lowest_price, arg0.average_price, arg0.highest_price, arg0.platform_price, arg0.total_active_offers)
    }

    public fun get_offer_details(arg0: &MerchantPriceOffer) : (0x1::string::String, address, u64, u64, 0x1::string::String, u64) {
        (arg0.sku, arg0.merchant, arg0.shopper_price, arg0.merchant_price, arg0.location, arg0.estimated_stock_level)
    }

    public fun get_product_details(arg0: &ProductListing) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (arg0.sku, arg0.name, arg0.brand, arg0.storage, arg0.condition)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceRegistry{
            id             : 0x2::object::new(arg0),
            admin          : 0x2::tx_context::sender(arg0),
            total_products : 0,
            total_offers   : 0,
        };
        0x2::transfer::share_object<PriceRegistry>(v0);
    }

    entry fun submit_price_offer(arg0: &mut PriceRegistry, arg1: &ProductListing, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(arg3 <= arg2, 2);
        assert!(arg5 > 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = if (arg8 > 0) {
            v0 + arg8 * 24 * 60 * 60 * 1000
        } else {
            0
        };
        let v2 = 0x2::tx_context::sender(arg10);
        let v3 = MerchantPriceOffer{
            id                    : 0x2::object::new(arg10),
            sku                   : arg1.sku,
            merchant              : v2,
            shopper_price         : arg2,
            merchant_price        : arg3,
            availability_status   : arg4,
            estimated_stock_level : arg5,
            location              : arg6,
            delivery_days         : arg7,
            is_active             : true,
            submitted_at          : v0,
            expires_at            : v1,
        };
        let v4 = PriceOfferSubmitted{
            offer_id       : 0x2::object::id<MerchantPriceOffer>(&v3),
            sku            : arg1.sku,
            merchant       : v2,
            shopper_price  : arg2,
            merchant_price : arg3,
            timestamp      : v0,
        };
        0x2::event::emit<PriceOfferSubmitted>(v4);
        arg0.total_offers = arg0.total_offers + 1;
        0x2::transfer::transfer<MerchantPriceOffer>(v3, v2);
    }

    entry fun update_aggregated_pricing(arg0: &PriceRegistry, arg1: &mut ProductListing, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 4);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        arg1.lowest_price = arg2;
        arg1.average_price = arg3;
        arg1.highest_price = arg4;
        arg1.platform_price = arg2;
        arg1.total_active_offers = arg5;
        arg1.updated_at = v0;
        let v1 = AggregatedPricingUpdated{
            sku                 : arg1.sku,
            lowest_price        : arg2,
            average_price       : arg3,
            highest_price       : arg4,
            total_active_offers : arg5,
            timestamp           : v0,
        };
        0x2::event::emit<AggregatedPricingUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

