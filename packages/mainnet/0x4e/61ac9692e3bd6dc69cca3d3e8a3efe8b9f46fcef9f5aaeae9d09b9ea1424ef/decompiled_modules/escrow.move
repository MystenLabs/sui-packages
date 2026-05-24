module 0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::escrow {
    struct PurchaseReceipt has store, key {
        id: 0x2::object::UID,
        dataset_id: u64,
        buyer: address,
        blob_id: vector<u8>,
        seal_policy_id: vector<u8>,
    }

    struct PurchaseEvent has copy, drop {
        dataset_id: u64,
        buyer: address,
        blob_id: vector<u8>,
        seal_policy_id: vector<u8>,
        price: u64,
    }

    public fun deliver_receipt(arg0: PurchaseReceipt, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PurchaseReceipt>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun purchase_dataset(arg0: &0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::registry::DatasetRegistry, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : PurchaseReceipt {
        let v0 = 0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::registry::price(arg0, arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 10);
        let v1 = 0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::registry::blob_id(arg0, arg1);
        let v2 = 0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::registry::seal_policy_id(arg0, arg1);
        let v3 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg3), 0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::registry::seller(arg0, arg1));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v4 = PurchaseReceipt{
            id             : 0x2::object::new(arg3),
            dataset_id     : arg1,
            buyer          : v3,
            blob_id        : v1,
            seal_policy_id : v2,
        };
        let v5 = PurchaseEvent{
            dataset_id     : arg1,
            buyer          : v3,
            blob_id        : v1,
            seal_policy_id : v2,
            price          : v0,
        };
        0x2::event::emit<PurchaseEvent>(v5);
        v4
    }

    public fun receipt_blob_id(arg0: &PurchaseReceipt) : vector<u8> {
        arg0.blob_id
    }

    public fun receipt_buyer(arg0: &PurchaseReceipt) : address {
        arg0.buyer
    }

    public fun receipt_dataset_id(arg0: &PurchaseReceipt) : u64 {
        arg0.dataset_id
    }

    public fun receipt_seal_policy_id(arg0: &PurchaseReceipt) : vector<u8> {
        arg0.seal_policy_id
    }

    // decompiled from Move bytecode v7
}

