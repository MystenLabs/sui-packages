module 0xcdca58ff26abf62719b2e88b1805fc47f4f3f0669f9cde13e267dae6c38731c6::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    struct Admin_cap has store, key {
        id: 0x2::object::UID,
        owner_id: 0x2::object::ID,
    }

    public fun add_admin(arg0: &Admin_cap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = Admin_cap{
            id       : v0,
            owner_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::public_transfer<Admin_cap>(v1, arg1);
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA>(arg0, 9, b"ALPHA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = 0x2::object::new(arg1);
        let v3 = Admin_cap{
            id       : v2,
            owner_id : 0x2::object::uid_to_inner(&v2),
        };
        0x2::transfer::public_transfer<Admin_cap>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

