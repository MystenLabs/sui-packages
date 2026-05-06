module 0x81f08b7b486687266f580bbdb51b27ccb2249e8853af1a998908e4494054ad75::vovina_token {
    struct VOVINA_TOKEN has drop {
        dummy_field: bool,
    }

    struct VovinaLock has key {
        id: 0x2::object::UID,
        authority: address,
        frozen: bool,
        locked_supply: u64,
    }

    struct VovinaInitialized has copy, drop {
        authority: address,
        total_supply: u64,
    }

    struct SupplyFrozen has copy, drop {
        locked_supply: u64,
    }

    public fun authority(arg0: &VovinaLock) : address {
        arg0.authority
    }

    public fun freeze_supply(arg0: &mut VovinaLock, arg1: 0x2::coin::TreasuryCap<VOVINA_TOKEN>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.authority, 1);
        assert!(!arg0.frozen, 2);
        arg0.frozen = true;
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VOVINA_TOKEN>>(arg1);
        let v0 = SupplyFrozen{locked_supply: arg0.locked_supply};
        0x2::event::emit<SupplyFrozen>(v0);
    }

    fun init(arg0: VOVINA_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOVINA_TOKEN>(arg0, 9, b"VOVINA", b"VOVINA Sovereign Reserve", b"Algorithmically locked at 1,000,000,000 forever. The on-chain seal of the Sovereign Stack.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4QAYRXhpZgAA...")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<VOVINA_TOKEN>>(0x2::coin::mint<VOVINA_TOKEN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOVINA_TOKEN>>(v1);
        let v3 = VovinaLock{
            id            : 0x2::object::new(arg1),
            authority     : 0x2::tx_context::sender(arg1),
            frozen        : false,
            locked_supply : 1000000000000000000,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOVINA_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<VovinaLock>(v3);
        let v4 = VovinaInitialized{
            authority    : 0x2::tx_context::sender(arg1),
            total_supply : 1000000000000000000,
        };
        0x2::event::emit<VovinaInitialized>(v4);
    }

    public fun is_frozen(arg0: &VovinaLock) : bool {
        arg0.frozen
    }

    public fun locked_supply(arg0: &VovinaLock) : u64 {
        arg0.locked_supply
    }

    // decompiled from Move bytecode v6
}

