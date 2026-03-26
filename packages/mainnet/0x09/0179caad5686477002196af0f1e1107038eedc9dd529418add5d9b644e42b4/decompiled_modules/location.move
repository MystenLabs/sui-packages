module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::location {
    struct Location has store {
        location_hash: vector<u8>,
    }

    struct LocationProofMessage has drop {
        server_address: address,
        player_address: address,
        source_structure_id: 0x2::object::ID,
        source_location_hash: vector<u8>,
        target_structure_id: 0x2::object::ID,
        target_location_hash: vector<u8>,
        distance: u64,
        data: vector<u8>,
        deadline_ms: u64,
    }

    struct LocationProof has drop {
        message: LocationProofMessage,
        signature: vector<u8>,
    }

    struct LocationRegistry has key {
        id: 0x2::object::UID,
        locations: 0x2::table::Table<0x2::object::ID, Coordinates>,
    }

    struct Coordinates has copy, drop, store {
        solarsystem: u64,
        x: 0x1::string::String,
        y: 0x1::string::String,
        z: 0x1::string::String,
    }

    struct LocationRevealedEvent has copy, drop {
        assembly_id: 0x2::object::ID,
        assembly_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        type_id: u64,
        owner_cap_id: 0x2::object::ID,
        location_hash: vector<u8>,
        solarsystem: u64,
        x: 0x1::string::String,
        y: 0x1::string::String,
        z: 0x1::string::String,
    }

    public fun id(arg0: &LocationRegistry) : 0x2::object::ID {
        0x2::object::id<LocationRegistry>(arg0)
    }

    public(friend) fun remove(arg0: Location) {
        let Location {  } = arg0;
    }

    public(friend) fun attach(arg0: vector<u8>) : Location {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13835340762914619395);
        Location{location_hash: arg0}
    }

    public fun create_location_proof(arg0: address, arg1: address, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: u64, arg7: vector<u8>, arg8: u64, arg9: vector<u8>) : LocationProof {
        let v0 = LocationProofMessage{
            server_address       : arg0,
            player_address       : arg1,
            source_structure_id  : arg2,
            source_location_hash : arg3,
            target_structure_id  : arg4,
            target_location_hash : arg5,
            distance             : arg6,
            data                 : arg7,
            deadline_ms          : arg8,
        };
        LocationProof{
            message   : v0,
            signature : arg9,
        }
    }

    public fun get_location(arg0: &LocationRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<Coordinates> {
        if (0x2::table::contains<0x2::object::ID, Coordinates>(&arg0.locations, arg1)) {
            0x1::option::some<Coordinates>(*0x2::table::borrow<0x2::object::ID, Coordinates>(&arg0.locations, arg1))
        } else {
            0x1::option::none<Coordinates>()
        }
    }

    public fun hash(arg0: &Location) : vector<u8> {
        arg0.location_hash
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LocationRegistry{
            id        : 0x2::object::new(arg0),
            locations : 0x2::table::new<0x2::object::ID, Coordinates>(arg0),
        };
        0x2::transfer::share_object<LocationRegistry>(v0);
    }

    fun is_deadline_valid(arg0: u64, arg1: &0x2::clock::Clock) : bool {
        arg0 > 0x2::clock::timestamp_ms(arg1)
    }

    public(friend) fun reveal_location(arg0: &mut LocationRegistry, arg1: 0x2::object::ID, arg2: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId, arg3: u64, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String) {
        set_location_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun set_location_internal(arg0: &mut LocationRegistry, arg1: 0x2::object::ID, arg2: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId, arg3: u64, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String) {
        let v0 = Coordinates{
            solarsystem : arg6,
            x           : arg7,
            y           : arg8,
            z           : arg9,
        };
        if (0x2::table::contains<0x2::object::ID, Coordinates>(&arg0.locations, arg1)) {
            0x2::table::remove<0x2::object::ID, Coordinates>(&mut arg0.locations, arg1);
        };
        0x2::table::add<0x2::object::ID, Coordinates>(&mut arg0.locations, arg1, v0);
        let v1 = LocationRevealedEvent{
            assembly_id   : arg1,
            assembly_key  : arg2,
            type_id       : arg3,
            owner_cap_id  : arg4,
            location_hash : arg5,
            solarsystem   : arg6,
            x             : arg7,
            y             : arg8,
            z             : arg9,
        };
        0x2::event::emit<LocationRevealedEvent>(v1);
    }

    public fun solarsystem(arg0: &Coordinates) : u64 {
        arg0.solarsystem
    }

    fun unpack_proof(arg0: vector<u8>) : (LocationProofMessage, vector<u8>) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = &mut v0;
        let v2 = b"";
        let v3 = 0;
        while (v3 < 0x2::bcs::peel_vec_length(v1)) {
            0x1::vector::push_back<u8>(&mut v2, 0x2::bcs::peel_u8(v1));
            v3 = v3 + 1;
        };
        let v4 = &mut v0;
        let v5 = b"";
        let v6 = 0;
        while (v6 < 0x2::bcs::peel_vec_length(v4)) {
            0x1::vector::push_back<u8>(&mut v5, 0x2::bcs::peel_u8(v4));
            v6 = v6 + 1;
        };
        let v7 = &mut v0;
        let v8 = b"";
        let v9 = 0;
        while (v9 < 0x2::bcs::peel_vec_length(v7)) {
            0x1::vector::push_back<u8>(&mut v8, 0x2::bcs::peel_u8(v7));
            v9 = v9 + 1;
        };
        let v10 = &mut v0;
        let v11 = b"";
        let v12 = 0;
        while (v12 < 0x2::bcs::peel_vec_length(v10)) {
            0x1::vector::push_back<u8>(&mut v11, 0x2::bcs::peel_u8(v10));
            v12 = v12 + 1;
        };
        let v13 = LocationProofMessage{
            server_address       : 0x2::bcs::peel_address(&mut v0),
            player_address       : 0x2::bcs::peel_address(&mut v0),
            source_structure_id  : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            source_location_hash : v2,
            target_structure_id  : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            target_location_hash : v5,
            distance             : 0x2::bcs::peel_u64(&mut v0),
            data                 : v8,
            deadline_ms          : 0x2::bcs::peel_u64(&mut v0),
        };
        (v13, v11)
    }

    public fun update(arg0: &mut Location, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::AdminACL, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::verify_sponsor(arg1, arg3);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13835340616885731331);
        arg0.location_hash = arg2;
    }

    fun validate_proof_message(arg0: &LocationProofMessage, arg1: &Location, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::ServerAddressRegistry, arg3: address) {
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::is_authorized_server_address(arg2, arg0.server_address), 13836185278039457801);
        assert!(arg0.player_address == arg3, 13835622336675708933);
        assert!(arg0.target_location_hash == arg1.location_hash, 13835903815947517959);
    }

    public fun verify_distance(arg0: &Location, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::ServerAddressRegistry, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = unpack_proof(arg2);
        let v2 = v0;
        validate_proof_message(&v2, arg0, arg1, 0x2::tx_context::sender(arg4));
        assert!(v2.distance <= arg3, 13837029209048743951);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::sig_verify::verify_signature(0x2::bcs::to_bytes<LocationProofMessage>(&v2), v1, v2.server_address), 13836466289159831563);
    }

    public fun verify_proximity(arg0: &Location, arg1: LocationProof, arg2: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::ServerAddressRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let LocationProof {
            message   : v0,
            signature : v1,
        } = arg1;
        let v2 = v0;
        validate_proof_message(&v2, arg0, arg2, 0x2::tx_context::sender(arg4));
        assert!(is_deadline_valid(v2.deadline_ms, arg3), 13836747523618504717);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::sig_verify::verify_signature(0x2::bcs::to_bytes<LocationProofMessage>(&v2), v1, v2.server_address), 13836466078706434059);
    }

    public fun verify_proximity_proof_from_bytes(arg0: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access::ServerAddressRegistry, arg1: &Location, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = unpack_proof(arg2);
        let v2 = v0;
        validate_proof_message(&v2, arg1, arg0, 0x2::tx_context::sender(arg4));
        assert!(is_deadline_valid(v2.deadline_ms, arg3), 13836747630992687117);
        assert!(0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::sig_verify::verify_signature(0x2::bcs::to_bytes<LocationProofMessage>(&v2), v1, v2.server_address), 13836466186080616459);
    }

    public fun verify_same_location(arg0: vector<u8>, arg1: vector<u8>) {
        assert!(arg0 == arg1, 13835058948635361281);
    }

    public fun x(arg0: &Coordinates) : 0x1::string::String {
        arg0.x
    }

    public fun y(arg0: &Coordinates) : 0x1::string::String {
        arg0.y
    }

    public fun z(arg0: &Coordinates) : 0x1::string::String {
        arg0.z
    }

    // decompiled from Move bytecode v6
}

