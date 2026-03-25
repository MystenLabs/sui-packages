module 0xcba1435faf4f67477ed2b53fbd64bcaab1db896d942410d52a6cacd38c472eb0::birth_certificate {
    struct BirthCertificate has key {
        id: 0x2::object::UID,
        generation: u64,
        dance: 0x1::string::String,
        video_url: 0x1::string::String,
        timestamp: u64,
        owner: address,
    }

    public fun dance(arg0: &BirthCertificate) : &0x1::string::String {
        &arg0.dance
    }

    public fun generation(arg0: &BirthCertificate) : u64 {
        arg0.generation
    }

    public fun mint(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = BirthCertificate{
            id         : 0x2::object::new(arg5),
            generation : arg0,
            dance      : 0x1::string::utf8(arg1),
            video_url  : 0x1::string::utf8(arg2),
            timestamp  : 0x2::clock::timestamp_ms(arg3),
            owner      : arg4,
        };
        0x2::transfer::transfer<BirthCertificate>(v0, arg4);
    }

    public fun owner(arg0: &BirthCertificate) : address {
        arg0.owner
    }

    public fun timestamp(arg0: &BirthCertificate) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v6
}

