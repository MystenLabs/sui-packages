module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map {
    struct City has copy, drop, store {
        name: 0x1::string::String,
        x: u32,
        z: u32,
        dungeon: 0x2::object::ID,
    }

    fun absolute_delta(arg0: u32, arg1: u32) : u32 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun assert_valid(arg0: &vector<City>) {
        assert!(0x1::vector::length<City>(arg0) <= 256, 3203);
        let v0 = 0;
        while (v0 < 0x1::vector::length<City>(arg0)) {
            let v1 = v0 + 1;
            while (v1 < 0x1::vector::length<City>(arg0)) {
                assert!(absolute_delta(0x1::vector::borrow<City>(arg0, v0).x / 512, 0x1::vector::borrow<City>(arg0, v1).x / 512) > 2 || absolute_delta(0x1::vector::borrow<City>(arg0, v0).z / 512, 0x1::vector::borrow<City>(arg0, v1).z / 512) > 2, 3202);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    public fun city_by_name(arg0: &vector<City>, arg1: &0x1::string::String) : 0x1::option::Option<City> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<City>(arg0)) {
            if (&0x1::vector::borrow<City>(arg0, v0).name == arg1) {
                return 0x1::option::some<City>(*0x1::vector::borrow<City>(arg0, v0))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<City>()
    }

    public fun city_for_dungeon(arg0: &vector<City>, arg1: 0x2::object::ID) : 0x1::option::Option<City> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<City>(arg0)) {
            if (0x1::vector::borrow<City>(arg0, v0).dungeon == arg1) {
                return 0x1::option::some<City>(*0x1::vector::borrow<City>(arg0, v0))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<City>()
    }

    public fun city_index_at(arg0: &vector<City>, arg1: u32, arg2: u32) : 0x1::option::Option<u8> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<City>(arg0)) {
            if (contains_zone(0x1::vector::borrow<City>(arg0, v0), arg1, arg2)) {
                return 0x1::option::some<u8>((v0 as u8))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u8>()
    }

    public fun contains_zone(arg0: &City, arg1: u32, arg2: u32) : bool {
        absolute_delta(arg1, arg0.x / 512) <= 1 && absolute_delta(arg2, arg0.z / 512) <= 1
    }

    public fun dungeon(arg0: &City) : 0x2::object::ID {
        arg0.dungeon
    }

    public fun name(arg0: &City) : 0x1::string::String {
        arg0.name
    }

    public fun new_city(arg0: 0x1::string::String, arg1: u32, arg2: u32, arg3: 0x2::object::ID) : City {
        let v0 = arg1 / 512;
        let v1 = arg2 / 512;
        assert!(arg1 < 100000 && arg2 < 100000, 3201);
        let v2 = if (v0 > 0) {
            if (v0 < 195) {
                if (v1 > 0) {
                    v1 < 195
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 3201);
        City{
            name    : arg0,
            x       : arg1,
            z       : arg2,
            dungeon : arg3,
        }
    }

    public fun x(arg0: &City) : u32 {
        arg0.x
    }

    public fun z(arg0: &City) : u32 {
        arg0.z
    }

    // decompiled from Move bytecode v7
}

