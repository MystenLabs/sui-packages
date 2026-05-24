module 0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::tamind {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::registry::publish_registry(arg0);
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun purchase_dataset_entry(arg0: &0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::registry::DatasetRegistry, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::escrow::deliver_receipt(0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::escrow::purchase_dataset(arg0, arg1, arg2, arg3), arg3);
    }

    entry fun register_dataset_entry(arg0: &mut 0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::registry::DatasetRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::registry::register_dataset(arg0, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6);
    }

    // decompiled from Move bytecode v7
}

