module 0xb6252ff154fd2a780aaa5b7be94ae989eaff2610c03c1bd0777f71c061ae3314::mooncake {
    struct Mooncake has key {
        id: 0x2::object::UID,
        type: 0x1::string::String,
        size: u8,
    }

    struct MooncakeRegistry has key {
        id: 0x2::object::UID,
        remaining_mooncake: u16,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MooncakeRegistry{
            id                 : 0x2::object::new(arg0),
            remaining_mooncake : 1000,
        };
        0x2::transfer::share_object<MooncakeRegistry>(v0);
    }

    public entry fun mint(arg0: &mut MooncakeRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.remaining_mooncake > 0, 0);
        arg0.remaining_mooncake = arg0.remaining_mooncake - 1;
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        let v2 = 0x2::bcs::new(0x2::hash::blake2b256(&v1));
        let v3 = if (0x2::bcs::peel_u8(&mut v2) % 2 == 0) {
            0x1::string::utf8(b"White Lotus")
        } else {
            0x1::string::utf8(b"Salted Egg Yolk")
        };
        let v4 = Mooncake{
            id   : v0,
            type : v3,
            size : 0x2::bcs::peel_u8(&mut v2),
        };
        0x2::transfer::transfer<Mooncake>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

