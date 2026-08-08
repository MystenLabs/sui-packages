module 0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet {
    struct GBET has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        version: u64,
        cap: 0x2::coin::TreasuryCap<GBET>,
    }

    struct GbetMigrated has copy, drop {
        source_tx_hash: vector<u8>,
        amount: u64,
        recipient: address,
    }

    public fun burn(arg0: &mut TreasuryCapHolder, arg1: 0x2::coin::Coin<GBET>) : u64 {
        assert_version(arg0);
        0x2::coin::burn<GBET>(&mut arg0.cap, arg1)
    }

    public fun mint(arg0: &mut TreasuryCapHolder, arg1: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<GBET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<GBET> {
        assert_version(arg0);
        0x2::coin::mint<GBET>(&mut arg0.cap, arg2, arg3)
    }

    fun assert_version(arg0: &TreasuryCapHolder) {
        assert!(arg0.version == 1, 13906834526530764802);
    }

    fun init(arg0: GBET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GBET>(arg0, 9, 0x1::string::utf8(b"GBET"), 0x1::string::utf8(b"GangstaBet Token"), 0x1::string::utf8(b"GangstaBet ecosystem token"), 0x1::string::utf8(b""), arg1);
        let v2 = TreasuryCapHolder{
            id      : 0x2::object::new(arg1),
            version : 1,
            cap     : v1,
        };
        0x2::transfer::share_object<TreasuryCapHolder>(v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GBET>>(0x2::coin_registry::finalize<GBET>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<GBET>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::new_admin<GBET>(&arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun migrate(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<GBET>, arg1: &mut TreasuryCapHolder) {
        assert!(arg1.version < 1, 13906834556595666948);
        arg1.version = 1;
    }

    public fun mint_migrated(arg0: &mut TreasuryCapHolder, arg1: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<GBET>, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<GBET>>(0x2::coin::mint<GBET>(&mut arg0.cap, arg2, arg5), arg3);
        let v0 = GbetMigrated{
            source_tx_hash : arg4,
            amount         : arg2,
            recipient      : arg3,
        };
        0x2::event::emit<GbetMigrated>(v0);
    }

    public fun version(arg0: &TreasuryCapHolder) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

