module 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt {
    struct OrderReceipt has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        buyer: address,
        payment_amount: u64,
        created_at: u64,
        updated_at: u64,
        items_selected: 0x1::string::String,
        status: u8,
        tracking_number: 0x1::string::String,
        carrier: 0x1::string::String,
        estimated_delivery: u64,
        encrypted_shipping_info: 0x1::string::String,
        encryption_pubkey: 0x1::string::String,
    }

    struct ReceiptRegistry has key {
        id: 0x2::object::UID,
        total_receipts: u64,
    }

    struct ReceiptCreated has copy, drop {
        receipt_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        buyer: address,
        payment_amount: u64,
        timestamp: u64,
    }

    struct ReceiptUpdated has copy, drop {
        receipt_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
        updated_by: address,
        timestamp: u64,
    }

    struct TrackingInfoAdded has copy, drop {
        receipt_id: 0x2::object::ID,
        tracking_number: 0x1::string::String,
        carrier: 0x1::string::String,
        estimated_delivery: u64,
        timestamp: u64,
    }

    struct ShippingInfoUpdated has copy, drop {
        receipt_id: 0x2::object::ID,
        updated_by: address,
        timestamp: u64,
    }

    struct OrderReceiptBurned has copy, drop {
        receipt_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        buyer: address,
        by: address,
        timestamp: u64,
    }

    public(friend) fun add_tracking_info(arg0: &mut OrderReceipt, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status >= 1, 3);
        arg0.tracking_number = arg1;
        arg0.carrier = arg2;
        arg0.estimated_delivery = arg3;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg4);
        let v0 = TrackingInfoAdded{
            receipt_id         : 0x2::object::uid_to_inner(&arg0.id),
            tracking_number    : arg1,
            carrier            : arg2,
            estimated_delivery : arg3,
            timestamp          : arg0.updated_at,
        };
        0x2::event::emit<TrackingInfoAdded>(v0);
    }

    public(friend) fun burn_receipt(arg0: OrderReceipt, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(arg0.status == 2, 4);
        let OrderReceipt {
            id                      : v0,
            nft_id                  : v1,
            buyer                   : v2,
            payment_amount          : _,
            created_at              : _,
            updated_at              : _,
            items_selected          : _,
            status                  : _,
            tracking_number         : _,
            carrier                 : _,
            estimated_delivery      : _,
            encrypted_shipping_info : _,
            encryption_pubkey       : _,
        } = arg0;
        let v13 = v0;
        let v14 = OrderReceiptBurned{
            receipt_id : 0x2::object::uid_to_inner(&v13),
            nft_id     : v1,
            buyer      : v2,
            by         : arg1,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OrderReceiptBurned>(v14);
        0x2::object::delete(v13);
    }

    public(friend) fun create_receipt(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::object::new(arg7);
        let v2 = OrderReceipt{
            id                      : v1,
            nft_id                  : arg0,
            buyer                   : arg1,
            payment_amount          : arg5,
            created_at              : v0,
            updated_at              : v0,
            items_selected          : arg2,
            status                  : 0,
            tracking_number         : 0x1::string::utf8(b""),
            carrier                 : 0x1::string::utf8(b""),
            estimated_delivery      : 0,
            encrypted_shipping_info : arg3,
            encryption_pubkey       : arg4,
        };
        let v3 = ReceiptCreated{
            receipt_id     : 0x2::object::uid_to_inner(&v1),
            nft_id         : arg0,
            buyer          : arg1,
            payment_amount : arg5,
            timestamp      : v0,
        };
        0x2::event::emit<ReceiptCreated>(v3);
        0x2::transfer::share_object<OrderReceipt>(v2);
    }

    public fun get_buyer(arg0: &OrderReceipt) : address {
        arg0.buyer
    }

    public fun get_created_at(arg0: &OrderReceipt) : u64 {
        arg0.created_at
    }

    public fun get_nft_id(arg0: &OrderReceipt) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun get_payment_amount(arg0: &OrderReceipt) : u64 {
        arg0.payment_amount
    }

    public fun get_receipt_id(arg0: &OrderReceipt) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_receipt_info(arg0: &OrderReceipt) : (0x2::object::ID, address, u64, u64, u64) {
        (arg0.nft_id, arg0.buyer, arg0.payment_amount, arg0.created_at, arg0.updated_at)
    }

    public(friend) fun get_receipt_info_admin(arg0: &OrderReceipt) : (0x2::object::ID, address, 0x1::string::String, u64, u8, u64, u64, 0x1::string::String, 0x1::string::String, u64, 0x1::string::String, 0x1::string::String) {
        (arg0.nft_id, arg0.buyer, arg0.items_selected, arg0.payment_amount, arg0.status, arg0.created_at, arg0.updated_at, arg0.tracking_number, arg0.carrier, arg0.estimated_delivery, arg0.encrypted_shipping_info, arg0.encryption_pubkey)
    }

    public fun get_updated_at(arg0: &OrderReceipt) : u64 {
        arg0.updated_at
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReceiptRegistry{
            id             : 0x2::object::new(arg0),
            total_receipts : 0,
        };
        0x2::transfer::share_object<ReceiptRegistry>(v0);
    }

    public(friend) fun update_encrypted_shipping(arg0: &mut OrderReceipt, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.encrypted_shipping_info = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = ShippingInfoUpdated{
            receipt_id : 0x2::object::uid_to_inner(&arg0.id),
            updated_by : arg0.buyer,
            timestamp  : arg0.updated_at,
        };
        0x2::event::emit<ShippingInfoUpdated>(v0);
    }

    public(friend) fun update_status(arg0: &mut OrderReceipt, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 2, 2);
        arg0.status = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = ReceiptUpdated{
            receipt_id : 0x2::object::uid_to_inner(&arg0.id),
            old_status : arg0.status,
            new_status : arg1,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : arg0.updated_at,
        };
        0x2::event::emit<ReceiptUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

