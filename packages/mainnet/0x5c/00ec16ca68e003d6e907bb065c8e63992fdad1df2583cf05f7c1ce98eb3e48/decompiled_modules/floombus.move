module 0x5c00ec16ca68e003d6e907bb065c8e63992fdad1df2583cf05f7c1ce98eb3e48::floombus {
    struct FLOOMBUS has drop {
        dummy_field: bool,
    }

    struct MyFLOOMBUS has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
        total_supply: u64,
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        image_url: vector<u8>,
    }

    struct ProtectedTreasury has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    fun borrow_cap(arg0: &ProtectedTreasury) : &0x2::coin::TreasuryCap<FLOOMBUS> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<FLOOMBUS>>(&arg0.id, v0)
    }

    fun borrow_cap_mut(arg0: &mut ProtectedTreasury) : &mut 0x2::coin::TreasuryCap<FLOOMBUS> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<FLOOMBUS>>(&mut arg0.id, v0)
    }

    fun init(arg0: FLOOMBUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmX6niogLDLp2hQKa1wccnCYZ1WFzzjuihzKQmhqoxcqyW";
        let v1 = MyFLOOMBUS{
            id           : 0x2::object::new(arg1),
            max_supply   : 10000000000000000000,
            total_supply : 0,
            name         : b"FLOOMBUS2",
            symbol       : b"FLOOMBUS2",
            description  : b"This is FLOOMBUS",
            image_url    : v0,
        };
        let (v2, v3) = 0x2::coin::create_currency<FLOOMBUS>(arg0, 9, b"FLOOMBUS2", b"FLOOMBUS2", b"This is FLOOMBUS2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0)), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOOMBUS>>(v3);
        let v4 = ProtectedTreasury{id: 0x2::object::new(arg1)};
        let v5 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<FLOOMBUS>>(&mut v4.id, v5, v2);
        let v6 = 10000000000000000000;
        let v7 = &mut v4;
        v1.total_supply = v6;
        0x2::transfer::share_object<ProtectedTreasury>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<FLOOMBUS>>(0x2::coin::mint<FLOOMBUS>(borrow_cap_mut(v7), v6, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<MyFLOOMBUS>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

