module 0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::claim {
    struct ClaimStampEvent has copy, drop {
        recipient: address,
        event: 0x1::string::String,
        stamp: 0x2::object::ID,
    }

    struct ClaimStampInfo has drop {
        passport: 0x2::object::ID,
        last_time: u64,
    }

    public fun claim_stamp(arg0: &mut 0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::stamp::Event, arg1: &mut 0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::sui_passport::SuiPassport, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::stamp::new(arg0, arg2, arg6);
        0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::version::check_version(arg4);
        let v2 = ClaimStampInfo{
            passport  : 0x2::object::id<0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::sui_passport::SuiPassport>(arg1),
            last_time : 0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::sui_passport::last_time(arg1),
        };
        let v3 = 0x2::bcs::to_bytes<ClaimStampInfo>(&v2);
        let v4 = 0x2::hash::keccak256(&v3);
        let v5 = x"5d3312bd147038cbb5eac03f683eb63c81d028002132e9884644dc8d83e26a26";
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v5, &v4) == true, 1);
        let v6 = ClaimStampEvent{
            recipient : v0,
            event     : 0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::stamp::event_name(arg0),
            stamp     : 0x2::object::id<0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::stamp::Stamp>(&v1),
        };
        0x2::event::emit<ClaimStampEvent>(v6);
        0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::sui_passport::show_stamp(arg1, &v1, arg4, arg5);
        0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::stamp::transfer_stamp(v1, v0);
    }

    // decompiled from Move bytecode v6
}

