module 0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::fbtc {
    struct FBTC has drop {
        dummy_field: bool,
    }

    struct MinterCap has key {
        id: 0x2::object::UID,
        version: u8,
        treasury: 0x2::coin::TreasuryCap<FBTC>,
    }

    public fun burn(arg0: &mut 0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::access_control::AccessConfig, arg1: &mut MinterCap, arg2: 0x2::coin::Coin<FBTC>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::access_control::assert_not_paused(arg0);
        check_version(arg1.version);
        0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::access_control::assert_burner(arg0, 0x2::tx_context::sender(arg3));
        0x2::coin::burn<FBTC>(&mut arg1.treasury, arg2)
    }

    public fun mint(arg0: &mut 0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::access_control::AccessConfig, arg1: &mut MinterCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FBTC> {
        0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::access_control::assert_not_paused(arg0);
        check_version(arg1.version);
        0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::access_control::assert_minter(arg0, 0x2::tx_context::sender(arg3));
        0x2::coin::mint<FBTC>(&mut arg1.treasury, arg2, arg3)
    }

    public fun is_paused(arg0: &0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::access_control::AccessConfig) : bool {
        0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::access_control::is_paused(arg0)
    }

    public entry fun set_pause(arg0: &mut 0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::access_control::AccessConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::access_control::assert_pause_admin(arg0, 0x2::tx_context::sender(arg2));
        0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::access_control::set_pause(arg0, arg1);
    }

    fun check_version(arg0: u8) {
        assert!(arg0 == 0, 1);
    }

    fun init(arg0: FBTC, arg1: &mut 0x2::tx_context::TxContext) {
        0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::access_control::initialize(arg1);
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FBTC>(arg0, 8, b"FBTC", b"FBTC", b"FBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaVrhFx87motWdaCJ7Nab4yU45u8AtcQRQ6ZyaAQNW1RC")), true, arg1);
        let v3 = MinterCap{
            id       : 0x2::object::new(arg1),
            version  : 0,
            treasury : v0,
        };
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::transfer::share_object<MinterCap>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FBTC>>(v1, v4);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FBTC>>(v2, v4);
    }

    entry fun migrate(arg0: &mut MinterCap, arg1: &0x63d5e93de9184874eb647b4ddfcf6d5bd4fd9bead5545964ca93f70b5db19be9::access_control::AdminCap) {
        assert!(arg0.version < 0, 0);
        arg0.version = 0;
    }

    // decompiled from Move bytecode v6
}

