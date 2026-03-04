module 0x981b09e8409fe8bb50582bcc2fa806e079e025b9e9609a8ceb3f4843965fa315::xvx {
    struct XVX has drop {
        dummy_field: bool,
    }

    struct XVXTreasuryVault has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<XVX>,
    }

    struct BurnTotalKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        sender: address,
        total_burned_after: u64,
    }

    public entry fun burn(arg0: &mut XVXTreasuryVault, arg1: 0x2::coin::Coin<XVX>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<XVX>(&arg1);
        let v1 = BurnTotalKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BurnTotalKey>(&arg0.id, v1)) {
            let v2 = BurnTotalKey{dummy_field: false};
            0x2::dynamic_field::add<BurnTotalKey, u64>(&mut arg0.id, v2, 0);
        };
        let v3 = BurnTotalKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<BurnTotalKey, u64>(&mut arg0.id, v3);
        *v4 = *v4 + v0;
        let v5 = BurnEvent{
            amount             : v0,
            sender             : 0x2::tx_context::sender(arg2),
            total_burned_after : *v4,
        };
        0x2::event::emit<BurnEvent>(v5);
        0x2::coin::burn<XVX>(&mut arg0.cap, arg1);
    }

    public fun decimals() : u8 {
        9
    }

    public fun description() : vector<u8> {
        b"Deflationary digital asset for the VOIDX ecosystem on Sui, featuring permanent burn mechanics."
    }

    fun init(arg0: XVX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidzonrdthvzc3rcndnmn4rs22ez4wn7sitd5vubhkz3bzffhfqw74"))
        };
        let (v1, v2) = 0x2::coin::create_currency<XVX>(arg0, 9, b"XVX", b"VOIDX", b"Deflationary digital asset for the VOIDX ecosystem on Sui, featuring permanent burn mechanics.", v0, arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XVX>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<XVX>>(0x2::coin::mint<XVX>(&mut v3, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v4 = XVXTreasuryVault{
            id  : 0x2::object::new(arg1),
            cap : v3,
        };
        let v5 = BurnTotalKey{dummy_field: false};
        0x2::dynamic_field::add<BurnTotalKey, u64>(&mut v4.id, v5, 0);
        0x2::transfer::share_object<XVXTreasuryVault>(v4);
    }

    public entry fun init_burn_counter(arg0: &mut XVXTreasuryVault) {
        let v0 = BurnTotalKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BurnTotalKey>(&arg0.id, v0)) {
            let v1 = BurnTotalKey{dummy_field: false};
            0x2::dynamic_field::add<BurnTotalKey, u64>(&mut arg0.id, v1, 0);
        };
    }

    public fun name() : vector<u8> {
        b"VOIDX"
    }

    public fun remaining_supply(arg0: &XVXTreasuryVault) : u64 {
        1000000000000000000 - total_burned(arg0)
    }

    public fun supply() : u64 {
        1000000000000000000
    }

    public fun symbol() : vector<u8> {
        b"XVX"
    }

    public fun total_burned(arg0: &XVXTreasuryVault) : u64 {
        let v0 = BurnTotalKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BurnTotalKey>(&arg0.id, v0)) {
            0
        } else {
            let v2 = BurnTotalKey{dummy_field: false};
            *0x2::dynamic_field::borrow<BurnTotalKey, u64>(&arg0.id, v2)
        }
    }

    // decompiled from Move bytecode v6
}

