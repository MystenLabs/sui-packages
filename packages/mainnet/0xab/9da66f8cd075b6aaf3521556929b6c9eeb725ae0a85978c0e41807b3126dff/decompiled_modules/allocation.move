module 0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::allocation {
    struct UPAirdropNFT has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct UpClaimer has store, key {
        id: 0x2::object::UID,
        up_pool: 0x2::balance::Balance<0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::UP>,
        claims_enabled: bool,
    }

    struct ALLOCATION has drop {
        dummy_field: bool,
    }

    public fun claim_allocation(arg0: &mut UpClaimer, arg1: UPAirdropNFT, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::UP> {
        if (!arg0.claims_enabled) {
            err_claims_disabled();
        };
        let UPAirdropNFT {
            id     : v0,
            amount : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::coin::from_balance<0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::UP>(0x2::balance::split<0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::UP>(&mut arg0.up_pool, v1), arg2)
    }

    public fun create_and_transfer_allocation_nft(arg0: &mut 0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::UpAdmin, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::is_manager(arg0, 0x2::tx_context::sender(arg3)), 0);
        let v0 = UPAirdropNFT{
            id     : 0x2::object::new(arg3),
            amount : arg1,
        };
        0x2::transfer::public_transfer<UPAirdropNFT>(v0, arg2);
    }

    public fun enable_claims(arg0: &mut 0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::UpAdmin, arg1: &mut UpClaimer, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::is_manager(arg0, 0x2::tx_context::sender(arg2)), 0);
        arg1.claims_enabled = true;
    }

    fun err_claims_disabled() : u64 {
        1
    }

    fun init(arg0: ALLOCATION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ALLOCATION>(arg0, arg1);
        let v1 = 0x2::display::new<UPAirdropNFT>(&v0, arg1);
        0x2::display::add<UPAirdropNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"UP Airdrop Allocation NFT"));
        0x2::display::add<UPAirdropNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://svgenerator.doubleupdata.store/convert?amount={amount}&denom=ONLYUP"));
        0x2::display::add<UPAirdropNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"An NFT representing an allocation of UP tokens."));
        0x2::display::update_version<UPAirdropNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<UPAirdropNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v2 = UpClaimer{
            id             : 0x2::object::new(arg1),
            up_pool        : 0x2::balance::zero<0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::UP>(),
            claims_enabled : false,
        };
        0x2::transfer::public_share_object<UpClaimer>(v2);
    }

    public fun seed_allocations(arg0: &mut 0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::UpAdmin, arg1: &mut UpClaimer, arg2: 0x2::coin::Coin<0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::UP>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::is_manager(arg0, 0x2::tx_context::sender(arg3)), 0);
        0x2::balance::join<0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::UP>(&mut arg1.up_pool, 0x2::coin::into_balance<0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up::UP>(arg2));
    }

    // decompiled from Move bytecode v6
}

