module 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 9223372204358500353);
    }

    public(friend) fun create_version(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::current_version::current_version(),
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::current_version::current_version()
    }

    public fun upgrade(arg0: &mut Version, arg1: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap) {
        assert!(arg0.value == 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::current_version::current_version() - 1, 9223372165703794689);
        arg0.value = 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

