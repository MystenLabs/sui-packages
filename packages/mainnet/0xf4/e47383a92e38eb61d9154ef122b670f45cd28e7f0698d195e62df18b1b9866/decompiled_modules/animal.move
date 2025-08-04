module 0xf4e47383a92e38eb61d9154ef122b670f45cd28e7f0698d195e62df18b1b9866::animal {
    struct AnimalObject has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        no_of_legs: u8,
        favourite_food: 0x1::string::String,
    }

    public entry fun new(arg0: 0x1::string::String, arg1: u8, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AnimalObject{
            id             : 0x2::object::new(arg3),
            name           : arg0,
            no_of_legs     : arg1,
            favourite_food : arg2,
        };
        0x2::transfer::public_transfer<AnimalObject>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

