module 0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::fbtc {
    struct FBTC has drop {
        dummy_field: bool,
    }

    struct TreasuryCapManager has key {
        id: 0x2::object::UID,
        version: u8,
        treasury: 0x2::coin::TreasuryCap<FBTC>,
        revoked_minters: vector<0x2::object::ID>,
        revoked_burners: vector<0x2::object::ID>,
    }

    public fun burn(arg0: 0x2::coin::Coin<FBTC>, arg1: &mut TreasuryCapManager, arg2: &0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::BurnerCap, arg3: &0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::AccessConfig) : u64 {
        0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::assert_not_paused(arg3);
        check_version(arg1.version);
        let v0 = 0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::get_burner_cap_id(arg2);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_burners, &v0), 2);
        0x2::coin::burn<FBTC>(&mut arg1.treasury, arg0)
    }

    public fun mint(arg0: u64, arg1: &mut TreasuryCapManager, arg2: &0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::MinterCap, arg3: &0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::AccessConfig, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FBTC> {
        0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::assert_not_paused(arg3);
        check_version(arg1.version);
        let v0 = 0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::get_minter_cap_id(arg2);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_minters, &v0), 2);
        0x2::coin::mint<FBTC>(&mut arg1.treasury, arg0, arg4)
    }

    public fun is_paused(arg0: &0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::AccessConfig) : bool {
        0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::is_paused(arg0)
    }

    public entry fun set_pause(arg0: bool, arg1: &mut 0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::AccessConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::assert_pause_admin(arg1, 0x2::tx_context::sender(arg2));
        0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::set_pause(arg1, arg0);
    }

    fun check_version(arg0: u8) {
        assert!(arg0 == 0, 1);
    }

    fun init(arg0: FBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FBTC>(arg0, 8, b"FBTC", b"FBTC", b"FBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaVrhFx87motWdaCJ7Nab4yU45u8AtcQRQ6ZyaAQNW1RC")), true, arg1);
        let v3 = TreasuryCapManager{
            id              : 0x2::object::new(arg1),
            version         : 0,
            treasury        : v0,
            revoked_minters : 0x1::vector::empty<0x2::object::ID>(),
            revoked_burners : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<TreasuryCapManager>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FBTC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FBTC>>(v2);
    }

    entry fun migrate(arg0: &mut TreasuryCapManager, arg1: &0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::AdminCap) {
        assert!(arg0.version < 0, 0);
        arg0.version = 0;
    }

    public entry fun revoke_burner_cap(arg0: 0x2::object::ID, arg1: &mut TreasuryCapManager, arg2: &mut 0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::AccessConfig, arg3: &0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::AdminCap) {
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_burners, &arg0), 3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.revoked_burners, arg0);
        0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::burner_cap_revoked(arg0, arg2);
    }

    public entry fun revoke_minter_cap(arg0: 0x2::object::ID, arg1: &mut TreasuryCapManager, arg2: &mut 0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::AccessConfig, arg3: &0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::AdminCap) {
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revoked_minters, &arg0), 3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.revoked_minters, arg0);
        0x8bb49770175de6bd20ba98b58f3e34efe2a9424b3b80d2cb6dff2edd1e23dbc7::access_control::minter_cap_revoked(arg0, arg2);
    }

    public fun revoked_burners(arg0: &TreasuryCapManager) : vector<0x2::object::ID> {
        arg0.revoked_burners
    }

    public fun revoked_minters(arg0: &TreasuryCapManager) : vector<0x2::object::ID> {
        arg0.revoked_minters
    }

    // decompiled from Move bytecode v6
}

