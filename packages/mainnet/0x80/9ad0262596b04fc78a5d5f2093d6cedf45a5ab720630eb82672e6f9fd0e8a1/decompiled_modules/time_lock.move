module 0x809ad0262596b04fc78a5d5f2093d6cedf45a5ab720630eb82672e6f9fd0e8a1::time_lock {
    struct Experiment has key {
        id: 0x2::object::UID,
        created_at: u64,
        walrus_blob_id: 0x1::option::Option<vector<u8>>,
    }

    fun check_policy(arg0: vector<u8>, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        0x1::vector::length<u8>(&v1) == 0 && 0x2::clock::timestamp_ms(arg1) >= 0x2::bcs::peel_u64(&mut v0)
    }

    public fun create_experiment(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : Experiment {
        Experiment{
            id             : 0x2::object::new(arg1),
            created_at     : 0x2::clock::timestamp_ms(arg0),
            walrus_blob_id : 0x1::option::none<vector<u8>>(),
        }
    }

    entry fun create_experiment_entry(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Experiment>(create_experiment(arg0, arg1));
    }

    public fun created_at(arg0: &Experiment) : u64 {
        arg0.created_at
    }

    public fun generate_id(arg0: &Experiment) : vector<u8> {
        let v0 = arg0.created_at + 180000;
        0x2::bcs::to_bytes<u64>(&v0)
    }

    public fun namespace(arg0: &Experiment) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::clock::Clock) {
        assert!(check_policy(arg0, arg1), 1);
    }

    public fun set_blob_id(arg0: &mut Experiment, arg1: vector<u8>) {
        arg0.walrus_blob_id = 0x1::option::some<vector<u8>>(arg1);
    }

    // decompiled from Move bytecode v6
}

