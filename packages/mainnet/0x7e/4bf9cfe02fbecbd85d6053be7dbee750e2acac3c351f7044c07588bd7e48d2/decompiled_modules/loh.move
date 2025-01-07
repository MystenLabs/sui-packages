module 0x7e4bf9cfe02fbecbd85d6053be7dbee750e2acac3c351f7044c07588bd7e48d2::loh {
    struct LOH has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<LOH>,
    }

    struct TreasuryCapEvent has copy, drop, store {
        treasury_cap_id: 0x2::object::ID,
    }

    public fun mint(arg0: &mut TreasuryCapHolder, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOH>>(0x2::coin::mint<LOH>(&mut arg0.treasury_cap, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: LOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOH>(arg0, 6, b"SMBL", b"Name", b"Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_D_N_D_N_D_d1b423d435.png")), arg1);
        let v2 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        let v3 = TreasuryCapEvent{treasury_cap_id: 0x2::object::id<0x2::coin::TreasuryCap<LOH>>(&v2.treasury_cap)};
        0x2::event::emit<TreasuryCapEvent>(v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOH>>(v1);
        0x2::transfer::public_transfer<TreasuryCapHolder>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

