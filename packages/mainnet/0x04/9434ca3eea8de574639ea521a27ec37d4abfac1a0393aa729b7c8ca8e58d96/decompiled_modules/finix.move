module 0x49434ca3eea8de574639ea521a27ec37d4abfac1a0393aa729b7c8ca8e58d96::finix {
    struct MonthlyBlob has store, key {
        id: 0x2::object::UID,
        month: 0x1::string::String,
        blob_id: 0x1::string::String,
        enc_ref: 0x1::string::String,
        tx_count: u64,
        created_at: u64,
        version: u64,
    }

    struct UserRegistry has store, key {
        id: 0x2::object::UID,
        owner: address,
        blob_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public fun blob_count(arg0: &UserRegistry) : u64 {
        0x2::vec_set::size<0x2::object::ID>(&arg0.blob_ids)
    }

    public fun blob_id(arg0: &MonthlyBlob) : &0x1::string::String {
        &arg0.blob_id
    }

    public fun create_blob_entry(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) <= 200, 1);
        assert!(0x1::string::length(&arg2) <= 200, 2);
        let v0 = MonthlyBlob{
            id         : 0x2::object::new(arg4),
            month      : arg0,
            blob_id    : arg1,
            enc_ref    : arg2,
            tx_count   : arg3,
            created_at : 0x2::tx_context::epoch_timestamp_ms(arg4),
            version    : 1,
        };
        0x2::transfer::transfer<MonthlyBlob>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = UserRegistry{
            id       : 0x2::object::new(arg0),
            owner    : v0,
            blob_ids : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::transfer<UserRegistry>(v1, v0);
    }

    public fun enc_ref(arg0: &MonthlyBlob) : &0x1::string::String {
        &arg0.enc_ref
    }

    public fun get_blob_ids(arg0: &UserRegistry) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.blob_ids
    }

    public fun has_blob(arg0: &UserRegistry, arg1: &0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.blob_ids, arg1)
    }

    public fun month(arg0: &MonthlyBlob) : &0x1::string::String {
        &arg0.month
    }

    public fun register_blob(arg0: &mut UserRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.blob_ids, &arg1), 3);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.blob_ids, arg1);
    }

    public fun tx_count(arg0: &MonthlyBlob) : u64 {
        arg0.tx_count
    }

    // decompiled from Move bytecode v7
}

