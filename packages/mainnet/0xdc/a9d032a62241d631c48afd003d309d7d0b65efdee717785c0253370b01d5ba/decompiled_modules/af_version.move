module 0xdca9d032a62241d631c48afd003d309d7d0b65efdee717785c0253370b01d5ba::af_version {
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
            value : 0xdca9d032a62241d631c48afd003d309d7d0b65efdee717785c0253370b01d5ba::af_current_version::current_version(),
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0xdca9d032a62241d631c48afd003d309d7d0b65efdee717785c0253370b01d5ba::af_current_version::current_version()
    }

    public fun upgrade(arg0: &mut Version, arg1: &0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::AdminCap) {
        assert!(arg0.value == 0xdca9d032a62241d631c48afd003d309d7d0b65efdee717785c0253370b01d5ba::af_current_version::current_version() - 1, 9223372165703794689);
        arg0.value = 0xdca9d032a62241d631c48afd003d309d7d0b65efdee717785c0253370b01d5ba::af_current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

