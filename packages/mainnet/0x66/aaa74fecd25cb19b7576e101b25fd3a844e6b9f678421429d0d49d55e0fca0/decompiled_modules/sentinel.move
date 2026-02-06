module 0x66aaa74fecd25cb19b7576e101b25fd3a844e6b9f678421429d0d49d55e0fca0::sentinel {
    struct SENTINEL has drop {
        dummy_field: bool,
    }

    struct ProtectedTreasury has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut ProtectedTreasury, arg1: 0x2::coin::Coin<SENTINEL>) {
        0x2::coin::burn<SENTINEL>(borrow_cap_mut(arg0), arg1);
    }

    public fun total_supply(arg0: &ProtectedTreasury) : u64 {
        0x2::coin::total_supply<SENTINEL>(borrow_cap(arg0))
    }

    fun borrow_cap(arg0: &ProtectedTreasury) : &0x2::coin::TreasuryCap<SENTINEL> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<SENTINEL>>(&arg0.id, v0)
    }

    fun borrow_cap_mut(arg0: &mut ProtectedTreasury) : &mut 0x2::coin::TreasuryCap<SENTINEL> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<SENTINEL>>(&mut arg0.id, v0)
    }

    fun create_coin(arg0: SENTINEL, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (ProtectedTreasury, 0x2::coin::Coin<SENTINEL>) {
        let (v0, v1) = 0x2::coin::create_currency<SENTINEL>(arg0, 0, b"SENTINEL", b"Sentinel", b"Sentinel, utility token for Sui Sentinel, gamified AI security platform on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.suisentinel.xyz/sentinel_coin.png")), arg2);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SENTINEL>>(v1);
        let v3 = ProtectedTreasury{id: 0x2::object::new(arg2)};
        let v4 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<SENTINEL>>(&mut v3.id, v4, v2);
        (v3, 0x2::coin::mint<SENTINEL>(&mut v2, arg1, arg2))
    }

    fun init(arg0: SENTINEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_coin(arg0, 10000000000, arg1);
        0x2::transfer::share_object<ProtectedTreasury>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SENTINEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

