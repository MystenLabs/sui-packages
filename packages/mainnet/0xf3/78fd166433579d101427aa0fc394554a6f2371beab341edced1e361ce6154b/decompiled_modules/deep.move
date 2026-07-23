module 0xf378fd166433579d101427aa0fc394554a6f2371beab341edced1e361ce6154b::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    struct ProtectedTreasury has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut ProtectedTreasury, arg1: 0x2::coin::Coin<DEEP>) {
        0x2::coin::burn<DEEP>(borrow_cap_mut(arg0), arg1);
    }

    public fun total_supply(arg0: &ProtectedTreasury) : u64 {
        0x2::coin::total_supply<DEEP>(borrow_cap(arg0))
    }

    fun borrow_cap(arg0: &ProtectedTreasury) : &0x2::coin::TreasuryCap<DEEP> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<DEEP>>(&arg0.id, v0)
    }

    fun borrow_cap_mut(arg0: &mut ProtectedTreasury) : &mut 0x2::coin::TreasuryCap<DEEP> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<DEEP>>(&mut arg0.id, v0)
    }

    fun create_coin(arg0: DEEP, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (ProtectedTreasury, 0x2::coin::Coin<DEEP>) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 6, b"OBX", b"OBDEX Protocol Token", b"Internal protocol token for the independently deployed OBDEX order book.", 0x1::option::none<0x2::url::Url>(), arg2);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEP>>(v1);
        let v3 = ProtectedTreasury{id: 0x2::object::new(arg2)};
        let v4 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<DEEP>>(&mut v3.id, v4, v2);
        (v3, 0x2::coin::mint<DEEP>(&mut v2, arg1, arg2))
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_coin(arg0, 10000000000000000, arg1);
        0x2::transfer::share_object<ProtectedTreasury>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<DEEP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

