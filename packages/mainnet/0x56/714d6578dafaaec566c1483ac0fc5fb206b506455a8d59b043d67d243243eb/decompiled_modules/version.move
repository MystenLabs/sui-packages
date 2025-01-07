module 0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version {
    struct VERSION has drop {
        dummy_field: bool,
    }

    struct Version has key {
        id: 0x2::object::UID,
        versions: 0x2::table::Table<address, u64>,
    }

    public fun borrow_mut(arg0: &0x2::package::Publisher, arg1: &mut Version) : &mut u64 {
        0x2::table::borrow_mut<address, u64>(&mut arg1.versions, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(0x2::package::published_package(arg0)))))
    }

    public fun get(arg0: &Version, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.versions, arg1)
    }

    public entry fun add(arg0: &0x2::package::Publisher, arg1: &mut Version) {
        0x2::table::add<address, u64>(&mut arg1.versions, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(0x2::package::published_package(arg0)))), 0);
    }

    public fun contains(arg0: &Version, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.versions, arg1)
    }

    public fun get_by_T<T0>(arg0: &Version) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v1))))
    }

    fun init(arg0: VERSION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VERSION>(arg0, arg1);
        let v0 = Version{
            id       : 0x2::object::new(arg1),
            versions : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public entry fun set(arg0: &0x2::package::Publisher, arg1: &mut Version, arg2: u64) {
        *0x2::table::borrow_mut<address, u64>(&mut arg1.versions, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(0x2::package::published_package(arg0))))) = arg2;
    }

    // decompiled from Move bytecode v6
}

