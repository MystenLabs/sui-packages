module 0xa6609a0be8baa03b8fe626aff3f6634904c94d9be9afe2c2332e8e2fc384de38::receipt {
    struct PurchaseReceipt has store, key {
        id: 0x2::object::UID,
        blob_id: 0x1::string::String,
        store_name: 0x1::string::String,
        purchase_date: 0x1::string::String,
        total_cents: u64,
        currency: 0x1::string::String,
        category: 0x1::string::String,
        warranty_expiry: 0x1::string::String,
        content_hash: 0x1::string::String,
        owner: address,
        version: u64,
        created_at: u64,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
    }

    struct ReceiptMinted has copy, drop {
        receipt_id: address,
        blob_id: 0x1::string::String,
        owner: address,
        store_name: 0x1::string::String,
        total_cents: u64,
        category: 0x1::string::String,
    }

    struct ReceiptUpdated has copy, drop {
        receipt_id: address,
        new_blob_id: 0x1::string::String,
        version: u64,
    }

    public entry fun add_line_item(arg0: &mut PurchaseReceipt, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(arg1), arg2);
    }

    public fun blob_id(arg0: &PurchaseReceipt) : &0x1::string::String {
        &arg0.blob_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MintCap>(v0);
    }

    public entry fun mint_receipt(arg0: &MintCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::object::new(arg10);
        let v2 = PurchaseReceipt{
            id              : v1,
            blob_id         : 0x1::string::utf8(arg1),
            store_name      : 0x1::string::utf8(arg2),
            purchase_date   : 0x1::string::utf8(arg3),
            total_cents     : arg4,
            currency        : 0x1::string::utf8(arg5),
            category        : 0x1::string::utf8(arg6),
            warranty_expiry : 0x1::string::utf8(arg7),
            content_hash    : 0x1::string::utf8(arg8),
            owner           : v0,
            version         : 1,
            created_at      : arg9,
        };
        let v3 = ReceiptMinted{
            receipt_id  : 0x2::object::uid_to_address(&v1),
            blob_id     : v2.blob_id,
            owner       : v0,
            store_name  : v2.store_name,
            total_cents : arg4,
            category    : v2.category,
        };
        0x2::event::emit<ReceiptMinted>(v3);
        0x2::transfer::transfer<PurchaseReceipt>(v2, v0);
    }

    public fun owner(arg0: &PurchaseReceipt) : address {
        arg0.owner
    }

    public fun total_cents(arg0: &PurchaseReceipt) : u64 {
        arg0.total_cents
    }

    public entry fun update_blob(arg0: &mut PurchaseReceipt, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        arg0.blob_id = 0x1::string::utf8(arg1);
        arg0.content_hash = 0x1::string::utf8(arg2);
        arg0.version = arg0.version + 1;
        let v0 = ReceiptUpdated{
            receipt_id  : 0x2::object::uid_to_address(&arg0.id),
            new_blob_id : arg0.blob_id,
            version     : arg0.version,
        };
        0x2::event::emit<ReceiptUpdated>(v0);
    }

    public fun version(arg0: &PurchaseReceipt) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

