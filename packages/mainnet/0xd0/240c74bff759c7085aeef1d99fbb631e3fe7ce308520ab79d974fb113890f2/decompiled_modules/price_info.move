module 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_info {
    struct PriceInfoObject has store, key {
        id: 0x2::object::UID,
        price_info: PriceInfo,
    }

    struct PriceInfo has copy, drop, store {
        attestation_time: u64,
        arrival_time: u64,
        price_feed: 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_feed::PriceFeed,
    }

    public(friend) fun add(arg0: &mut 0x2::object::UID, arg1: 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier, arg2: 0x2::object::ID) {
        assert!(!contains(arg0, arg1), 1);
        0x2::table::add<0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier, 0x2::object::ID>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier, 0x2::object::ID>>(arg0, b"price_info"), arg1, arg2);
    }

    public fun uid_to_inner(arg0: &PriceInfoObject) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun contains(arg0: &0x2::object::UID, arg1: 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier) : bool {
        0x2::table::contains<0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier, 0x2::object::ID>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier, 0x2::object::ID>>(arg0, b"price_info"), arg1)
    }

    public fun get_price_identifier(arg0: &PriceInfo) : 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier {
        0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_feed::get_price_identifier(&arg0.price_feed)
    }

    public entry fun create_price_obj(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<PriceInfoObject>(new_price_info_object(new_price_info(0x2::clock::timestamp_ms(arg0) / 1000, 0x2::clock::timestamp_ms(arg0) / 1000, 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_feed::new(0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::from_byte_vec(arg1), 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price::new(0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::i64::new(1557, false), 7, 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::i64::new(5, true), 0x2::clock::timestamp_ms(arg0) / 1000), 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price::new(0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::i64::new(1500, false), 3, 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::i64::new(5, true), 0x2::clock::timestamp_ms(arg0) / 1000))), arg2));
    }

    public entry fun create_price_obj_for_btc(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        create_price_obj(arg0, x"3b9551a68d01d954d6387aff4df1529027ffb2fee413082e509feb29cc4904fe", arg1);
    }

    public entry fun create_price_obj_for_eth(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        create_price_obj(arg0, x"c6c75c89f14810ec1c54c03ab8f1864a4c4032791f05747f560faec380a695d1", arg1);
    }

    public fun deposit_fee_coins(arg0: &mut PriceInfoObject, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        if (!0x2::dynamic_object_field::exists_with_type<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&arg0.id, b"fee_storage")) {
            0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, b"fee_storage", arg1);
        } else {
            0x2::coin::join<0x2::sui::SUI>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, b"fee_storage"), arg1);
        };
    }

    public fun get_arrival_time(arg0: &PriceInfo) : u64 {
        arg0.arrival_time
    }

    public fun get_attestation_time(arg0: &PriceInfo) : u64 {
        arg0.attestation_time
    }

    public fun get_balance(arg0: &PriceInfoObject) : u64 {
        if (!0x2::dynamic_object_field::exists_with_type<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&arg0.id, b"fee_storage")) {
            return 0
        };
        0x2::coin::value<0x2::sui::SUI>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&arg0.id, b"fee_storage"))
    }

    public fun get_id(arg0: &0x2::object::UID, arg1: 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier) : 0x2::object::ID {
        assert!(contains(arg0, arg1), 2);
        0x2::object::id_from_bytes(0x2::object::id_to_bytes(0x2::table::borrow<0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier, 0x2::object::ID>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier, 0x2::object::ID>>(arg0, b"price_info"), arg1)))
    }

    public fun get_id_bytes(arg0: &0x2::object::UID, arg1: 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier) : vector<u8> {
        assert!(contains(arg0, arg1), 2);
        0x2::object::id_to_bytes(0x2::table::borrow<0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier, 0x2::object::ID>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier, 0x2::object::ID>>(arg0, b"price_info"), arg1))
    }

    public fun get_price_feed(arg0: &PriceInfo) : &0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_feed::PriceFeed {
        &arg0.price_feed
    }

    public fun get_price_info_from_price_info_object(arg0: &PriceInfoObject) : PriceInfo {
        arg0.price_info
    }

    public fun new_price_info(arg0: u64, arg1: u64, arg2: 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_feed::PriceFeed) : PriceInfo {
        PriceInfo{
            attestation_time : arg0,
            arrival_time     : arg1,
            price_feed       : arg2,
        }
    }

    public(friend) fun new_price_info_object(arg0: PriceInfo, arg1: &mut 0x2::tx_context::TxContext) : PriceInfoObject {
        PriceInfoObject{
            id         : 0x2::object::new(arg1),
            price_info : arg0,
        }
    }

    public(friend) fun new_price_info_registry(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<vector<u8>>(arg0, b"price_info"), 0);
        0x2::dynamic_object_field::add<vector<u8>, 0x2::table::Table<0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier, 0x2::object::ID>>(arg0, b"price_info", 0x2::table::new<0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::PriceIdentifier, 0x2::object::ID>(arg1));
    }

    public(friend) fun update_price_info_object(arg0: &mut PriceInfoObject, arg1: &PriceInfo) {
        arg0.price_info = new_price_info(arg1.attestation_time, arg1.arrival_time, arg1.price_feed);
    }

    public entry fun update_price_info_object_for_test(arg0: &mut PriceInfoObject, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: vector<u8>) {
        arg0.price_info = new_price_info(0x2::clock::timestamp_ms(arg1) / 1000, 0x2::clock::timestamp_ms(arg1) / 1000, 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_feed::new(0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::from_byte_vec(arg4), 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price::new(0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::i64::new(arg2, false), arg3, 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::i64::new(5, true), 0x2::clock::timestamp_ms(arg1) / 1000), 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price::new(0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::i64::new(arg2, false), arg3, 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::i64::new(5, true), 0x2::clock::timestamp_ms(arg1) / 1000)));
        0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::event::emit_price_feed_update(arg0.price_info.price_feed, 0x2::clock::timestamp_ms(arg1) / 1000);
    }

    // decompiled from Move bytecode v6
}

