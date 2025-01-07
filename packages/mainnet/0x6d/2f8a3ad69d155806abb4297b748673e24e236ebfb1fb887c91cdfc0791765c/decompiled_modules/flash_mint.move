module 0x6d2f8a3ad69d155806abb4297b748673e24e236ebfb1fb887c91cdfc0791765c::flash_mint {
    struct WhitelistCap has key {
        id: 0x2::object::UID,
        minted_amount: u64,
    }

    struct WhitelistCapCreatedEvent has copy, drop {
        whitelist_address: address,
    }

    struct FlashMintEvent has copy, drop {
        whitelist_address: address,
        mint_amount: u64,
    }

    struct FlashBurnEvent has copy, drop {
        whitelist_address: address,
        burn_amount: u64,
    }

    struct WhitelistCapTransferredEvent has copy, drop {
        from: address,
        to: address,
    }

    public fun flash_mint(arg0: &mut WhitelistCap, arg1: &mut 0x6d2f8a3ad69d155806abb4297b748673e24e236ebfb1fb887c91cdfc0791765c::jwlsui::JwlSuiMetadata<0x6d2f8a3ad69d155806abb4297b748673e24e236ebfb1fb887c91cdfc0791765c::jwlsui::JWLSUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6d2f8a3ad69d155806abb4297b748673e24e236ebfb1fb887c91cdfc0791765c::jwlsui::JWLSUI> {
        arg0.minted_amount = arg0.minted_amount + arg2;
        let v0 = 0x2::object::id<WhitelistCap>(arg0);
        let v1 = FlashMintEvent{
            whitelist_address : 0x2::object::id_to_address(&v0),
            mint_amount       : arg2,
        };
        0x2::event::emit<FlashMintEvent>(v1);
        0x6d2f8a3ad69d155806abb4297b748673e24e236ebfb1fb887c91cdfc0791765c::jwlsui::mint(arg1, arg2, arg3)
    }

    public(friend) fun create(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WhitelistCap{
            id            : 0x2::object::new(arg1),
            minted_amount : 0,
        };
        0x2::transfer::transfer<WhitelistCap>(v0, arg0);
        let v1 = WhitelistCapCreatedEvent{whitelist_address: arg0};
        0x2::event::emit<WhitelistCapCreatedEvent>(v1);
    }

    public fun flash_burn(arg0: &mut WhitelistCap, arg1: &mut 0x6d2f8a3ad69d155806abb4297b748673e24e236ebfb1fb887c91cdfc0791765c::jwlsui::JwlSuiMetadata<0x6d2f8a3ad69d155806abb4297b748673e24e236ebfb1fb887c91cdfc0791765c::jwlsui::JWLSUI>, arg2: 0x2::coin::Coin<0x6d2f8a3ad69d155806abb4297b748673e24e236ebfb1fb887c91cdfc0791765c::jwlsui::JWLSUI>) {
        let v0 = 0x2::coin::value<0x6d2f8a3ad69d155806abb4297b748673e24e236ebfb1fb887c91cdfc0791765c::jwlsui::JWLSUI>(&arg2);
        assert!(arg0.minted_amount >= v0, 300);
        arg0.minted_amount = arg0.minted_amount - v0;
        0x6d2f8a3ad69d155806abb4297b748673e24e236ebfb1fb887c91cdfc0791765c::jwlsui::burn_coin(arg1, arg2);
        let v1 = 0x2::object::id<WhitelistCap>(arg0);
        let v2 = FlashBurnEvent{
            whitelist_address : 0x2::object::id_to_address(&v1),
            burn_amount       : v0,
        };
        0x2::event::emit<FlashBurnEvent>(v2);
    }

    public entry fun transfer_whitelist(arg0: WhitelistCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<WhitelistCap>(arg0, arg1);
        let v0 = WhitelistCapTransferredEvent{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<WhitelistCapTransferredEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

