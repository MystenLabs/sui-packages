module 0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui {
    struct PUI has drop {
        dummy_field: bool,
    }

    struct MintTracker has key {
        id: 0x2::object::UID,
        total_minted: u64,
        minted_addresses: 0x2::vec_set::VecSet<address>,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PUI>, arg1: &mut MintTracker, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.total_minted + arg2 <= 4000000000, 1);
        assert!(!0x2::vec_set::contains<address>(&arg1.minted_addresses, &arg3), 2);
        0x2::vec_set::insert<address>(&mut arg1.minted_addresses, arg3);
        arg1.total_minted = arg1.total_minted + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<PUI>>(0x2::coin::mint<PUI>(arg0, arg2, arg4), arg3);
        let v0 = MintEvent{
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public fun get_total_minted(arg0: &MintTracker) : u64 {
        arg0.total_minted
    }

    fun init(arg0: PUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUI>(arg0, 0, b"PUI", b"Pui", b"Pussy On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/c1zZCCcSPBUeniPJFF5_JEB5CrL_qdqtbNrjxC5J0JQ")), arg1);
        let v2 = v0;
        let v3 = 100000000;
        let v4 = MintTracker{
            id               : 0x2::object::new(arg1),
            total_minted     : v3,
            minted_addresses : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUI>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PUI>>(v2);
        0x2::transfer::share_object<MintTracker>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<PUI>>(0x2::coin::mint<PUI>(&mut v2, v3, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

