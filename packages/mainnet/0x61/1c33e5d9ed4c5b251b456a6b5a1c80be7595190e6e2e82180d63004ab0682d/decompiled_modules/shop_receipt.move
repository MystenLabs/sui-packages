module 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_receipt {
    struct ShopReceiptRegistry has key {
        id: 0x2::object::UID,
        total_receipts: u64,
        receipt_ids: vector<0x2::object::ID>,
    }

    struct ShopReceipt has key {
        id: 0x2::object::UID,
        item_id: 0x2::object::ID,
        item_name: 0x1::string::String,
        item_type: u8,
        buyer: address,
        chosen_size: 0x1::string::String,
        chosen_color: 0x1::string::String,
        custom_print_nft_id: 0x1::option::Option<0x2::object::ID>,
        quantity: u64,
        payment_amount: u64,
        encrypted_shipping_info: 0x1::string::String,
        encryption_pubkey: 0x1::string::String,
        status: u8,
        tracking_number: 0x1::string::String,
        carrier: 0x1::string::String,
        estimated_delivery: u64,
        created_at: u64,
        updated_at: u64,
    }

    struct ShopReceiptCreated has copy, drop {
        receipt_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        item_name: 0x1::string::String,
        buyer: address,
        quantity: u64,
        payment_amount: u64,
        has_custom_print: bool,
        timestamp: u64,
    }

    struct ShopReceiptStatusUpdated has copy, drop {
        receipt_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
        updated_by: address,
        timestamp: u64,
    }

    struct ShopTrackingAdded has copy, drop {
        receipt_id: 0x2::object::ID,
        tracking_number: 0x1::string::String,
        carrier: 0x1::string::String,
        estimated_delivery: u64,
        timestamp: u64,
    }

    struct ShopReceiptBurned has copy, drop {
        receipt_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        buyer: address,
        by: address,
        timestamp: u64,
    }

    public fun get_item_id(arg0: &ShopReceipt) : 0x2::object::ID {
        arg0.item_id
    }

    public(friend) fun burn_receipt(arg0: &mut ShopReceiptRegistry, arg1: ShopReceipt, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(arg1.status == 2, 6);
        let ShopReceipt {
            id                      : v0,
            item_id                 : v1,
            item_name               : _,
            item_type               : _,
            buyer                   : v4,
            chosen_size             : _,
            chosen_color            : _,
            custom_print_nft_id     : _,
            quantity                : _,
            payment_amount          : _,
            encrypted_shipping_info : _,
            encryption_pubkey       : _,
            status                  : _,
            tracking_number         : _,
            carrier                 : _,
            estimated_delivery      : _,
            created_at              : _,
            updated_at              : _,
        } = arg1;
        let v18 = v0;
        let v19 = 0x2::object::uid_to_inner(&v18);
        let (v20, v21) = 0x1::vector::index_of<0x2::object::ID>(&arg0.receipt_ids, &v19);
        if (v20) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.receipt_ids, v21);
            arg0.total_receipts = arg0.total_receipts - 1;
        };
        let v22 = ShopReceiptBurned{
            receipt_id : v19,
            item_id    : v1,
            buyer      : v4,
            by         : arg2,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ShopReceiptBurned>(v22);
        0x2::object::delete(v18);
    }

    public fun get_all_receipt_ids(arg0: &ShopReceiptRegistry) : vector<0x2::object::ID> {
        arg0.receipt_ids
    }

    public fun get_buyer(arg0: &ShopReceipt) : address {
        arg0.buyer
    }

    public fun get_chosen_color(arg0: &ShopReceipt) : 0x1::string::String {
        arg0.chosen_color
    }

    public fun get_chosen_size(arg0: &ShopReceipt) : 0x1::string::String {
        arg0.chosen_size
    }

    public fun get_custom_print_nft_id(arg0: &ShopReceipt) : 0x1::option::Option<0x2::object::ID> {
        arg0.custom_print_nft_id
    }

    public fun get_quantity(arg0: &ShopReceipt) : u64 {
        arg0.quantity
    }

    public fun get_receipt_id(arg0: &ShopReceipt) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_receipt_info_admin(arg0: &ShopReceipt) : (0x2::object::ID, 0x1::string::String, u8, address, 0x1::string::String, 0x1::string::String, 0x1::option::Option<0x2::object::ID>, u64, u64, u8, u64, u64, 0x1::string::String, 0x1::string::String, u64, 0x1::string::String, 0x1::string::String) {
        (arg0.item_id, arg0.item_name, arg0.item_type, arg0.buyer, arg0.chosen_size, arg0.chosen_color, arg0.custom_print_nft_id, arg0.quantity, arg0.payment_amount, arg0.status, arg0.created_at, arg0.updated_at, arg0.tracking_number, arg0.carrier, arg0.estimated_delivery, arg0.encrypted_shipping_info, arg0.encryption_pubkey)
    }

    public fun get_receipt_info_public(arg0: &ShopReceipt) : (0x2::object::ID, 0x1::string::String, address, u64, u8, u64) {
        (arg0.item_id, arg0.item_name, arg0.buyer, arg0.payment_amount, arg0.status, arg0.created_at)
    }

    public fun get_status(arg0: &ShopReceipt) : u8 {
        arg0.status
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ShopReceiptRegistry{
            id             : 0x2::object::new(arg0),
            total_receipts : 0,
            receipt_ids    : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<ShopReceiptRegistry>(v0);
    }

    public fun purchase(arg0: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::ShopItem, arg1: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::TreasuryConfig, arg2: &mut ShopReceiptRegistry, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::is_available(arg0), 5);
        let v0 = 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::get_price_mist(arg0) * arg4;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0, 4);
        let v1 = 0;
        while (v1 < arg4) {
            0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::decrement_stock(arg0, arg10);
            v1 = v1 + 1;
        };
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        if (v2 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2 - v0, arg11), 0x2::tx_context::sender(arg11));
        };
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::process_payment(arg1, arg3, 2, arg11);
        let v3 = if (0x1::vector::length<u8>(&arg7) == 32) {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_bytes(arg7))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        let v4 = v3;
        let v5 = 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::get_name(arg0);
        let v6 = 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::get_item_id(arg0);
        let v7 = 0x2::clock::timestamp_ms(arg10);
        let v8 = 0x2::object::new(arg11);
        let v9 = 0x2::object::uid_to_inner(&v8);
        let v10 = ShopReceipt{
            id                      : v8,
            item_id                 : v6,
            item_name               : v5,
            item_type               : 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::get_item_type(arg0),
            buyer                   : 0x2::tx_context::sender(arg11),
            chosen_size             : arg5,
            chosen_color            : arg6,
            custom_print_nft_id     : v4,
            quantity                : arg4,
            payment_amount          : v0,
            encrypted_shipping_info : arg8,
            encryption_pubkey       : arg9,
            status                  : 0,
            tracking_number         : 0x1::string::utf8(b""),
            carrier                 : 0x1::string::utf8(b""),
            estimated_delivery      : 0,
            created_at              : v7,
            updated_at              : v7,
        };
        let v11 = ShopReceiptCreated{
            receipt_id       : v9,
            item_id          : v6,
            item_name        : v5,
            buyer            : 0x2::tx_context::sender(arg11),
            quantity         : arg4,
            payment_amount   : v0,
            has_custom_print : 0x1::option::is_some<0x2::object::ID>(&v4),
            timestamp        : v7,
        };
        0x2::event::emit<ShopReceiptCreated>(v11);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.receipt_ids, v9);
        arg2.total_receipts = arg2.total_receipts + 1;
        0x2::transfer::share_object<ShopReceipt>(v10);
    }

    public(friend) fun set_tracking_info(arg0: &mut ShopReceipt, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg0.status >= 1, 2);
        arg0.tracking_number = arg1;
        arg0.carrier = arg2;
        arg0.estimated_delivery = arg3;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg4);
        let v0 = ShopTrackingAdded{
            receipt_id         : 0x2::object::uid_to_inner(&arg0.id),
            tracking_number    : arg1,
            carrier            : arg2,
            estimated_delivery : arg3,
            timestamp          : arg0.updated_at,
        };
        0x2::event::emit<ShopTrackingAdded>(v0);
    }

    public fun status_delivered() : u8 {
        2
    }

    public fun status_pending() : u8 {
        0
    }

    public fun status_shipped() : u8 {
        1
    }

    public fun total_receipts(arg0: &ShopReceiptRegistry) : u64 {
        arg0.total_receipts
    }

    public(friend) fun update_status_delivered(arg0: &mut ShopReceipt, arg1: address, arg2: &0x2::clock::Clock) {
        arg0.status = 2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = ShopReceiptStatusUpdated{
            receipt_id : 0x2::object::uid_to_inner(&arg0.id),
            old_status : arg0.status,
            new_status : 2,
            updated_by : arg1,
            timestamp  : arg0.updated_at,
        };
        0x2::event::emit<ShopReceiptStatusUpdated>(v0);
    }

    public(friend) fun update_status_shipped(arg0: &mut ShopReceipt, arg1: address, arg2: &0x2::clock::Clock) {
        arg0.status = 1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = ShopReceiptStatusUpdated{
            receipt_id : 0x2::object::uid_to_inner(&arg0.id),
            old_status : arg0.status,
            new_status : 1,
            updated_by : arg1,
            timestamp  : arg0.updated_at,
        };
        0x2::event::emit<ShopReceiptStatusUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

