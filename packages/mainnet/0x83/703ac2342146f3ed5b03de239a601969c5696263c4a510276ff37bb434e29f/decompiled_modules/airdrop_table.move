module 0x83703ac2342146f3ed5b03de239a601969c5696263c4a510276ff37bb434e29f::airdrop_table {
    struct AirdropTable has key {
        id: 0x2::object::UID,
        admin: address,
        map: 0x2::table::Table<address, u64>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropTable{
            id    : 0x2::object::new(arg0),
            admin : @0x3746e4156bd0461d6d73129ae332d5e24f148b90303f4c8b23bb7c19b53df34f,
            map   : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<AirdropTable>(v0);
    }

    public fun record(arg0: &mut AirdropTable, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(!0x2::table::contains<address, u64>(&arg0.map, arg1) || *0x2::table::borrow<address, u64>(&arg0.map, arg1) == 0, 1);
        0x2::table::add<address, u64>(&mut arg0.map, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

