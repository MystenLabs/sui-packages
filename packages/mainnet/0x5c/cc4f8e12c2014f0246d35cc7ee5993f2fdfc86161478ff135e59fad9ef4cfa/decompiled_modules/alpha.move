module 0x5ccc4f8e12c2014f0246d35cc7ee5993f2fdfc86161478ff135e59fad9ef4cfa::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    struct Admin_cap has store, key {
        id: 0x2::object::UID,
        owner_id: address,
    }

    struct Burn_start_cap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_admin(arg0: &Admin_cap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin_cap{
            id       : 0x2::object::new(arg2),
            owner_id : arg1,
        };
        0x2::transfer::public_transfer<Admin_cap>(v0, arg1);
    }

    public(friend) fun destroy_start_cap(arg0: Burn_start_cap) {
        let Burn_start_cap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA>(arg0, 9, b"ALPHA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALPHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Burn_start_cap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<Burn_start_cap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = Admin_cap{
            id       : 0x2::object::new(arg1),
            owner_id : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<Admin_cap>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

