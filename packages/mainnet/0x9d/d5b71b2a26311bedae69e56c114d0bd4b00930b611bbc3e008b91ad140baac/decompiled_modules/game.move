module 0x9dd5b71b2a26311bedae69e56c114d0bd4b00930b611bbc3e008b91ad140baac::game {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct TONMINER has drop {
        dummy_field: bool,
    }

    struct GAME has store, key {
        id: 0x2::object::UID,
    }

    struct GameInfo has key {
        id: 0x2::object::UID,
        version: u8,
        gas_fee: u16,
        ref1: u16,
    }

    struct GameAccount has store, key {
        id: 0x2::object::UID,
        referral: address,
    }

    entry fun add_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: 0x2::coin::TreasuryCap<TONMINER>) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::coin::TreasuryCap<TONMINER>>(&mut arg1.id, 0x1::string::utf8(b"treasury"), arg2);
    }

    public entry fun create_user(arg0: &mut GameInfo, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"CREATE_USER:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        let v2 = GameAccount{
            id       : 0x2::object::new(arg3),
            referral : arg2,
        };
        0x2::dynamic_object_field::add<address, GameAccount>(&mut arg0.id, arg1, v2);
    }

    // decompiled from Move bytecode v6
}

