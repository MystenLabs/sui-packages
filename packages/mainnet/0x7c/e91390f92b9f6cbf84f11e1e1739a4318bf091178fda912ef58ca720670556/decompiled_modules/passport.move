module 0x7ce91390f92b9f6cbf84f11e1e1739a4318bf091178fda912ef58ca720670556::passport {
    struct DevicePassport has store, key {
        id: 0x2::object::UID,
        category: 0x1::string::String,
        make: 0x1::string::String,
        model: 0x1::string::String,
        serial_hash: vector<u8>,
        creator: address,
        created_at_ms: u64,
    }

    struct PassportMinted has copy, drop {
        passport_id: 0x2::object::ID,
        owner: address,
        category: 0x1::string::String,
        make: 0x1::string::String,
        model: 0x1::string::String,
    }

    struct PassportTransferred has copy, drop {
        passport_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    public fun category(arg0: &DevicePassport) : 0x1::string::String {
        arg0.category
    }

    public fun creator(arg0: &DevicePassport) : address {
        arg0.creator
    }

    public fun make(arg0: &DevicePassport) : 0x1::string::String {
        arg0.make
    }

    entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = DevicePassport{
            id            : 0x2::object::new(arg5),
            category      : arg0,
            make          : arg1,
            model         : arg2,
            serial_hash   : arg3,
            creator       : v0,
            created_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        let v2 = PassportMinted{
            passport_id : 0x2::object::id<DevicePassport>(&v1),
            owner       : v0,
            category    : v1.category,
            make        : v1.make,
            model       : v1.model,
        };
        0x2::event::emit<PassportMinted>(v2);
        0x2::transfer::public_transfer<DevicePassport>(v1, v0);
    }

    public fun model(arg0: &DevicePassport) : 0x1::string::String {
        arg0.model
    }

    entry fun transfer_passport(arg0: DevicePassport, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = PassportTransferred{
            passport_id : 0x2::object::id<DevicePassport>(&arg0),
            from        : 0x2::tx_context::sender(arg2),
            to          : arg1,
        };
        0x2::event::emit<PassportTransferred>(v0);
        0x2::transfer::public_transfer<DevicePassport>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

