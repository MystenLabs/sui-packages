module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt_registry {
    struct ReceiptRegistry has store, key {
        id: 0x2::object::UID,
        used_receipts: 0x2::table::Table<0x1::string::String, bool>,
        total_minted: u64,
        receipt_count: u64,
    }

    public(friend) fun borrow_used_receipts(arg0: &mut ReceiptRegistry) : &mut 0x2::table::Table<0x1::string::String, bool> {
        &mut arg0.used_receipts
    }

    public(friend) fun get_receipt_count(arg0: &ReceiptRegistry) : u64 {
        arg0.receipt_count
    }

    public(friend) fun get_total_minted(arg0: &ReceiptRegistry) : u64 {
        arg0.total_minted
    }

    public(friend) fun get_used_receipts(arg0: &ReceiptRegistry) : &0x2::table::Table<0x1::string::String, bool> {
        &arg0.used_receipts
    }

    public(friend) fun increment_receipt_count_by(arg0: &mut ReceiptRegistry, arg1: u64) {
        arg0.receipt_count = arg0.receipt_count + arg1;
    }

    public(friend) fun increment_total_minted_by(arg0: &mut ReceiptRegistry, arg1: u64) {
        arg0.total_minted = arg0.total_minted + arg1;
    }

    public(friend) fun new_receipt_registry(arg0: &mut 0x2::tx_context::TxContext) : ReceiptRegistry {
        ReceiptRegistry{
            id            : 0x2::object::new(arg0),
            used_receipts : 0x2::table::new<0x1::string::String, bool>(arg0),
            total_minted  : 0,
            receipt_count : 0,
        }
    }

    // decompiled from Move bytecode v6
}

