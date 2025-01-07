module 0x74d9ad9eecbeed318d57cd00188bb4c98b32f8be35f7886e8e0ef232e63013f9::loh {
    struct LOH has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<LOH>,
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
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOH>>(v1);
        0x2::transfer::public_transfer<TreasuryCapHolder>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

