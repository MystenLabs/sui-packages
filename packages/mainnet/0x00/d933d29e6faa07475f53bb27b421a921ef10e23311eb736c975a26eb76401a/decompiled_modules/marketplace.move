module 0xd933d29e6faa07475f53bb27b421a921ef10e23311eb736c975a26eb76401a::marketplace {
    struct MerchantRegistry has key {
        id: 0x2::object::UID,
        merchants: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct MerchantProfile has key {
        id: 0x2::object::UID,
        authority: address,
        store_name: 0x1::string::String,
        description_uri: 0x1::string::String,
        logo_uri: 0x1::string::String,
        banner_uri: 0x1::string::String,
        ships_from: 0x1::string::String,
        preferred_contact: 0x1::string::String,
        seller_deposit_bps: u16,
        total_sold: u32,
        active: bool,
        verified: bool,
        created_at: u64,
    }

    struct Product has key {
        id: 0x2::object::UID,
        merchant: address,
        product_id: u64,
        title: 0x1::string::String,
        description_uri: 0x1::string::String,
        image_uris: vector<0x1::string::String>,
        category: 0x1::string::String,
        price: u64,
        seller_deposit_bps_override: 0x1::option::Option<u16>,
        stock: u32,
        sold: u32,
        active: bool,
        deleted: bool,
        created_at: u64,
        updated_at: u64,
    }

    struct OrderRecord has key {
        id: 0x2::object::UID,
        escrow: 0x2::object::ID,
        product: 0x2::object::ID,
        buyer: address,
        seller: address,
        quantity: u32,
        unit_price: u64,
        total_price: u64,
        security_deposit: u64,
        completed_sale_recorded: bool,
        stock_restored: bool,
        reviewed: bool,
        created_at: u64,
    }

    struct MerchantReputation has key {
        id: 0x2::object::UID,
        merchant: address,
        total_reviews: u64,
        total_rating: u64,
        five_star: u64,
        four_star: u64,
        three_star: u64,
        two_star: u64,
        one_star: u64,
    }

    struct ProductReview has key {
        id: 0x2::object::UID,
        order: 0x2::object::ID,
        escrow: 0x2::object::ID,
        product: 0x2::object::ID,
        merchant: address,
        reviewer: address,
        rating: u8,
        comment: 0x1::string::String,
        created_at: u64,
    }

    struct MerchantCreated has copy, drop {
        merchant_id: 0x2::object::ID,
        authority: address,
    }

    struct MerchantUpdated has copy, drop {
        merchant_id: 0x2::object::ID,
        authority: address,
    }

    struct ProductCreated has copy, drop {
        product_object_id: 0x2::object::ID,
        merchant: address,
        product_id: u64,
    }

    struct ProductUpdated has copy, drop {
        product_object_id: 0x2::object::ID,
        merchant: address,
        product_id: u64,
    }

    struct ProductDeleted has copy, drop {
        product_object_id: 0x2::object::ID,
        merchant: address,
        product_id: u64,
    }

    struct OrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        quantity: u32,
        total_price: u64,
    }

    struct ReputationCreated has copy, drop {
        reputation_id: 0x2::object::ID,
        merchant: address,
    }

    struct ReviewCreated has copy, drop {
        review_id: 0x2::object::ID,
        order_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        merchant: address,
        reviewer: address,
        rating: u8,
    }

    struct ChatMessage has key {
        id: 0x2::object::UID,
        product: 0x2::object::ID,
        buyer: address,
        seller: address,
        sender: address,
        recipient: address,
        message: 0x1::string::String,
        created_at: u64,
    }

    struct SpecialPriceOffer has key {
        id: 0x2::object::UID,
        product: 0x2::object::ID,
        seller: address,
        buyer: address,
        unit_price: u64,
        quantity: u32,
        active: bool,
        used: bool,
        created_at: u64,
    }

    struct SpecialPriceOffered has copy, drop {
        offer_id: 0x2::object::ID,
        product: 0x2::object::ID,
        seller: address,
        buyer: address,
        unit_price: u64,
        quantity: u32,
    }

    struct SpecialPriceOfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        product: 0x2::object::ID,
        seller: address,
        buyer: address,
    }

    struct OfferEscrowBinding has store {
        offer: 0x2::object::ID,
        product: 0x2::object::ID,
        buyer: address,
        seller: address,
        quantity: u32,
        total_price: u64,
    }

    struct PurchaseOffer has key {
        id: 0x2::object::UID,
        product: 0x2::object::ID,
        escrow: 0x2::object::ID,
        buyer: address,
        seller: address,
        unit_price: u64,
        quantity: u32,
        total_price: u64,
        security_deposit: u64,
        buyer_deposit: u64,
        active: bool,
        accepted: bool,
        rejected: bool,
        withdrawn: bool,
        created_at: u64,
    }

    struct PurchaseOfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        product: 0x2::object::ID,
        escrow: 0x2::object::ID,
        buyer: address,
        seller: address,
        unit_price: u64,
        quantity: u32,
        total_price: u64,
        buyer_deposit: u64,
    }

    struct PurchaseOfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        product: 0x2::object::ID,
        escrow: 0x2::object::ID,
        buyer: address,
        seller: address,
    }

    struct PurchaseOfferRejected has copy, drop {
        offer_id: 0x2::object::ID,
        product: 0x2::object::ID,
        escrow: 0x2::object::ID,
        buyer: address,
        seller: address,
    }

    struct PurchaseOfferWithdrawn has copy, drop {
        offer_id: 0x2::object::ID,
        product: 0x2::object::ID,
        escrow: 0x2::object::ID,
        buyer: address,
        seller: address,
    }

    struct MessageSent has copy, drop {
        message_id: 0x2::object::ID,
        product: 0x2::object::ID,
        buyer: address,
        seller: address,
        sender: address,
        recipient: address,
        created_at: u64,
    }

    public fun accept_purchase_offer(arg0: &mut MerchantRegistry, arg1: &MerchantProfile, arg2: &mut Product, arg3: &mut PurchaseOffer, arg4: &mut 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 == arg3.seller, 0);
        assert!(arg1.authority == v0, 0);
        assert!(arg1.active, 3);
        assert!(arg3.active, 36);
        let v2 = if (!arg3.accepted) {
            if (!arg3.rejected) {
                !arg3.withdrawn
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 36);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg4) == 0, 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_a(arg4) == arg3.buyer_deposit, 13);
        assert!(0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg4) == arg3.escrow, 16);
        assert!(0x2::object::id<Product>(arg2) == arg3.product, 38);
        assert!(arg2.merchant == v0, 0);
        assert!(arg2.active && !arg2.deleted, 6);
        assert!(arg3.quantity > 0, 8);
        assert!(arg2.stock >= arg3.quantity, 9);
        assert!(arg3.unit_price > 0, 30);
        assert!(checked_mul(arg3.unit_price, (arg3.quantity as u64)) == arg3.total_price, 12);
        assert!(checked_add_u64(arg3.total_price, arg3.security_deposit) == arg3.buyer_deposit, 15);
        assert!(0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg4) == arg3.escrow, 39);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg4) == 0, 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::creator(arg4) == arg3.buyer, 11);
        assert!(contains_solzaar_marker(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::note(arg4)), 10);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_a_address(arg4) == arg3.buyer, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_b_address(arg4) == v0, 11);
        assert!(arg3.buyer != v0, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::reference_amount(arg4) == arg3.total_price, 12);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::required_deposit_a(arg4) == arg3.buyer_deposit, 15);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_a(arg4) == arg3.buyer_deposit, 13);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::required_deposit_b(arg4) == arg3.security_deposit, 14);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_b(arg4) == 0, 14);
        assert!(0x2::dynamic_field::exists<0x2::object::ID>(&arg0.id, arg3.escrow), 39);
        let v3 = 0x2::dynamic_field::borrow<0x2::object::ID, OfferEscrowBinding>(&arg0.id, arg3.escrow);
        assert!(v3.offer == 0x2::object::id<PurchaseOffer>(arg3), 39);
        assert!(v3.product == arg3.product, 38);
        assert!(v3.buyer == arg3.buyer, 11);
        assert!(v3.seller == v0, 11);
        assert!(v3.quantity == arg3.quantity, 8);
        assert!(v3.total_price == arg3.total_price, 12);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == arg3.security_deposit, 14);
        0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposit(arg4, arg5, arg6, arg7);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg4) == 1, 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_b(arg4) == arg3.security_deposit, 14);
        arg2.stock = arg2.stock - arg3.quantity;
        arg2.updated_at = v1;
        let v4 = OrderRecord{
            id                      : 0x2::object::new(arg7),
            escrow                  : arg3.escrow,
            product                 : arg3.product,
            buyer                   : arg3.buyer,
            seller                  : v0,
            quantity                : arg3.quantity,
            unit_price              : arg3.unit_price,
            total_price             : arg3.total_price,
            security_deposit        : arg3.security_deposit,
            completed_sale_recorded : false,
            stock_restored          : false,
            reviewed                : false,
            created_at              : v1,
        };
        arg3.active = false;
        arg3.accepted = true;
        let v5 = PurchaseOfferAccepted{
            offer_id : 0x2::object::id<PurchaseOffer>(arg3),
            product  : arg3.product,
            escrow   : arg3.escrow,
            buyer    : arg3.buyer,
            seller   : v0,
        };
        0x2::event::emit<PurchaseOfferAccepted>(v5);
        let v6 = OrderCreated{
            order_id    : 0x2::object::uid_to_inner(&v4.id),
            escrow_id   : arg3.escrow,
            product_id  : arg3.product,
            buyer       : arg3.buyer,
            seller      : v0,
            quantity    : arg3.quantity,
            total_price : arg3.total_price,
        };
        0x2::event::emit<OrderCreated>(v6);
        0x2::transfer::share_object<OrderRecord>(v4);
    }

    public fun approve_mutual_cancellation(arg0: &mut Product, arg1: &mut OrderRecord, arg2: &mut 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_order_escrow_match(arg1, arg2);
        assert!(arg1.product == 0x2::object::id<Product>(arg0), 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg2) == 2, 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::proposed_payout_a(arg2) == 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_a(arg2), 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::proposed_payout_b(arg2) == 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_b(arg2), 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::proposed_donation(arg2) == 0, 16);
        0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::accept_finalization(arg2, arg3, arg4);
        restore_mutually_cancelled_order_stock(arg0, arg1, arg2);
    }

    fun assert_order_escrow_match(arg0: &OrderRecord, arg1: &0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow) {
        assert!(arg0.escrow == 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg1), 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_a_address(arg1) == arg0.buyer, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_b_address(arg1) == arg0.seller, 11);
        assert!(!arg0.stock_restored, 16);
        assert!(!arg0.completed_sale_recorded, 16);
    }

    fun bind_escrow(arg0: &mut MerchantRegistry, arg1: 0x2::object::ID) {
        assert!(!0x2::dynamic_field::exists<0x2::object::ID>(&arg0.id, arg1), 40);
        0x2::dynamic_field::add<0x2::object::ID, bool>(&mut arg0.id, arg1, true);
    }

    public fun cancel_special_price_offer(arg0: &mut SpecialPriceOffer, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 0);
        assert!(arg0.active, 32);
        assert!(!arg0.used, 32);
        arg0.active = false;
        let v0 = SpecialPriceOfferCancelled{
            offer_id : 0x2::object::id<SpecialPriceOffer>(arg0),
            product  : arg0.product,
            seller   : arg0.seller,
            buyer    : arg0.buyer,
        };
        0x2::event::emit<SpecialPriceOfferCancelled>(v0);
    }

    fun checked_add_u32(arg0: u32, arg1: u32) : u32 {
        assert!(arg0 <= 4294967295 - arg1, 17);
        arg0 + arg1
    }

    fun checked_add_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 17);
        arg0 + arg1
    }

    fun checked_mul(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 17);
        arg0 * arg1
    }

    fun contains_solzaar_marker(arg0: &vector<u8>) : bool {
        let v0 = b"\"marketplace\":\"solbazaar\"";
        let v1 = 0x1::vector::length<u8>(arg0);
        let v2 = 0x1::vector::length<u8>(&v0);
        if (v1 < v2) {
            return false
        };
        let v3 = 0;
        while (v3 + v2 <= v1) {
            let v4 = 0;
            let v5 = true;
            while (v4 < v2) {
                if (*0x1::vector::borrow<u8>(arg0, v3 + v4) != *0x1::vector::borrow<u8>(&v0, v4)) {
                    v5 = false;
                    v4 = v2;
                    continue
                };
                v4 = v4 + 1;
            };
            if (v5) {
                return true
            };
            v3 = v3 + 1;
        };
        false
    }

    public fun create_merchant(arg0: &mut MerchantRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u16, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) <= 64, 1);
        assert!(0x1::string::length(&arg2) <= 200, 1);
        assert!(0x1::string::length(&arg3) <= 200, 1);
        assert!(0x1::string::length(&arg4) <= 200, 1);
        assert!(0x1::string::length(&arg5) <= 64, 1);
        assert!(0x1::string::length(&arg7) <= 300, 1);
        assert!((arg6 as u64) <= 10000, 7);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.merchants, v0), 20);
        let v1 = MerchantProfile{
            id                 : 0x2::object::new(arg9),
            authority          : v0,
            store_name         : arg1,
            description_uri    : arg2,
            logo_uri           : arg3,
            banner_uri         : arg4,
            ships_from         : arg5,
            preferred_contact  : arg7,
            seller_deposit_bps : arg6,
            total_sold         : 0,
            active             : true,
            verified           : false,
            created_at         : 0x2::clock::timestamp_ms(arg8),
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        let v3 = MerchantReputation{
            id            : 0x2::object::new(arg9),
            merchant      : v0,
            total_reviews : 0,
            total_rating  : 0,
            five_star     : 0,
            four_star     : 0,
            three_star    : 0,
            two_star      : 0,
            one_star      : 0,
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.merchants, v0, v2);
        let v4 = MerchantCreated{
            merchant_id : v2,
            authority   : v0,
        };
        0x2::event::emit<MerchantCreated>(v4);
        let v5 = ReputationCreated{
            reputation_id : 0x2::object::uid_to_inner(&v3.id),
            merchant      : v0,
        };
        0x2::event::emit<ReputationCreated>(v5);
        0x2::transfer::share_object<MerchantProfile>(v1);
        0x2::transfer::share_object<MerchantReputation>(v3);
    }

    public fun create_order_record(arg0: &MerchantProfile, arg1: &mut Product, arg2: &0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow, arg3: u32, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 41
    }

    public fun create_order_record_v2(arg0: &mut MerchantRegistry, arg1: &MerchantProfile, arg2: &mut Product, arg3: &0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow, arg4: u32, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = arg2.merchant;
        assert!(arg1.authority == v1, 0);
        assert!(arg1.active, 3);
        assert!(arg2.active, 6);
        assert!(!arg2.deleted, 6);
        assert!(arg4 > 0, 8);
        assert!(arg2.stock >= arg4, 9);
        let v2 = checked_mul(arg2.price, (arg4 as u64));
        let v3 = checked_mul(v2, effective_deposit_bps(arg2, arg1)) / 10000;
        let v4 = v3;
        if (v3 == 0) {
            v4 = 1;
        };
        let v5 = checked_add_u64(v2, v4);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg3) == 0, 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::creator(arg3) == v0, 11);
        assert!(contains_solzaar_marker(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::note(arg3)), 10);
        let v6 = 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_a_address(arg3);
        let v7 = 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_b_address(arg3);
        assert!(v6 == v0, 11);
        assert!(v7 == v1, 11);
        assert!(v6 != v7, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::reference_amount(arg3) == v2, 12);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::required_deposit_a(arg3) == v5, 15);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_a(arg3) == v5, 13);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::required_deposit_b(arg3) == v4, 14);
        arg2.stock = arg2.stock - arg4;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg5);
        let v8 = OrderRecord{
            id                      : 0x2::object::new(arg6),
            escrow                  : 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg3),
            product                 : 0x2::object::id<Product>(arg2),
            buyer                   : v0,
            seller                  : v1,
            quantity                : arg4,
            unit_price              : arg2.price,
            total_price             : v2,
            security_deposit        : v4,
            completed_sale_recorded : false,
            stock_restored          : false,
            reviewed                : false,
            created_at              : 0x2::clock::timestamp_ms(arg5),
        };
        let v9 = OrderCreated{
            order_id    : 0x2::object::uid_to_inner(&v8.id),
            escrow_id   : 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg3),
            product_id  : 0x2::object::id<Product>(arg2),
            buyer       : v0,
            seller      : v1,
            quantity    : arg4,
            total_price : v2,
        };
        0x2::event::emit<OrderCreated>(v9);
        bind_escrow(arg0, 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg3));
        0x2::transfer::share_object<OrderRecord>(v8);
    }

    public fun create_product(arg0: &MerchantProfile, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: u64, arg7: u32, arg8: 0x1::option::Option<u16>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(v0 == arg0.authority, 0);
        assert!(arg0.active, 3);
        validate_product_fields(&arg2, &arg3, &arg4, &arg5, arg6);
        validate_deposit_override(&arg8);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = Product{
            id                          : 0x2::object::new(arg10),
            merchant                    : v0,
            product_id                  : arg1,
            title                       : arg2,
            description_uri             : arg3,
            image_uris                  : arg4,
            category                    : arg5,
            price                       : arg6,
            seller_deposit_bps_override : arg8,
            stock                       : arg7,
            sold                        : 0,
            active                      : true,
            deleted                     : false,
            created_at                  : v1,
            updated_at                  : v1,
        };
        let v3 = ProductCreated{
            product_object_id : 0x2::object::uid_to_inner(&v2.id),
            merchant          : v0,
            product_id        : arg1,
        };
        0x2::event::emit<ProductCreated>(v3);
        0x2::transfer::share_object<Product>(v2);
    }

    public fun create_purchase_offer(arg0: &MerchantProfile, arg1: &Product, arg2: &0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow, arg3: u64, arg4: u32, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 41
    }

    public fun create_purchase_offer_v2(arg0: &mut MerchantRegistry, arg1: &MerchantProfile, arg2: &Product, arg3: &0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow, arg4: u64, arg5: u32, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = arg2.merchant;
        assert!(arg1.authority == v1, 0);
        assert!(arg1.active, 3);
        assert!(arg2.active, 6);
        assert!(!arg2.deleted, 6);
        assert!(v0 != v1, 11);
        assert!(arg4 > 0, 30);
        assert!(arg5 > 0, 8);
        assert!(arg2.stock >= arg5, 9);
        assert!(arg4 < arg2.price, 12);
        let v2 = checked_mul(arg4, (arg5 as u64));
        let v3 = checked_mul(v2, effective_deposit_bps(arg2, arg1)) / 10000;
        let v4 = v3;
        if (v3 == 0) {
            v4 = 1;
        };
        let v5 = checked_add_u64(v2, v4);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg3) == 0, 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::creator(arg3) == v0, 11);
        assert!(contains_solzaar_marker(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::note(arg3)), 10);
        let v6 = 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_a_address(arg3);
        let v7 = 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_b_address(arg3);
        assert!(v6 == v0, 11);
        assert!(v7 == v1, 11);
        assert!(v6 != v7, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::reference_amount(arg3) == v2, 12);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::required_deposit_a(arg3) == v5, 15);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_a(arg3) == v5, 13);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::required_deposit_b(arg3) == v4, 14);
        let v8 = PurchaseOffer{
            id               : 0x2::object::new(arg7),
            product          : 0x2::object::id<Product>(arg2),
            escrow           : 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg3),
            buyer            : v0,
            seller           : v1,
            unit_price       : arg4,
            quantity         : arg5,
            total_price      : v2,
            security_deposit : v4,
            buyer_deposit    : v5,
            active           : true,
            accepted         : false,
            rejected         : false,
            withdrawn        : false,
            created_at       : 0x2::clock::timestamp_ms(arg6),
        };
        let v9 = 0x2::object::uid_to_inner(&v8.id);
        assert!(!0x2::dynamic_field::exists<0x2::object::ID>(&arg0.id, 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg3)), 40);
        let v10 = OfferEscrowBinding{
            offer       : v9,
            product     : 0x2::object::id<Product>(arg2),
            buyer       : v0,
            seller      : v1,
            quantity    : arg5,
            total_price : v2,
        };
        0x2::dynamic_field::add<0x2::object::ID, OfferEscrowBinding>(&mut arg0.id, 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg3), v10);
        let v11 = PurchaseOfferCreated{
            offer_id      : v9,
            product       : 0x2::object::id<Product>(arg2),
            escrow        : 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg3),
            buyer         : v0,
            seller        : v1,
            unit_price    : arg4,
            quantity      : arg5,
            total_price   : v2,
            buyer_deposit : v5,
        };
        0x2::event::emit<PurchaseOfferCreated>(v11);
        0x2::transfer::share_object<PurchaseOffer>(v8);
    }

    public fun create_special_order_record(arg0: &mut MerchantRegistry, arg1: &MerchantProfile, arg2: &mut Product, arg3: &mut SpecialPriceOffer, arg4: &0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = arg2.merchant;
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg1.authority == v1, 0);
        assert!(arg1.active, 3);
        assert!(arg2.active, 6);
        assert!(!arg2.deleted, 6);
        assert!(arg3.product == 0x2::object::id<Product>(arg2), 34);
        assert!(arg3.seller == v1, 0);
        assert!(arg3.buyer == v0, 33);
        assert!(arg3.active, 32);
        assert!(!arg3.used, 32);
        assert!(arg3.unit_price > 0, 30);
        assert!(arg3.quantity > 0, 8);
        assert!(arg2.stock >= arg3.quantity, 9);
        let v3 = arg3.quantity;
        let v4 = arg3.unit_price;
        let v5 = checked_mul(v4, (v3 as u64));
        let v6 = checked_mul(v5, effective_deposit_bps(arg2, arg1)) / 10000;
        let v7 = v6;
        if (v6 == 0) {
            v7 = 1;
        };
        let v8 = checked_add_u64(v5, v7);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg4) == 0, 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::creator(arg4) == v0, 11);
        assert!(contains_solzaar_marker(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::note(arg4)), 10);
        let v9 = 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_a_address(arg4);
        let v10 = 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_b_address(arg4);
        assert!(v9 == v0, 11);
        assert!(v10 == v1, 11);
        assert!(v9 != v10, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::reference_amount(arg4) == v5, 12);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::required_deposit_a(arg4) == v8, 15);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_a(arg4) == v8, 13);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::required_deposit_b(arg4) == v7, 14);
        arg3.used = true;
        arg3.active = false;
        arg2.stock = arg2.stock - v3;
        arg2.updated_at = v2;
        let v11 = OrderRecord{
            id                      : 0x2::object::new(arg6),
            escrow                  : 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg4),
            product                 : 0x2::object::id<Product>(arg2),
            buyer                   : v0,
            seller                  : v1,
            quantity                : v3,
            unit_price              : v4,
            total_price             : v5,
            security_deposit        : v7,
            completed_sale_recorded : false,
            stock_restored          : false,
            reviewed                : false,
            created_at              : v2,
        };
        let v12 = OrderCreated{
            order_id    : 0x2::object::uid_to_inner(&v11.id),
            escrow_id   : 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg4),
            product_id  : 0x2::object::id<Product>(arg2),
            buyer       : v0,
            seller      : v1,
            quantity    : v3,
            total_price : v5,
        };
        0x2::event::emit<OrderCreated>(v12);
        bind_escrow(arg0, 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg4));
        0x2::transfer::share_object<OrderRecord>(v11);
    }

    public fun create_special_price_offer(arg0: &Product, arg1: address, arg2: u64, arg3: u32, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.merchant, 0);
        assert!(arg0.active, 6);
        assert!(!arg0.deleted, 6);
        assert!(arg1 != v0, 11);
        assert!(arg2 > 0, 30);
        assert!(arg3 > 0, 8);
        assert!(arg0.stock >= arg3, 9);
        let v1 = SpecialPriceOffer{
            id         : 0x2::object::new(arg5),
            product    : 0x2::object::id<Product>(arg0),
            seller     : v0,
            buyer      : arg1,
            unit_price : arg2,
            quantity   : arg3,
            active     : true,
            used       : false,
            created_at : 0x2::clock::timestamp_ms(arg4),
        };
        let v2 = SpecialPriceOffered{
            offer_id   : 0x2::object::uid_to_inner(&v1.id),
            product    : 0x2::object::id<Product>(arg0),
            seller     : v0,
            buyer      : arg1,
            unit_price : arg2,
            quantity   : arg3,
        };
        0x2::event::emit<SpecialPriceOffered>(v2);
        0x2::transfer::share_object<SpecialPriceOffer>(v1);
    }

    public fun decline_mutual_cancellation(arg0: &OrderRecord, arg1: &mut 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow, arg2: &0x2::tx_context::TxContext) {
        assert_order_escrow_match(arg0, arg1);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg1) == 2, 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::proposed_payout_a(arg1) == 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_a(arg1), 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::proposed_payout_b(arg1) == 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_b(arg1), 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::proposed_donation(arg1) == 0, 16);
        0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::reject_finalization(arg1, arg2);
    }

    public fun delete_product(arg0: &mut Product, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.merchant, 0);
        assert!(!arg0.deleted, 6);
        arg0.active = false;
        arg0.deleted = true;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg1);
        let v1 = ProductDeleted{
            product_object_id : 0x2::object::uid_to_inner(&arg0.id),
            merchant          : v0,
            product_id        : arg0.product_id,
        };
        0x2::event::emit<ProductDeleted>(v1);
    }

    fun effective_deposit_bps(arg0: &Product, arg1: &MerchantProfile) : u64 {
        if (0x1::option::is_some<u16>(&arg0.seller_deposit_bps_override)) {
            (*0x1::option::borrow<u16>(&arg0.seller_deposit_bps_override) as u64)
        } else {
            (arg1.seller_deposit_bps as u64)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MerchantRegistry{
            id        : 0x2::object::new(arg0),
            merchants : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<MerchantRegistry>(v0);
    }

    public fun merchant_active(arg0: &MerchantProfile) : bool {
        arg0.active
    }

    public fun merchant_authority(arg0: &MerchantProfile) : address {
        arg0.authority
    }

    public fun merchant_total_sold(arg0: &MerchantProfile) : u32 {
        arg0.total_sold
    }

    public fun message_buyer(arg0: &ChatMessage) : address {
        arg0.buyer
    }

    public fun message_created_at(arg0: &ChatMessage) : u64 {
        arg0.created_at
    }

    public fun message_product(arg0: &ChatMessage) : 0x2::object::ID {
        arg0.product
    }

    public fun message_recipient(arg0: &ChatMessage) : address {
        arg0.recipient
    }

    public fun message_seller(arg0: &ChatMessage) : address {
        arg0.seller
    }

    public fun message_sender(arg0: &ChatMessage) : address {
        arg0.sender
    }

    public fun order_buyer(arg0: &OrderRecord) : address {
        arg0.buyer
    }

    public fun order_completed_sale_recorded(arg0: &OrderRecord) : bool {
        arg0.completed_sale_recorded
    }

    public fun order_quantity(arg0: &OrderRecord) : u32 {
        arg0.quantity
    }

    public fun order_reviewed(arg0: &OrderRecord) : bool {
        arg0.reviewed
    }

    public fun order_security_deposit(arg0: &OrderRecord) : u64 {
        arg0.security_deposit
    }

    public fun order_seller(arg0: &OrderRecord) : address {
        arg0.seller
    }

    public fun order_stock_restored(arg0: &OrderRecord) : bool {
        arg0.stock_restored
    }

    public fun order_total_price(arg0: &OrderRecord) : u64 {
        arg0.total_price
    }

    public fun order_unit_price(arg0: &OrderRecord) : u64 {
        arg0.unit_price
    }

    public fun product_active(arg0: &Product) : bool {
        arg0.active
    }

    public fun product_deleted(arg0: &Product) : bool {
        arg0.deleted
    }

    public fun product_id(arg0: &Product) : u64 {
        arg0.product_id
    }

    public fun product_merchant(arg0: &Product) : address {
        arg0.merchant
    }

    public fun product_object_id(arg0: &Product) : 0x2::object::ID {
        0x2::object::id<Product>(arg0)
    }

    public fun product_price(arg0: &Product) : u64 {
        arg0.price
    }

    public fun product_sold(arg0: &Product) : u32 {
        arg0.sold
    }

    public fun product_stock(arg0: &Product) : u32 {
        arg0.stock
    }

    public fun purchase_offer_active(arg0: &PurchaseOffer) : bool {
        arg0.active
    }

    public fun purchase_offer_buyer_deposit(arg0: &PurchaseOffer) : u64 {
        arg0.buyer_deposit
    }

    public fun purchase_offer_total_price(arg0: &PurchaseOffer) : u64 {
        arg0.total_price
    }

    public fun purchase_offer_unit_price(arg0: &PurchaseOffer) : u64 {
        arg0.unit_price
    }

    public fun record_completed_sale(arg0: &mut MerchantProfile, arg1: &mut Product, arg2: &mut OrderRecord, arg3: &0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow) {
        assert!(arg2.escrow == 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg3), 16);
        assert!(arg2.product == 0x2::object::id<Product>(arg1), 16);
        assert!(arg2.seller == arg1.merchant, 11);
        assert!(arg0.authority == arg2.seller, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg3) == 3, 16);
        let v0 = if (0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::proposed_payout_a(arg3) == 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_a(arg3)) {
            if (0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::proposed_payout_b(arg3) == 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_b(arg3)) {
                0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::proposed_donation(arg3) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(!v0, 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_a_address(arg3) == arg2.buyer, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_b_address(arg3) == arg2.seller, 11);
        assert!(!arg2.completed_sale_recorded, 18);
        assert!(!arg2.stock_restored, 19);
        arg1.sold = checked_add_u32(arg1.sold, arg2.quantity);
        arg0.total_sold = checked_add_u32(arg0.total_sold, arg2.quantity);
        arg2.completed_sale_recorded = true;
    }

    public fun reject_purchase_offer(arg0: &mut PurchaseOffer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 0);
        let v0 = if (arg0.active) {
            if (!arg0.accepted) {
                if (!arg0.rejected) {
                    !arg0.withdrawn
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 36);
        arg0.active = false;
        arg0.rejected = true;
        let v1 = PurchaseOfferRejected{
            offer_id : 0x2::object::id<PurchaseOffer>(arg0),
            product  : arg0.product,
            escrow   : arg0.escrow,
            buyer    : arg0.buyer,
            seller   : arg0.seller,
        };
        0x2::event::emit<PurchaseOfferRejected>(v1);
    }

    public fun reputation_five_star(arg0: &MerchantReputation) : u64 {
        arg0.five_star
    }

    public fun reputation_four_star(arg0: &MerchantReputation) : u64 {
        arg0.four_star
    }

    public fun reputation_merchant(arg0: &MerchantReputation) : address {
        arg0.merchant
    }

    public fun reputation_one_star(arg0: &MerchantReputation) : u64 {
        arg0.one_star
    }

    public fun reputation_three_star(arg0: &MerchantReputation) : u64 {
        arg0.three_star
    }

    public fun reputation_total_rating(arg0: &MerchantReputation) : u64 {
        arg0.total_rating
    }

    public fun reputation_total_reviews(arg0: &MerchantReputation) : u64 {
        arg0.total_reviews
    }

    public fun reputation_two_star(arg0: &MerchantReputation) : u64 {
        arg0.two_star
    }

    public fun request_mutual_cancellation(arg0: &OrderRecord, arg1: &mut 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_order_escrow_match(arg0, arg1);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg1) == 1, 16);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 42);
        assert!(0x1::vector::length<u8>(&arg2) <= 180, 43);
        let v0 = b"MUTUAL_CANCELLATION|";
        0x1::vector::append<u8>(&mut v0, arg2);
        0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::suggest_finalization(arg1, 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_a(arg1), 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_b(arg1), 0, v0, arg3);
    }

    public fun restore_cancelled_order_stock(arg0: &mut Product, arg1: &mut OrderRecord, arg2: &0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow) {
        assert!(arg1.escrow == 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg2), 16);
        assert!(arg1.product == 0x2::object::id<Product>(arg0), 16);
        assert!(arg1.seller == arg0.merchant, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg2) == 4, 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_a_address(arg2) == arg1.buyer, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_b_address(arg2) == arg1.seller, 11);
        assert!(!arg1.stock_restored, 19);
        assert!(!arg1.completed_sale_recorded, 16);
        arg0.stock = checked_add_u32(arg0.stock, arg1.quantity);
        arg1.stock_restored = true;
    }

    public fun restore_mutually_cancelled_order_stock(arg0: &mut Product, arg1: &mut OrderRecord, arg2: &0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow) {
        assert!(arg1.escrow == 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg2), 16);
        assert!(arg1.product == 0x2::object::id<Product>(arg0), 16);
        assert!(arg1.seller == arg0.merchant, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg2) == 3, 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_a_address(arg2) == arg1.buyer, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_b_address(arg2) == arg1.seller, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::proposed_payout_a(arg2) == 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_a(arg2), 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::proposed_payout_b(arg2) == 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_b(arg2), 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::proposed_donation(arg2) == 0, 16);
        assert!(!arg1.stock_restored, 19);
        assert!(!arg1.completed_sale_recorded, 16);
        arg0.stock = checked_add_u32(arg0.stock, arg1.quantity);
        arg1.stock_restored = true;
    }

    public fun send_message(arg0: &Product, arg1: &0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_a_address(arg1);
        let v2 = 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_b_address(arg1);
        assert!(contains_solzaar_marker(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::note(arg1)), 10);
        assert!(arg0.merchant == v2 && v1 != v2, 11);
        assert!(v0 == v1 || v0 == v2, 0);
        assert!(0x1::string::length(&arg2) > 0, 28);
        assert!(0x1::string::length(&arg2) <= 280, 29);
        let v3 = if (v0 == v1) {
            v2
        } else {
            v1
        };
        let v4 = ChatMessage{
            id         : 0x2::object::new(arg4),
            product    : 0x2::object::id<Product>(arg0),
            buyer      : v1,
            seller     : v2,
            sender     : v0,
            recipient  : v3,
            message    : arg2,
            created_at : 0x2::clock::timestamp_ms(arg3),
        };
        let v5 = MessageSent{
            message_id : 0x2::object::id<ChatMessage>(&v4),
            product    : 0x2::object::id<Product>(arg0),
            buyer      : v1,
            seller     : v2,
            sender     : v0,
            recipient  : v3,
            created_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MessageSent>(v5);
        0x2::transfer::share_object<ChatMessage>(v4);
    }

    public fun send_product_message(arg0: &Product, arg1: address, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = arg0.merchant;
        assert!(!arg0.deleted, 6);
        assert!(arg1 != v1, 11);
        assert!(v0 == arg1 || v0 == v1, 0);
        assert!(0x1::string::length(&arg2) > 0, 28);
        assert!(0x1::string::length(&arg2) <= 280, 29);
        let v2 = if (v0 == arg1) {
            v1
        } else {
            arg1
        };
        let v3 = ChatMessage{
            id         : 0x2::object::new(arg4),
            product    : 0x2::object::id<Product>(arg0),
            buyer      : arg1,
            seller     : v1,
            sender     : v0,
            recipient  : v2,
            message    : arg2,
            created_at : 0x2::clock::timestamp_ms(arg3),
        };
        let v4 = MessageSent{
            message_id : 0x2::object::uid_to_inner(&v3.id),
            product    : 0x2::object::id<Product>(arg0),
            buyer      : arg1,
            seller     : v1,
            sender     : v0,
            recipient  : v2,
            created_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MessageSent>(v4);
        0x2::transfer::share_object<ChatMessage>(v3);
    }

    public fun special_offer_active(arg0: &SpecialPriceOffer) : bool {
        arg0.active
    }

    public fun special_offer_buyer(arg0: &SpecialPriceOffer) : address {
        arg0.buyer
    }

    public fun special_offer_created_at(arg0: &SpecialPriceOffer) : u64 {
        arg0.created_at
    }

    public fun special_offer_product(arg0: &SpecialPriceOffer) : 0x2::object::ID {
        arg0.product
    }

    public fun special_offer_quantity(arg0: &SpecialPriceOffer) : u32 {
        arg0.quantity
    }

    public fun special_offer_seller(arg0: &SpecialPriceOffer) : address {
        arg0.seller
    }

    public fun special_offer_unit_price(arg0: &SpecialPriceOffer) : u64 {
        arg0.unit_price
    }

    public fun special_offer_used(arg0: &SpecialPriceOffer) : bool {
        arg0.used
    }

    public fun submit_review(arg0: &MerchantProfile, arg1: &Product, arg2: &mut OrderRecord, arg3: &0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow, arg4: &mut MerchantReputation, arg5: u8, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg5 >= 1 && arg5 <= 5, 21);
        assert!(0x1::string::length(&arg6) <= 280, 22);
        assert!(v0 == arg2.buyer, 24);
        assert!(arg2.escrow == 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg3), 16);
        assert!(arg2.product == 0x2::object::id<Product>(arg1), 25);
        assert!(arg2.seller == arg1.merchant, 26);
        assert!(arg0.authority == arg2.seller, 26);
        assert!(arg4.merchant == arg2.seller, 26);
        assert!(arg2.completed_sale_recorded, 23);
        assert!(!arg2.stock_restored, 23);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg3) == 3, 23);
        assert!(!arg2.reviewed, 27);
        let v1 = ProductReview{
            id         : 0x2::object::new(arg8),
            order      : 0x2::object::id<OrderRecord>(arg2),
            escrow     : 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg3),
            product    : 0x2::object::id<Product>(arg1),
            merchant   : arg2.seller,
            reviewer   : v0,
            rating     : arg5,
            comment    : arg6,
            created_at : 0x2::clock::timestamp_ms(arg7),
        };
        arg4.total_reviews = arg4.total_reviews + 1;
        arg4.total_rating = arg4.total_rating + (arg5 as u64);
        if (arg5 == 5) {
            arg4.five_star = arg4.five_star + 1;
        } else if (arg5 == 4) {
            arg4.four_star = arg4.four_star + 1;
        } else if (arg5 == 3) {
            arg4.three_star = arg4.three_star + 1;
        } else if (arg5 == 2) {
            arg4.two_star = arg4.two_star + 1;
        } else {
            arg4.one_star = arg4.one_star + 1;
        };
        arg2.reviewed = true;
        let v2 = ReviewCreated{
            review_id  : 0x2::object::id<ProductReview>(&v1),
            order_id   : 0x2::object::id<OrderRecord>(arg2),
            escrow_id  : 0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg3),
            product_id : 0x2::object::id<Product>(arg1),
            merchant   : arg2.seller,
            reviewer   : v0,
            rating     : arg5,
        };
        0x2::event::emit<ReviewCreated>(v2);
        0x2::transfer::share_object<ProductReview>(v1);
    }

    public fun update_merchant(arg0: &mut MerchantProfile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u16, arg7: 0x1::string::String, arg8: bool, arg9: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(v0 == arg0.authority, 0);
        assert!(0x1::string::length(&arg1) <= 64, 1);
        assert!(0x1::string::length(&arg2) <= 200, 1);
        assert!(0x1::string::length(&arg3) <= 200, 1);
        assert!(0x1::string::length(&arg4) <= 200, 1);
        assert!(0x1::string::length(&arg5) <= 64, 1);
        assert!(0x1::string::length(&arg7) <= 300, 1);
        assert!((arg6 as u64) <= 10000, 7);
        arg0.store_name = arg1;
        arg0.description_uri = arg2;
        arg0.logo_uri = arg3;
        arg0.banner_uri = arg4;
        arg0.ships_from = arg5;
        arg0.seller_deposit_bps = arg6;
        arg0.preferred_contact = arg7;
        arg0.active = arg8;
        let v1 = MerchantUpdated{
            merchant_id : 0x2::object::uid_to_inner(&arg0.id),
            authority   : v0,
        };
        0x2::event::emit<MerchantUpdated>(v1);
    }

    public fun update_product(arg0: &mut Product, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: 0x1::string::String, arg5: u64, arg6: u32, arg7: bool, arg8: 0x1::option::Option<u16>, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(v0 == arg0.merchant, 0);
        assert!(!arg0.deleted, 6);
        validate_product_fields(&arg1, &arg2, &arg3, &arg4, arg5);
        validate_deposit_override(&arg8);
        arg0.title = arg1;
        arg0.description_uri = arg2;
        arg0.image_uris = arg3;
        arg0.category = arg4;
        arg0.price = arg5;
        arg0.seller_deposit_bps_override = arg8;
        arg0.stock = arg6;
        arg0.active = arg7;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg9);
        let v1 = ProductUpdated{
            product_object_id : 0x2::object::uid_to_inner(&arg0.id),
            merchant          : v0,
            product_id        : arg0.product_id,
        };
        0x2::event::emit<ProductUpdated>(v1);
    }

    fun validate_deposit_override(arg0: &0x1::option::Option<u16>) {
        if (0x1::option::is_some<u16>(arg0)) {
            assert!((*0x1::option::borrow<u16>(arg0) as u64) <= 10000, 7);
        };
    }

    fun validate_product_fields(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &vector<0x1::string::String>, arg3: &0x1::string::String, arg4: u64) {
        assert!(0x1::string::length(arg0) <= 64, 1);
        assert!(0x1::string::length(arg1) <= 200, 1);
        assert!(0x1::vector::length<0x1::string::String>(arg2) <= 3, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg2)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(arg2, v0);
            assert!(0x1::string::length(v1) > 0, 5);
            assert!(0x1::string::length(v1) <= 250, 1);
            v0 = v0 + 1;
        };
        assert!(0x1::string::length(arg3) <= 32, 1);
        assert!(arg4 > 0, 2);
    }

    public fun withdraw_purchase_offer(arg0: &mut PurchaseOffer, arg1: &mut 0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.buyer, 0);
        let v1 = if (!arg0.accepted) {
            if (!arg0.withdrawn) {
                arg0.active || arg0.rejected
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 36);
        assert!(0x2::object::id<0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::Escrow>(arg1) == arg0.escrow, 39);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg1) == 0, 16);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::creator(arg1) == v0, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_a_address(arg1) == v0, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::party_b_address(arg1) == arg0.seller, 11);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_a(arg1) == arg0.buyer_deposit, 13);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::deposited_b(arg1) == 0, 14);
        0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::withdraw_before_complete(arg1, arg2);
        assert!(0x604881d2abfa8334c19393f6aaeb9292c83fb6a79fb87313a02dd99a8f1d842::escrow::status(arg1) == 4, 16);
        arg0.active = false;
        arg0.withdrawn = true;
        let v2 = PurchaseOfferWithdrawn{
            offer_id : 0x2::object::id<PurchaseOffer>(arg0),
            product  : arg0.product,
            escrow   : arg0.escrow,
            buyer    : arg0.buyer,
            seller   : arg0.seller,
        };
        0x2::event::emit<PurchaseOfferWithdrawn>(v2);
    }

    // decompiled from Move bytecode v7
}

