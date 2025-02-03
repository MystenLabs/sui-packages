module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::verifier {
    public(friend) fun verify_creation_time(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = arg0 >= 0x2::clock::timestamp_ms(arg2) && arg1 > arg0;
        if (!v0) {
            abort 0
        };
    }

    public(friend) fun verify_currency(arg0: &0x2::vec_set::VecSet<0x1::ascii::String>, arg1: &0x1::ascii::String, arg2: bool) : bool {
        let v0 = 0x2::vec_set::is_empty<0x1::ascii::String>(arg0) || 0x2::vec_set::contains<0x1::ascii::String>(arg0, arg1);
        if (!v0 && arg2) {
            abort 2
        };
        v0
    }

    public(friend) fun verify_length<T0, T1>(arg0: &vector<T0>, arg1: &vector<T1>, arg2: bool) : bool {
        let v0 = 0x1::vector::length<T0>(arg0) == 0x1::vector::length<T1>(arg1);
        if (!v0 && arg2) {
            abort 1
        };
        v0
    }

    public(friend) fun verify_time(arg0: u64, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : bool {
        let v0 = arg0 <= 0x2::clock::timestamp_ms(arg3) && arg1 > 0x2::clock::timestamp_ms(arg3);
        if (!v0 && arg2) {
            abort 0
        };
        v0
    }

    // decompiled from Move bytecode v6
}

