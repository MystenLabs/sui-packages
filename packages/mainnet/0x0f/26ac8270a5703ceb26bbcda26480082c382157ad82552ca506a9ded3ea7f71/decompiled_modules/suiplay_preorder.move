module 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_preorder {
    struct Tier has copy, drop, store {
        key: u8,
        name: 0x1::string::String,
        max_supply: u64,
    }

    struct SuiPlayPreorderRegistry has key {
        id: 0x2::object::UID,
        current_tier: Tier,
        mythics_minted: u64,
        exalted_minted: u64,
        version: u64,
    }

    struct SuiPlayMintCap has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct MintAuthorizedCaps has copy, drop, store {
        dummy_field: bool,
    }

    struct SUIPLAY_PREORDER has drop {
        dummy_field: bool,
    }

    public fun add_authorized_minter(arg0: &0x2::package::Publisher, arg1: &mut SuiPlayPreorderRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<SuiPlayMintCap>(arg0), 0);
        let v0 = MintAuthorizedCaps{dummy_field: false};
        0x2::dynamic_field::add<MintAuthorizedCaps, address>(&mut arg1.id, v0, arg2);
    }

    public fun bump_mint_version(arg0: &mut SuiPlayPreorderRegistry, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<SuiPlayPreorderRegistry>(arg1), 0);
        arg0.version = arg0.version + 1;
    }

    public(friend) fun bump_tier(arg0: &mut SuiPlayPreorderRegistry) {
        let v0 = Tier{
            key        : 2,
            name       : 0x1::string::utf8(0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_constants::tier_exalted_name()),
            max_supply : 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_constants::max_exalted_units(),
        };
        arg0.current_tier = v0;
    }

    public fun burn_mintcap(arg0: SuiPlayMintCap) {
        let SuiPlayMintCap {
            id      : v0,
            version : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun can_mint(arg0: &SuiPlayPreorderRegistry) : bool {
        let v0 = arg0.current_tier.key;
        let v1 = &v0;
        let v2 = 1;
        if (v1 == &v2) {
            arg0.mythics_minted < arg0.current_tier.max_supply
        } else {
            let v4 = 2;
            v1 == &v4 && arg0.exalted_minted < arg0.current_tier.max_supply
        }
    }

    public fun config_version(arg0: &SuiPlayPreorderRegistry) : u64 {
        arg0.version
    }

    public fun current_tier_key(arg0: &SuiPlayPreorderRegistry) : u8 {
        arg0.current_tier.key
    }

    public fun current_tier_max_supply(arg0: &SuiPlayPreorderRegistry) : u64 {
        arg0.current_tier.max_supply
    }

    public fun current_tier_name(arg0: &SuiPlayPreorderRegistry) : 0x1::string::String {
        arg0.current_tier.name
    }

    public fun exalted_minted(arg0: &SuiPlayPreorderRegistry) : u64 {
        arg0.exalted_minted
    }

    fun init(arg0: SUIPLAY_PREORDER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SUIPLAY_PREORDER>(arg0, arg1);
        let v0 = Tier{
            key        : 1,
            name       : 0x1::string::utf8(b"The Mythics"),
            max_supply : 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_constants::max_mythics_units(),
        };
        let v1 = SuiPlayPreorderRegistry{
            id             : 0x2::object::new(arg1),
            current_tier   : v0,
            mythics_minted : 0,
            exalted_minted : 0,
            version        : 1,
        };
        0x2::transfer::share_object<SuiPlayPreorderRegistry>(v1);
    }

    public fun is_authorized_minter(arg0: &SuiPlayPreorderRegistry, arg1: address) : bool {
        let v0 = MintAuthorizedCaps{dummy_field: false};
        0x2::dynamic_field::borrow<MintAuthorizedCaps, address>(&arg0.id, v0) == &arg1
    }

    public fun mintcap_version(arg0: &SuiPlayMintCap) : u64 {
        arg0.version
    }

    public fun mythics_minted(arg0: &SuiPlayPreorderRegistry) : u64 {
        arg0.mythics_minted
    }

    public fun new_mintcap(arg0: &0x2::package::Publisher, arg1: &SuiPlayPreorderRegistry, arg2: &mut 0x2::tx_context::TxContext) : SuiPlayMintCap {
        assert!(0x2::package::from_package<SuiPlayMintCap>(arg0), 0);
        SuiPlayMintCap{
            id      : 0x2::object::new(arg2),
            version : arg1.version,
        }
    }

    public fun reset_authorized_sender(arg0: &0x2::package::Publisher, arg1: &mut SuiPlayPreorderRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<SuiPlayMintCap>(arg0), 0);
        let v0 = MintAuthorizedCaps{dummy_field: false};
        0x2::dynamic_field::remove<MintAuthorizedCaps, address>(&mut arg1.id, v0);
    }

    public(friend) fun sync_minted_counters(arg0: &mut SuiPlayPreorderRegistry) {
        arg0.mythics_minted = arg0.mythics_minted + 1;
        arg0.exalted_minted = arg0.exalted_minted - 1;
    }

    public fun total_mints(arg0: &SuiPlayPreorderRegistry) : u64 {
        arg0.mythics_minted + arg0.exalted_minted
    }

    public(friend) fun update_minted(arg0: &mut SuiPlayPreorderRegistry) {
        let v0 = arg0.current_tier.key;
        let v1 = &v0;
        let v2 = 1;
        if (v1 == &v2) {
            arg0.mythics_minted = arg0.mythics_minted + 1;
        } else {
            let v3 = 2;
            if (v1 == &v3) {
                arg0.exalted_minted = arg0.exalted_minted + 1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

