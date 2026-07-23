module 0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack {
    struct JetpackConso has key {
        id: 0x2::object::UID,
        standard: 0x1::string::String,
        version: u16,
        jetpack_id: u64,
        player: address,
        player_user_id: 0x1::option::Option<0x1::string::String>,
        play_count: u64,
        highest_score: u64,
        total_distance: u64,
        total_zaps: u64,
        character: 0x1::string::String,
        jetpack_type: 0x1::string::String,
        created_at_ms: u64,
        updated_at_ms: u64,
        metadata_uri: 0x1::option::Option<0x1::string::String>,
        extra_keys: vector<0x1::string::String>,
        extra_values: vector<0x1::string::String>,
    }

    public(friend) fun new(arg0: u64, arg1: address, arg2: 0x1::option::Option<0x1::string::String>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::option::Option<0x1::string::String>, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : JetpackConso {
        assert!(0x1::vector::length<0x1::string::String>(&arg10) == 0x1::vector::length<0x1::string::String>(&arg11), 0);
        let v0 = 0x2::clock::timestamp_ms(arg12);
        JetpackConso{
            id             : 0x2::object::new(arg13),
            standard       : 0x1::string::utf8(b"conso_jetpack"),
            version        : 1,
            jetpack_id     : arg0,
            player         : arg1,
            player_user_id : arg2,
            play_count     : arg3,
            highest_score  : arg4,
            total_distance : arg5,
            total_zaps     : arg6,
            character      : arg7,
            jetpack_type   : arg8,
            created_at_ms  : v0,
            updated_at_ms  : v0,
            metadata_uri   : arg9,
            extra_keys     : arg10,
            extra_values   : arg11,
        }
    }

    public fun character(arg0: &JetpackConso) : &0x1::string::String {
        &arg0.character
    }

    public fun created_at_ms(arg0: &JetpackConso) : u64 {
        arg0.created_at_ms
    }

    public(friend) fun destroy(arg0: JetpackConso) {
        let JetpackConso {
            id             : v0,
            standard       : _,
            version        : _,
            jetpack_id     : _,
            player         : _,
            player_user_id : _,
            play_count     : _,
            highest_score  : _,
            total_distance : _,
            total_zaps     : _,
            character      : _,
            jetpack_type   : _,
            created_at_ms  : _,
            updated_at_ms  : _,
            metadata_uri   : _,
            extra_keys     : _,
            extra_values   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun extra_keys(arg0: &JetpackConso) : &vector<0x1::string::String> {
        &arg0.extra_keys
    }

    public fun extra_values(arg0: &JetpackConso) : &vector<0x1::string::String> {
        &arg0.extra_values
    }

    public fun highest_score(arg0: &JetpackConso) : u64 {
        arg0.highest_score
    }

    public fun id(arg0: &JetpackConso) : &0x2::object::UID {
        &arg0.id
    }

    public fun jetpack_id(arg0: &JetpackConso) : u64 {
        arg0.jetpack_id
    }

    public fun jetpack_type(arg0: &JetpackConso) : &0x1::string::String {
        &arg0.jetpack_type
    }

    public fun metadata_uri(arg0: &JetpackConso) : &0x1::option::Option<0x1::string::String> {
        &arg0.metadata_uri
    }

    public fun play_count(arg0: &JetpackConso) : u64 {
        arg0.play_count
    }

    public fun player(arg0: &JetpackConso) : address {
        arg0.player
    }

    public fun player_user_id(arg0: &JetpackConso) : &0x1::option::Option<0x1::string::String> {
        &arg0.player_user_id
    }

    public(friend) fun set_metadata_uri(arg0: &mut JetpackConso, arg1: 0x1::string::String, arg2: u64) {
        arg0.metadata_uri = 0x1::option::some<0x1::string::String>(arg1);
        arg0.updated_at_ms = arg2;
    }

    public fun standard(arg0: &JetpackConso) : &0x1::string::String {
        &arg0.standard
    }

    public fun total_distance(arg0: &JetpackConso) : u64 {
        arg0.total_distance
    }

    public fun total_zaps(arg0: &JetpackConso) : u64 {
        arg0.total_zaps
    }

    public(friend) fun transfer_to(arg0: JetpackConso, arg1: address) {
        0x2::transfer::transfer<JetpackConso>(arg0, arg1);
    }

    public fun updated_at_ms(arg0: &JetpackConso) : u64 {
        arg0.updated_at_ms
    }

    public fun version(arg0: &JetpackConso) : u16 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

