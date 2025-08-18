module 0x441ad463f501618db5147076bb3e5cc9d7453d4694e6a89c44b01233ef44affa::passport {
    struct Passport has store, key {
        id: 0x2::object::UID,
        animal_name: 0x1::string::String,
        animal_type: 0x1::string::String,
        rescue_date: u64,
        issued_by: address,
    }

    struct PassportCreated has copy, drop {
        passport_id: address,
        animal_name: 0x1::string::String,
        animal_type: 0x1::string::String,
        issued_by: address,
        rescue_date: u64,
    }

    struct PassportTransferred has copy, drop {
        passport_id: address,
        from: address,
        to: address,
    }

    struct AnimalInfoUpdated has copy, drop {
        passport_id: address,
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
        updated_by: address,
    }

    entry fun create_passport(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = issue_passport(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<Passport>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun get_animal_name(arg0: &Passport) : &0x1::string::String {
        &arg0.animal_name
    }

    public fun get_animal_type(arg0: &Passport) : &0x1::string::String {
        &arg0.animal_type
    }

    public fun get_id(arg0: &Passport) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_issued_by(arg0: &Passport) : address {
        arg0.issued_by
    }

    public fun get_passport_info(arg0: &Passport) : (0x1::string::String, 0x1::string::String, u64, address) {
        (arg0.animal_name, arg0.animal_type, arg0.rescue_date, arg0.issued_by)
    }

    public fun get_rescue_date(arg0: &Passport) : u64 {
        arg0.rescue_date
    }

    public fun issue_passport(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Passport {
        let v0 = Passport{
            id          : 0x2::object::new(arg3),
            animal_name : 0x1::string::utf8(arg0),
            animal_type : 0x1::string::utf8(arg1),
            rescue_date : arg2,
            issued_by   : 0x2::tx_context::sender(arg3),
        };
        let v1 = PassportCreated{
            passport_id : 0x2::object::uid_to_address(&v0.id),
            animal_name : v0.animal_name,
            animal_type : v0.animal_type,
            issued_by   : v0.issued_by,
            rescue_date : v0.rescue_date,
        };
        0x2::event::emit<PassportCreated>(v1);
        v0
    }

    public fun transfer_passport(arg0: Passport, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = PassportTransferred{
            passport_id : 0x2::object::uid_to_address(&arg0.id),
            from        : 0x2::tx_context::sender(arg2),
            to          : arg1,
        };
        0x2::event::emit<PassportTransferred>(v0);
        0x2::transfer::transfer<Passport>(arg0, arg1);
    }

    public fun update_animal_info(arg0: &mut Passport, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.issued_by == 0x2::tx_context::sender(arg2), 1);
        arg0.animal_name = 0x1::string::utf8(arg1);
        let v0 = AnimalInfoUpdated{
            passport_id : 0x2::object::uid_to_address(&arg0.id),
            old_name    : arg0.animal_name,
            new_name    : arg0.animal_name,
            updated_by  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AnimalInfoUpdated>(v0);
    }

    public fun verify_passport(arg0: &Passport) : bool {
        if (!0x1::string::is_empty(&arg0.animal_name)) {
            if (!0x1::string::is_empty(&arg0.animal_type)) {
                arg0.rescue_date > 0
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

