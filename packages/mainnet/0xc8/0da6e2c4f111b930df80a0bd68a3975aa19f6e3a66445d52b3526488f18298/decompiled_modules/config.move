module 0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        extra_fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 1);
        Config{
            id           : 0x2::object::new(arg1),
            version      : 1,
            extra_fields : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public fun create_package_assistant_cap(arg0: &mut Config, arg1: &0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::authority::AuthorityCap<0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::authority::PACKAGE, 0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::authority::ADMIN>) : 0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::authority::AuthorityCap<0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::authority::PACKAGE, 0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::authority::ASSISTANT> {
        assert_package_version(arg0);
        0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::authority::create_package_assistant_cap(&mut arg0.id)
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version <= 1, 0);
    }

    public(friend) fun borrow_mut_id(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun current_version() : u64 {
        1
    }

    public fun upgrade_version<T0>(arg0: &mut Config, arg1: &0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::authority::AuthorityCap<0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::authority::PACKAGE, T0>) {
        assert!(arg0.version == 1 - 1, 0);
        arg0.version = 1;
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

