module 0xb9448368424d5943d1d997f00f9538008824cf39f608ee7b7884b290f03a9c06::shitport {
    struct PersonalKioskCap has store, key {
        id: 0x2::object::UID,
    }

    struct Store has store, key {
        id: 0x2::object::UID,
        caps: 0x2::table::Table<0x2::object::ID, PersonalKioskCap>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id   : 0x2::object::new(arg0),
            caps : 0x2::table::new<0x2::object::ID, PersonalKioskCap>(arg0),
        };
        0x2::transfer::share_object<Store>(v0);
    }

    public entry fun transfer_to_store(arg0: PersonalKioskCap, arg1: &mut Store, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x48800b4f902dd3a89b7344700614f0e0b936619182549953a8a551706ca40700, 0);
        0x2::table::add<0x2::object::ID, PersonalKioskCap>(&mut arg1.caps, 0x2::object::uid_to_inner(&arg0.id), arg0);
    }

    public entry fun transfer_to_user(arg0: 0x2::object::ID, arg1: &mut Store, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x48800b4f902dd3a89b7344700614f0e0b936619182549953a8a551706ca40700, 0);
        0x2::transfer::transfer<PersonalKioskCap>(0x2::table::remove<0x2::object::ID, PersonalKioskCap>(&mut arg1.caps, arg0), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

