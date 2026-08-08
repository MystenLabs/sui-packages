module 0x90b77939a51d5fe74ef754cc94661d03aa9f64e6f1fb75f4e08bd9e70a6f2bd9::crown {
    struct CROWN has drop {
        dummy_field: bool,
    }

    struct CrownMigrated has copy, drop {
        source_tx_hash: vector<u8>,
        amount: u64,
        recipient: address,
    }

    fun init(arg0: CROWN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::new_admin<CROWN>(&arg0, arg1);
        let (v1, v2) = 0x2::coin_registry::new_currency_with_otw<CROWN>(arg0, 9, 0x1::string::utf8(b"CRN"), 0x1::string::utf8(b"CROWN"), 0x1::string::utf8(b"Emerald City CROWN token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_share_object<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::fixed_coin::CappedTreasury<CROWN>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::fixed_coin::wrap<CROWN>(v2, 250000000000000000, arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CROWN>>(0x2::coin_registry::finalize<CROWN>(v1, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<CROWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<CROWN>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::issue_minter<CROWN>(&v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<CROWN>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::fixed_coin::CappedTreasury<CROWN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CROWN> {
        assert!(arg2 > 0, 13906834569480503299);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::fixed_coin::mint_capped<CROWN>(arg0, arg1, arg2, arg3)
    }

    public fun mint_migrated(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<CROWN>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::fixed_coin::CappedTreasury<CROWN>, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 13906834509350961155);
        0x2::transfer::public_transfer<0x2::coin::Coin<CROWN>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::fixed_coin::mint_capped<CROWN>(arg0, arg1, arg2, arg5), arg3);
        let v0 = CrownMigrated{
            source_tx_hash : arg4,
            amount         : arg2,
            recipient      : arg3,
        };
        0x2::event::emit<CrownMigrated>(v0);
    }

    // decompiled from Move bytecode v7
}

