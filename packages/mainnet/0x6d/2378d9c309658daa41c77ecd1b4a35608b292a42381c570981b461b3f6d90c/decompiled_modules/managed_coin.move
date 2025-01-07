module 0x6d2378d9c309658daa41c77ecd1b4a35608b292a42381c570981b461b3f6d90c::managed_coin {
    struct MANAGED_COIN has drop {
        dummy_field: bool,
    }

    struct CapManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        manager: address,
    }

    public fun admin_burn(arg0: &mut CapManager<MANAGED_COIN>, arg1: 0x2::coin::Coin<MANAGED_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 0);
        0x2::coin::burn<MANAGED_COIN>(&mut arg0.treasury_cap, arg1);
    }

    public fun admin_mint_to(arg0: &mut CapManager<MANAGED_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0);
        0x2::coin::mint_and_transfer<MANAGED_COIN>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    fun init(arg0: MANAGED_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGED_COIN>(arg0, 0, b"MNG", b"Managed Coin", b"This is a coin that can be managed by a manager.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGED_COIN>>(v1);
        0x2::coin::mint_and_transfer<MANAGED_COIN>(&mut v2, 100, 0x2::tx_context::sender(arg1), arg1);
        let v3 = CapManager<MANAGED_COIN>{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
            manager      : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_share_object<CapManager<MANAGED_COIN>>(v3);
    }

    public fun update_manager(arg0: &mut CapManager<MANAGED_COIN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.manager != arg1, 0);
        arg0.manager = arg1;
    }

    // decompiled from Move bytecode v6
}

