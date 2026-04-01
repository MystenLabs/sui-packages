module 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::redirects {
    struct Redirect has drop, store {
        location: 0x1::string::String,
        status_code: u16,
    }

    struct Redirects has drop, store {
        redirect_list: 0x2::vec_map::VecMap<0x1::string::String, Redirect>,
    }

    public fun empty() : Redirects {
        Redirects{redirect_list: 0x2::vec_map::empty<0x1::string::String, Redirect>()}
    }

    public fun length(arg0: &Redirects) : u64 {
        0x2::vec_map::length<0x1::string::String, Redirect>(&arg0.redirect_list)
    }

    public fun get(arg0: &Redirects, arg1: &0x1::string::String) : (&0x1::string::String, u16) {
        let v0 = 0x2::vec_map::get<0x1::string::String, Redirect>(&arg0.redirect_list, arg1);
        (&v0.location, v0.status_code)
    }

    public fun insert(arg0: &mut Redirects, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u16) {
        let v0 = if (arg3 == 301) {
            true
        } else if (arg3 == 302) {
            true
        } else if (arg3 == 303) {
            true
        } else if (arg3 == 307) {
            true
        } else {
            arg3 == 308
        };
        assert!(v0, 0);
        let v1 = Redirect{
            location    : arg2,
            status_code : arg3,
        };
        0x2::vec_map::insert<0x1::string::String, Redirect>(&mut arg0.redirect_list, arg1, v1);
    }

    public fun remove(arg0: &mut Redirects, arg1: &0x1::string::String) : (0x1::string::String, 0x1::string::String, u16) {
        let (v0, v1) = 0x2::vec_map::remove<0x1::string::String, Redirect>(&mut arg0.redirect_list, arg1);
        let Redirect {
            location    : v2,
            status_code : v3,
        } = v1;
        (v0, v2, v3)
    }

    public fun fill(arg0: &mut Redirects, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<u16>) {
        let v0 = &mut arg0.redirect_list;
        let v1 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v1 == 0x1::vector::length<0x1::string::String>(&arg2), 1);
        assert!(v1 == 0x1::vector::length<u16>(&arg3), 2);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x1::vector::pop_back<u16>(&mut arg3);
            let v4 = if (v3 == 301) {
                true
            } else if (v3 == 302) {
                true
            } else if (v3 == 303) {
                true
            } else if (v3 == 307) {
                true
            } else {
                v3 == 308
            };
            assert!(v4, 0);
            let v5 = Redirect{
                location    : 0x1::vector::pop_back<0x1::string::String>(&mut arg2),
                status_code : v3,
            };
            0x2::vec_map::insert<0x1::string::String, Redirect>(v0, 0x1::vector::pop_back<0x1::string::String>(&mut arg1), v5);
            v2 = v2 + 1;
        };
    }

    public fun filled(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>, arg2: vector<u16>) : Redirects {
        let v0 = Redirects{redirect_list: 0x2::vec_map::empty<0x1::string::String, Redirect>()};
        let v1 = &mut v0;
        fill(v1, arg0, arg1, arg2);
        v0
    }

    // decompiled from Move bytecode v6
}

