module 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::mbtc {
    struct MBTC has drop {
        dummy_field: bool,
    }

    struct TreasuryCapManager has key {
        id: 0x2::object::UID,
        version: u8,
        treasury: 0x2::coin::TreasuryCap<MBTC>,
        revoked_minters: vector<0x2::object::ID>,
        revoked_burners: vector<0x2::object::ID>,
    }

    public fun burn(arg0: 0x2::coin::Coin<MBTC>, arg1: &mut TreasuryCapManager, arg2: &0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::BurnerCap, arg3: &0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::AccessConfig) : u64 {
        0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::assert_not_paused(arg3);
        check_version(arg1.version);
        let v0 = 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::get_burner_cap_id(arg2);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_burners, &v0), 2);
        0x2::coin::burn<MBTC>(&mut arg1.treasury, arg0)
    }

    public fun mint(arg0: u64, arg1: &mut TreasuryCapManager, arg2: &0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::MinterCap, arg3: &0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::AccessConfig, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MBTC> {
        0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::assert_not_paused(arg3);
        check_version(arg1.version);
        let v0 = 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::get_minter_cap_id(arg2);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_minters, &v0), 2);
        0x2::coin::mint<MBTC>(&mut arg1.treasury, arg0, arg4)
    }

    public fun is_paused(arg0: &0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::AccessConfig) : bool {
        0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::is_paused(arg0)
    }

    public entry fun set_pause(arg0: bool, arg1: &mut 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::AccessConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::assert_pause_admin(arg1, 0x2::tx_context::sender(arg2));
        0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::set_pause(arg1, arg0);
    }

    fun check_version(arg0: u8) {
        assert!(arg0 == 0, 1);
    }

    fun init(arg0: MBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MBTC>(arg0, 8, b"MBTC", b"MBTC", b"MBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeidyt4flt6m7ym2rjwmn74qyibw7kodhrbml7cyanmxrxmffaxseme.ipfs.w3s.link/mbtc.svg")), true, arg1);
        let v3 = TreasuryCapManager{
            id              : 0x2::object::new(arg1),
            version         : 0,
            treasury        : v0,
            revoked_minters : 0x1::vector::empty<0x2::object::ID>(),
            revoked_burners : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<TreasuryCapManager>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MBTC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MBTC>>(v2);
    }

    entry fun migrate(arg0: &mut TreasuryCapManager, arg1: &0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::AdminCap) {
        assert!(arg0.version < 0, 0);
        arg0.version = 0;
    }

    public entry fun revoke_burner_cap(arg0: 0x2::object::ID, arg1: &mut TreasuryCapManager, arg2: &mut 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::AccessConfig, arg3: &0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::AdminCap) {
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_burners, &arg0), 3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.revoked_burners, arg0);
        0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::burner_cap_revoked(arg0, arg2);
    }

    public entry fun revoke_minter_cap(arg0: 0x2::object::ID, arg1: &mut TreasuryCapManager, arg2: &mut 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::AccessConfig, arg3: &0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::AdminCap) {
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_minters, &arg0), 3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.revoked_minters, arg0);
        0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::minter_cap_revoked(arg0, arg2);
    }

    public fun revoked_burners(arg0: &TreasuryCapManager) : vector<0x2::object::ID> {
        arg0.revoked_burners
    }

    public fun revoked_minters(arg0: &TreasuryCapManager) : vector<0x2::object::ID> {
        arg0.revoked_minters
    }

    // decompiled from Move bytecode v6
}

