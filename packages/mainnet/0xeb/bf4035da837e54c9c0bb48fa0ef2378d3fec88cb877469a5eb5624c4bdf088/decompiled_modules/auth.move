module 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::auth {
    struct Auth {
        uid: 0x1::string::String,
        expire_at: u64,
    }

    public fun auth(arg0: &vector<u8>, arg1: vector<u8>, arg2: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg3: &0x2::clock::Clock) : Auth {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_license(arg2, 0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::F0Auth());
        assert!(0x2::ed25519::ed25519_verify(arg0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::get_config<vector<u8>>(arg2, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::CONFIG_KEY_AUTH_PUBLIC()), &arg1) == true, 1);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = Auth{
            uid       : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            expire_at : 0x2::bcs::peel_u64(&mut v0),
        };
        assert!(0x2::clock::timestamp_ms(arg3) < v1.expire_at, 2);
        v1
    }

    public(friend) fun auth_once(arg0: &vector<u8>, arg1: vector<u8>, arg2: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg3: &0x2::clock::Clock) : (0x1::string::String, u64) {
        let v0 = auth(arg0, arg1, arg2, arg3);
        drop(v0);
        (v0.uid, v0.expire_at)
    }

    public fun drop(arg0: Auth) {
        let Auth {
            uid       : _,
            expire_at : _,
        } = arg0;
    }

    public(friend) fun uid(arg0: &Auth) : 0x1::string::String {
        arg0.uid
    }

    // decompiled from Move bytecode v6
}

