module 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::set_oracle_queue_id_action {
    struct OracleQueueIdSet has copy, drop {
        old_oracle_queue_id: 0x2::object::ID,
        oracle_queue_id: 0x2::object::ID,
    }

    fun actuate(arg0: &mut 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::on_demand::State, arg1: 0x2::object::ID) {
        let v0 = OracleQueueIdSet{
            old_oracle_queue_id : 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::on_demand::oracle_queue(arg0),
            oracle_queue_id     : arg1,
        };
        0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::on_demand::set_oracle_queue_id(arg0, arg1);
        0x2::event::emit<OracleQueueIdSet>(v0);
    }

    public entry fun run(arg0: &0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::on_demand::AdminCap, arg1: &mut 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::on_demand::State, arg2: 0x2::object::ID) {
        validate();
        actuate(arg1, arg2);
    }

    public fun validate() {
    }

    // decompiled from Move bytecode v6
}

