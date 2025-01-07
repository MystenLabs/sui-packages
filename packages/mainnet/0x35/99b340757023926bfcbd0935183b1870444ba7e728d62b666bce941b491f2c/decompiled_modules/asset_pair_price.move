module 0x3599b340757023926bfcbd0935183b1870444ba7e728d62b666bce941b491f2c::asset_pair_price {
    struct Price has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        price: 0x1::option::Option<u256>,
        timestamp: u64,
        oracle_timestamp: 0x1::option::Option<u256>,
        price_confidence_interval: 0x1::option::Option<u64>,
        signed_prices: 0x1::option::Option<0x2::vec_map::VecMap<0x1::string::String, SignedPrice>>,
    }

    struct SignedPrice has drop, store {
        oracle_publisher: 0x1::string::String,
        external_asset_id: 0x1::string::String,
        price: 0x1::string::String,
        timestamp: 0x1::string::String,
        msg_hash: 0x1::string::String,
        r: 0x1::string::String,
        s: 0x1::string::String,
        v: 0x1::string::String,
    }

    public fun create_oracle(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext, arg2: &0x2::clock::Clock) : Price {
        Price{
            id                        : 0x2::object::new(arg1),
            name                      : arg0,
            price                     : 0x1::option::none<u256>(),
            timestamp                 : 0x2::clock::timestamp_ms(arg2),
            oracle_timestamp          : 0x1::option::none<u256>(),
            price_confidence_interval : 0x1::option::none<u64>(),
            signed_prices             : 0x1::option::none<0x2::vec_map::VecMap<0x1::string::String, SignedPrice>>(),
        }
    }

    public fun price(arg0: &Price) : 0x1::option::Option<u256> {
        arg0.price
    }

    public fun set_oracle(arg0: &mut Price, arg1: u256, arg2: u256, arg3: &mut vector<vector<0x1::string::String>>, arg4: &0x2::clock::Clock) {
        arg0.price = 0x1::option::some<u256>(arg1);
        arg0.oracle_timestamp = 0x1::option::some<u256>(arg2);
        arg0.timestamp = 0x2::clock::timestamp_ms(arg4);
        let v0 = 0x2::vec_map::empty<0x1::string::String, SignedPrice>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<0x1::string::String>>(arg3)) {
            let v2 = 0x1::vector::borrow<vector<0x1::string::String>>(arg3, v1);
            let v3 = SignedPrice{
                oracle_publisher  : *0x1::vector::borrow<0x1::string::String>(v2, 0),
                external_asset_id : *0x1::vector::borrow<0x1::string::String>(v2, 1),
                price             : *0x1::vector::borrow<0x1::string::String>(v2, 2),
                timestamp         : *0x1::vector::borrow<0x1::string::String>(v2, 3),
                msg_hash          : *0x1::vector::borrow<0x1::string::String>(v2, 4),
                r                 : *0x1::vector::borrow<0x1::string::String>(v2, 5),
                s                 : *0x1::vector::borrow<0x1::string::String>(v2, 6),
                v                 : *0x1::vector::borrow<0x1::string::String>(v2, 7),
            };
            0x2::vec_map::insert<0x1::string::String, SignedPrice>(&mut v0, *0x1::vector::borrow<0x1::string::String>(v2, 0), v3);
            v1 = v1 + 1;
        };
        arg0.signed_prices = 0x1::option::some<0x2::vec_map::VecMap<0x1::string::String, SignedPrice>>(v0);
    }

    // decompiled from Move bytecode v6
}

