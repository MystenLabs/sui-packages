module 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::attributes {
    struct TakoAttributes has copy, drop, store {
        image_hash: 0x1::string::String,
        keys: vector<0x1::string::String>,
        values: vector<0x1::string::String>,
    }

    struct AttributesRegistry has store, key {
        id: 0x2::object::UID,
        available_attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x2::table_vec::TableVec<TakoAttributes>>,
    }

    public fun attributes(arg0: &TakoAttributes) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0.keys)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0.keys, v1), *0x1::vector::borrow<0x1::string::String>(&arg0.values, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun add_attributes(arg0: &mut AttributesRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::AdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = TakoAttributes{
            image_hash : arg2,
            keys       : arg3,
            values     : arg4,
        };
        if (0x2::vec_map::contains<0x1::string::String, 0x2::table_vec::TableVec<TakoAttributes>>(&arg0.available_attributes, &arg1)) {
            0x2::table_vec::push_back<TakoAttributes>(0x2::vec_map::get_mut<0x1::string::String, 0x2::table_vec::TableVec<TakoAttributes>>(&mut arg0.available_attributes, &arg1), v0);
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x2::table_vec::TableVec<TakoAttributes>>(&mut arg0.available_attributes, arg1, 0x2::table_vec::singleton<TakoAttributes>(v0, arg6));
        };
    }

    public fun check_enough_attributes(arg0: &AttributesRegistry) : bool {
        let v0 = if (get_tier_attributes_count(arg0, 0x1::string::utf8(b"Pirate")) == 0) {
            true
        } else if (get_tier_attributes_count(arg0, 0x1::string::utf8(b"Ninja")) == 0) {
            true
        } else if (get_tier_attributes_count(arg0, 0x1::string::utf8(b"Samurai")) == 0) {
            true
        } else {
            get_tier_attributes_count(arg0, 0x1::string::utf8(b"Lord")) == 0
        };
        !v0
    }

    public fun get_tier_attributes_count(arg0: &AttributesRegistry, arg1: 0x1::string::String) : u64 {
        if (0x2::vec_map::contains<0x1::string::String, 0x2::table_vec::TableVec<TakoAttributes>>(&arg0.available_attributes, &arg1)) {
            0x2::table_vec::length<TakoAttributes>(0x2::vec_map::get<0x1::string::String, 0x2::table_vec::TableVec<TakoAttributes>>(&arg0.available_attributes, &arg1))
        } else {
            0
        }
    }

    public fun image_hash(arg0: &TakoAttributes) : 0x1::string::String {
        arg0.image_hash
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AttributesRegistry{
            id                   : 0x2::object::new(arg0),
            available_attributes : 0x2::vec_map::empty<0x1::string::String, 0x2::table_vec::TableVec<TakoAttributes>>(),
        };
        0x2::transfer::share_object<AttributesRegistry>(v0);
    }

    public(friend) fun random_attributes(arg0: &mut AttributesRegistry, arg1: &mut 0x2::random::RandomGenerator, arg2: 0x1::string::String) : TakoAttributes {
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, 0x2::table_vec::TableVec<TakoAttributes>>(&mut arg0.available_attributes, &arg2);
        0x2::table_vec::swap_remove<TakoAttributes>(v0, 0x2::random::generate_u64_in_range(arg1, 0, 0x2::table_vec::length<TakoAttributes>(v0) - 1))
    }

    public fun remove_attributes(arg0: &mut AttributesRegistry, arg1: 0x1::string::String, arg2: u64, arg3: &0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::AdminCap) {
        0x2::table_vec::swap_remove<TakoAttributes>(0x2::vec_map::get_mut<0x1::string::String, 0x2::table_vec::TableVec<TakoAttributes>>(&mut arg0.available_attributes, &arg1), arg2);
    }

    // decompiled from Move bytecode v6
}

