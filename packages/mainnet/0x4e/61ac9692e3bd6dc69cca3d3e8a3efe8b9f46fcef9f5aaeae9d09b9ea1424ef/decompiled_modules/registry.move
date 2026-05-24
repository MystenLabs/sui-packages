module 0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::registry {
    struct Dataset has copy, drop, store {
        title: vector<u8>,
        blob_id: vector<u8>,
        seal_policy_id: vector<u8>,
        price: u64,
        seller: address,
        created_at: u64,
    }

    struct DatasetRegistry has key {
        id: 0x2::object::UID,
        datasets: vector<Dataset>,
    }

    struct DatasetRegistered has copy, drop {
        dataset_id: u64,
        blob_id: vector<u8>,
        seal_policy_id: vector<u8>,
        price: u64,
        seller: address,
    }

    public fun blob_id(arg0: &DatasetRegistry, arg1: u64) : vector<u8> {
        let v0 = get_dataset(arg0, arg1);
        v0.blob_id
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) : DatasetRegistry {
        DatasetRegistry{
            id       : 0x2::object::new(arg0),
            datasets : 0x1::vector::empty<Dataset>(),
        }
    }

    public fun dataset_count(arg0: &DatasetRegistry) : u64 {
        0x1::vector::length<Dataset>(&arg0.datasets)
    }

    public fun get_dataset(arg0: &DatasetRegistry, arg1: u64) : Dataset {
        assert!(arg1 < 0x1::vector::length<Dataset>(&arg0.datasets), 3);
        *0x1::vector::borrow<Dataset>(&arg0.datasets, arg1)
    }

    public fun price(arg0: &DatasetRegistry, arg1: u64) : u64 {
        let v0 = get_dataset(arg0, arg1);
        v0.price
    }

    public fun publish_registry(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<DatasetRegistry>(create_registry(arg0));
    }

    public fun register_dataset(arg0: &mut DatasetRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::vector::length<Dataset>(&arg0.datasets);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<Dataset>(&arg0.datasets, v2);
            assert!(v3.blob_id != arg2, 2);
            v2 = v2 + 1;
        };
        let v4 = Dataset{
            title          : arg1,
            blob_id        : arg2,
            seal_policy_id : arg3,
            price          : arg4,
            seller         : v0,
            created_at     : arg5,
        };
        0x1::vector::push_back<Dataset>(&mut arg0.datasets, v4);
        let v5 = DatasetRegistered{
            dataset_id     : v1,
            blob_id        : 0x1::vector::borrow<Dataset>(&arg0.datasets, v1).blob_id,
            seal_policy_id : 0x1::vector::borrow<Dataset>(&arg0.datasets, v1).seal_policy_id,
            price          : arg4,
            seller         : v0,
        };
        0x2::event::emit<DatasetRegistered>(v5);
        v1
    }

    public fun seal_policy_id(arg0: &DatasetRegistry, arg1: u64) : vector<u8> {
        let v0 = get_dataset(arg0, arg1);
        v0.seal_policy_id
    }

    public fun seller(arg0: &DatasetRegistry, arg1: u64) : address {
        let v0 = get_dataset(arg0, arg1);
        v0.seller
    }

    // decompiled from Move bytecode v7
}

