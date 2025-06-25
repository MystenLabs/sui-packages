module 0xd1eed7398f412fad81c25fb1149d36b5572ae06f22a7f634847e860b50f7917::lunch {
    struct LUNCH has drop {
        dummy_field: bool,
    }

    struct ProtectedTreasury has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut ProtectedTreasury, arg1: 0x2::coin::Coin<LUNCH>) : u64 {
        0x2::coin::burn<LUNCH>(borrow_cap_mut(arg0), arg1)
    }

    public fun total_supply(arg0: &ProtectedTreasury) : u64 {
        0x2::coin::total_supply<LUNCH>(borrow_cap(arg0))
    }

    fun borrow_cap(arg0: &ProtectedTreasury) : &0x2::coin::TreasuryCap<LUNCH> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<LUNCH>>(&arg0.id, v0)
    }

    fun borrow_cap_mut(arg0: &mut ProtectedTreasury) : &mut 0x2::coin::TreasuryCap<LUNCH> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<LUNCH>>(&mut arg0.id, v0)
    }

    fun init(arg0: LUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNCH>(arg0, 8, b"LUNCH", b"Lunch Protocol", b"Lunch Protocol aims to simplify and automate DeFi yield and reward farming with AI agents, built on its secure, pre-whitelisted dApp integration platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dx5zqfxdqna0k.cloudfront.net/lunch/Lunch_Token_Symbol.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUNCH>>(v1);
        let v3 = ProtectedTreasury{id: 0x2::object::new(arg1)};
        let v4 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<LUNCH>>(&mut v3.id, v4, v2);
        0x2::transfer::share_object<ProtectedTreasury>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<LUNCH>>(0x2::coin::mint<LUNCH>(&mut v2, 1000000000 * 100000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

