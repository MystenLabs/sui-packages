module 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info {
    struct PriceInfoObject has store, key {
        id: 0x2::object::UID,
        price_info: PriceInfo,
    }

    struct PriceInfo has copy, drop, store {
        attestation_time: u64,
        arrival_time: u64,
        price_feed: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_feed::PriceFeed,
    }

    public(friend) fun add(arg0: &mut 0x2::object::UID, arg1: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier, arg2: 0x2::object::ID) {
        assert!(!contains(arg0, arg1), 1);
        0x2::table::add<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier, 0x2::object::ID>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier, 0x2::object::ID>>(arg0, b"price_info"), arg1, arg2);
    }

    public fun uid_to_inner(arg0: &PriceInfoObject) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun contains(arg0: &0x2::object::UID, arg1: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier) : bool {
        0x2::table::contains<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier, 0x2::object::ID>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier, 0x2::object::ID>>(arg0, b"price_info"), arg1)
    }

    public fun get_price_identifier(arg0: &PriceInfo) : 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier {
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_feed::get_price_identifier(&arg0.price_feed)
    }

    public fun get_arrival_time(arg0: &PriceInfo) : u64 {
        arg0.arrival_time
    }

    public fun get_attestation_time(arg0: &PriceInfo) : u64 {
        arg0.attestation_time
    }

    public fun get_id(arg0: &0x2::object::UID, arg1: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier) : 0x2::object::ID {
        assert!(contains(arg0, arg1), 2);
        0x2::object::id_from_bytes(0x2::object::id_to_bytes(0x2::table::borrow<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier, 0x2::object::ID>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier, 0x2::object::ID>>(arg0, b"price_info"), arg1)))
    }

    public fun get_id_bytes(arg0: &0x2::object::UID, arg1: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier) : vector<u8> {
        assert!(contains(arg0, arg1), 2);
        0x2::object::id_to_bytes(0x2::table::borrow<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier, 0x2::object::ID>(0x2::dynamic_object_field::borrow<vector<u8>, 0x2::table::Table<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier, 0x2::object::ID>>(arg0, b"price_info"), arg1))
    }

    public fun get_price_feed(arg0: &PriceInfo) : &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_feed::PriceFeed {
        &arg0.price_feed
    }

    public fun get_price_info_from_price_info_object(arg0: &PriceInfoObject) : PriceInfo {
        arg0.price_info
    }

    public fun new_price_info(arg0: u64, arg1: u64, arg2: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_feed::PriceFeed) : PriceInfo {
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
        0x2::dynamic_object_field::add<vector<u8>, 0x2::table::Table<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier, 0x2::object::ID>>(arg0, b"price_info", 0x2::table::new<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier, 0x2::object::ID>(arg1));
    }

    public(friend) fun update_price_info_object(arg0: &mut PriceInfoObject, arg1: PriceInfo) {
        arg0.price_info = arg1;
    }

    // decompiled from Move bytecode v6
}

