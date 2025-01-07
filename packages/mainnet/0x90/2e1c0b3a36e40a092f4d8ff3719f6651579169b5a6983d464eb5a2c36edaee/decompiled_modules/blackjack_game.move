module 0x902e1c0b3a36e40a092f4d8ff3719f6651579169b5a6983d464eb5a2c36edaee::blackjack_game {
    struct HouseData has key {
        id: 0x2::object::UID,
        house: address,
        public_key: vector<u8>,
    }

    struct ServerHashObject has store, key {
        id: 0x2::object::UID,
        data: 0x1::string::String,
    }

    public entry fun initialize_house_data(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseData{
            id         : 0x2::object::new(arg1),
            house      : 0x2::tx_context::sender(arg1),
            public_key : arg0,
        };
        0x2::transfer::transfer<HouseData>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun publish_server_hash(arg0: 0x1::string::String, arg1: vector<u8>, arg2: &mut HouseData, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2.public_key;
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &arg2.public_key, &v0), 0);
        let v1 = ServerHashObject{
            id   : 0x2::object::new(arg3),
            data : arg0,
        };
        0x2::transfer::freeze_object<ServerHashObject>(v1);
    }

    // decompiled from Move bytecode v6
}

