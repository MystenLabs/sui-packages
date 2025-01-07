module 0xfe8b49d242836d391526659bc51b94e69a7723bb11bde755f7d9c5a14fe47a7::game {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct TONMINER has drop {
        dummy_field: bool,
    }

    struct GameInfo has key {
        id: 0x2::object::UID,
        version: u8,
        operator_pk: vector<u8>,
        gas_fee: u16,
        ref1: u16,
    }

    struct CreateUser has copy, drop, store {
        user_address: address,
        ref_address: address,
    }

    struct GameAccount has store, key {
        id: 0x2::object::UID,
        referral: address,
        last_claim: u64,
    }

    entry fun add_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: 0x2::coin::TreasuryCap<TONMINER>) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::coin::TreasuryCap<TONMINER>>(&mut arg1.id, 0x1::string::utf8(b"treasury"), arg2);
    }

    public entry fun create_user(arg0: &mut GameInfo, arg1: address, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"CREATE_USER:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.operator_pk, &v1) == true, 3);
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 4);
        let v2 = GameAccount{
            id         : 0x2::object::new(arg5),
            referral   : arg2,
            last_claim : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::dynamic_object_field::add<address, GameAccount>(&mut arg0.id, arg1, v2);
        let v3 = CreateUser{
            user_address : arg1,
            ref_address  : arg2,
        };
        0x2::event::emit<CreateUser>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v1 = GameInfo{
            id          : 0x2::object::new(arg0),
            version     : 1,
            operator_pk : 0x2::bcs::to_bytes<address>(&v0),
            gas_fee     : 3000,
            ref1        : 2000,
        };
        0x2::transfer::share_object<GameInfo>(v1);
    }

    // decompiled from Move bytecode v6
}

