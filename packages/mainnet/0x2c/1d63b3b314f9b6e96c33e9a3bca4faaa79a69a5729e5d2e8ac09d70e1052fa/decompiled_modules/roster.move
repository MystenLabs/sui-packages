module 0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster {
    struct IdentitySet has copy, drop {
        name: 0x1::string::String,
        sui_address: address,
        chain_count: u64,
        dwallet_count: u64,
    }

    struct Roster has key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct IdentityRecord has copy, drop, store {
        name: 0x1::string::String,
        sui_address: address,
        chains: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        dwallet_caps: vector<address>,
        updated_ms: u64,
        walrus_blob_id: 0x1::string::String,
        seal_nonce: vector<u8>,
        verified: bool,
    }

    public fun count(arg0: &Roster) : u64 {
        arg0.count
    }

    public fun has_address(arg0: &Roster, arg1: address) : bool {
        0x2::dynamic_field::exists_<address>(&arg0.id, arg1)
    }

    public fun has_chain(arg0: &Roster, arg1: 0x1::string::String) : bool {
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg1)
    }

    public fun has_name(arg0: &Roster, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Roster{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::share_object<Roster>(v0);
    }

    public fun lookup_by_address(arg0: &Roster, arg1: address) : &IdentityRecord {
        0x2::dynamic_field::borrow<address, IdentityRecord>(&arg0.id, arg1)
    }

    public fun lookup_by_chain(arg0: &Roster, arg1: 0x1::string::String) : &IdentityRecord {
        0x2::dynamic_field::borrow<0x1::string::String, IdentityRecord>(&arg0.id, arg1)
    }

    public fun lookup_by_name(arg0: &Roster, arg1: vector<u8>) : &IdentityRecord {
        0x2::dynamic_field::borrow<vector<u8>, IdentityRecord>(&arg0.id, arg1)
    }

    public fun record_chains(arg0: &IdentityRecord) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.chains
    }

    public fun record_dwallet_caps(arg0: &IdentityRecord) : &vector<address> {
        &arg0.dwallet_caps
    }

    public fun record_name(arg0: &IdentityRecord) : &0x1::string::String {
        &arg0.name
    }

    public fun record_seal_nonce(arg0: &IdentityRecord) : &vector<u8> {
        &arg0.seal_nonce
    }

    public fun record_sui_address(arg0: &IdentityRecord) : address {
        arg0.sui_address
    }

    public fun record_updated_ms(arg0: &IdentityRecord) : u64 {
        arg0.updated_ms
    }

    public fun record_verified(arg0: &IdentityRecord) : bool {
        arg0.verified
    }

    public fun record_walrus_blob_id(arg0: &IdentityRecord) : &0x1::string::String {
        &arg0.walrus_blob_id
    }

    entry fun set_identity(arg0: &mut Roster, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<address>, arg6: 0x1::string::String, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg3);
        assert!(v1 > 0 && v1 == 0x1::vector::length<0x1::string::String>(&arg4), 1);
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v3 = 0;
        while (v3 < v1) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, *0x1::vector::borrow<0x1::string::String>(&arg3, v3), *0x1::vector::borrow<0x1::string::String>(&arg4, v3));
            v3 = v3 + 1;
        };
        let v4 = IdentityRecord{
            name           : arg1,
            sui_address    : v0,
            chains         : v2,
            dwallet_caps   : arg5,
            updated_ms     : 0x2::clock::timestamp_ms(arg8),
            walrus_blob_id : arg6,
            seal_nonce     : arg7,
            verified       : !0x1::vector::is_empty<address>(&arg5),
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg2)) {
            0x2::dynamic_field::remove<vector<u8>, IdentityRecord>(&mut arg0.id, arg2);
        } else {
            arg0.count = arg0.count + 1;
        };
        0x2::dynamic_field::add<vector<u8>, IdentityRecord>(&mut arg0.id, arg2, v4);
        if (0x2::dynamic_field::exists_<address>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<address, IdentityRecord>(&mut arg0.id, v0);
        };
        0x2::dynamic_field::add<address, IdentityRecord>(&mut arg0.id, v0, v4);
        let v5 = 0;
        while (v5 < v1) {
            let v6 = *0x1::vector::borrow<0x1::string::String>(&arg3, v5);
            0x1::string::append_utf8(&mut v6, b":");
            0x1::string::append(&mut v6, *0x1::vector::borrow<0x1::string::String>(&arg4, v5));
            if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v6)) {
                0x2::dynamic_field::remove<0x1::string::String, IdentityRecord>(&mut arg0.id, v6);
            };
            0x2::dynamic_field::add<0x1::string::String, IdentityRecord>(&mut arg0.id, v6, v4);
            v5 = v5 + 1;
        };
        let v7 = IdentitySet{
            name          : arg1,
            sui_address   : v0,
            chain_count   : v1,
            dwallet_count : 0x1::vector::length<address>(&arg5),
        };
        0x2::event::emit<IdentitySet>(v7);
    }

    // decompiled from Move bytecode v6
}

