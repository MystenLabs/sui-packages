module 0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::stork_pricing_oracle {
    struct Admin has key {
        id: 0x2::object::UID,
    }

    struct Prices has store, key {
        id: 0x2::object::UID,
        ptable: 0x2::object_table::ObjectTable<0x1::string::String, 0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::asset_pair_price::Price>,
        alist: vector<0x1::string::String>,
    }

    public entry fun set_oracle(arg0: &mut Admin, arg1: &mut Prices, arg2: 0x1::string::String, arg3: u256, arg4: u256, arg5: vector<vector<0x1::string::String>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (0x2::object_table::contains<0x1::string::String, 0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::asset_pair_price::Price>(&arg1.ptable, arg2) == false) {
            add_oracle(arg0, arg1, arg2, arg6, arg7);
        };
        0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::asset_pair_price::set_oracle(0x2::object_table::borrow_mut<0x1::string::String, 0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::asset_pair_price::Price>(&mut arg1.ptable, arg2), arg3, arg4, &mut arg5, arg6);
    }

    public entry fun add_oracle(arg0: &mut Admin, arg1: &mut Prices, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x1::string::String, 0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::asset_pair_price::Price>(&arg1.ptable, arg2) == false, 1077);
        0x2::object_table::add<0x1::string::String, 0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::asset_pair_price::Price>(&mut arg1.ptable, arg2, 0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::asset_pair_price::create_oracle(arg2, arg4, arg3));
        0x1::vector::push_back<0x1::string::String>(&mut arg1.alist, arg2);
    }

    public fun get_all_oracles(arg0: &Prices) : &0x2::object_table::ObjectTable<0x1::string::String, 0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::asset_pair_price::Price> {
        &arg0.ptable
    }

    public fun get_assets(arg0: &Prices) : &vector<0x1::string::String> {
        &arg0.alist
    }

    public fun get_oracle(arg0: &Prices, arg1: 0x1::string::String) : &0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::asset_pair_price::Price {
        assert!(0x2::object_table::contains<0x1::string::String, 0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::asset_pair_price::Price>(&arg0.ptable, arg1) == true, 1078);
        0x2::object_table::borrow<0x1::string::String, 0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::asset_pair_price::Price>(&arg0.ptable, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Prices{
            id     : 0x2::object::new(arg0),
            ptable : 0x2::object_table::new<0x1::string::String, 0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::asset_pair_price::Price>(arg0),
            alist  : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::transfer<Prices>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

