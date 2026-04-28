module 0xecc1e4904528453701abd873df637f8d2da3ab780dbcb33c36db005d7c920d89::factory {
    struct FactoryRegistry has key {
        id: 0x2::object::UID,
        tokens_launched: u64,
        symbols: 0x2::table::Table<vector<u8>, 0x1::type_name::TypeName>,
        sealed: bool,
    }

    struct OriginCap has key {
        id: 0x2::object::UID,
    }

    struct TokenLaunched has copy, drop {
        creator: address,
        coin_type: 0x1::type_name::TypeName,
        symbol: vector<u8>,
        name: vector<u8>,
        decimals: u8,
        total_supply: u64,
        fee_paid: u64,
        icon_byte_len: u64,
    }

    struct FactorySealed has copy, drop {
        caller: address,
    }

    public fun fee_for_symbol(arg0: vector<u8>) : u64 {
        fee_for_symbol_len(0x1::vector::length<u8>(&arg0))
    }

    fun fee_for_symbol_len(arg0: u64) : u64 {
        if (arg0 == 1) {
            100000000000
        } else if (arg0 == 2) {
            10000000000
        } else if (arg0 == 3) {
            1000000000
        } else if (arg0 == 4) {
            100000000
        } else {
            10000000
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FactoryRegistry{
            id              : 0x2::object::new(arg0),
            tokens_launched : 0,
            symbols         : 0x2::table::new<vector<u8>, 0x1::type_name::TypeName>(arg0),
            sealed          : false,
        };
        0x2::transfer::share_object<FactoryRegistry>(v0);
        let v1 = OriginCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OriginCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_sealed(arg0: &FactoryRegistry) : bool {
        arg0.sealed
    }

    public fun launch<T0>(arg0: &mut FactoryRegistry, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin_registry::MetadataCap<T0>, arg4: 0x2::package::UpgradeCap, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: 0x2::coin::Coin<0x898d83f0e128eb2024e435bc9da116d78f47c631e74096e505f5c86f8910b0d7::D::D>, arg9: &mut 0x898d83f0e128eb2024e435bc9da116d78f47c631e74096e505f5c86f8910b0d7::D::Registry, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.sealed, 1);
        assert!(0x2::coin_registry::decimals<T0>(arg1) == 9, 2);
        let v0 = 0x1::string::into_bytes(0x2::coin_registry::symbol<T0>(arg1));
        let v1 = 0x1::vector::length<u8>(&v0);
        assert!(v1 >= 1 && v1 <= 32, 3);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(&v0, v2);
            assert!(v3 >= 33 && v3 <= 126, 4);
            v2 = v2 + 1;
        };
        assert!(!0x2::table::contains<vector<u8>, 0x1::type_name::TypeName>(&arg0.symbols, v0), 5);
        let v4 = 0x1::vector::length<u8>(&arg5);
        assert!(v4 >= 1 && v4 <= 64, 6);
        let v5 = 0x1::vector::length<u8>(&arg6);
        assert!(v5 >= 1 && v5 <= 1000, 7);
        let v6 = 0x1::vector::length<u8>(&arg7);
        assert!(v6 >= 12 && v6 <= 65536, 8);
        let v7 = b"data:image/";
        let v8 = 0;
        while (v8 < 11) {
            assert!(*0x1::vector::borrow<u8>(&arg7, v8) == *0x1::vector::borrow<u8>(&v7, v8), 12);
            v8 = v8 + 1;
        };
        let v9 = 0x1::string::try_utf8(arg5);
        assert!(0x1::option::is_some<0x1::string::String>(&v9), 14);
        let v10 = 0x1::string::try_utf8(arg6);
        assert!(0x1::option::is_some<0x1::string::String>(&v10), 15);
        let v11 = 0x1::string::try_utf8(arg7);
        assert!(0x1::option::is_some<0x1::string::String>(&v11), 16);
        let v12 = fee_for_symbol_len(v1);
        assert!(0x2::coin::value<0x898d83f0e128eb2024e435bc9da116d78f47c631e74096e505f5c86f8910b0d7::D::D>(&arg8) == v12, 9);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 10);
        assert!(0x2::package::upgrade_package(&arg4) == 0x2::object::id_from_address(0x1::type_name::defining_id<T0>()), 13);
        0x2::package::make_immutable(arg4);
        0x898d83f0e128eb2024e435bc9da116d78f47c631e74096e505f5c86f8910b0d7::D::donate_to_sp(arg9, arg8, arg10);
        0x2::table::add<vector<u8>, 0x1::type_name::TypeName>(&mut arg0.symbols, v0, 0x1::type_name::with_defining_ids<T0>());
        arg0.tokens_launched = arg0.tokens_launched + 1;
        0x2::coin_registry::set_name<T0>(arg1, &arg3, 0x1::option::destroy_some<0x1::string::String>(v9));
        0x2::coin_registry::set_description<T0>(arg1, &arg3, 0x1::option::destroy_some<0x1::string::String>(v10));
        0x2::coin_registry::set_icon_url<T0>(arg1, &arg3, 0x1::option::destroy_some<0x1::string::String>(v11));
        0x2::coin_registry::delete_metadata_cap<T0>(arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg2, 1000000000000000000, arg10), 0x2::tx_context::sender(arg10));
        0x2::coin_registry::make_supply_burn_only<T0>(arg1, arg2);
        let v13 = TokenLaunched{
            creator       : 0x2::tx_context::sender(arg10),
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            symbol        : v0,
            name          : arg5,
            decimals      : 9,
            total_supply  : 1000000000000000000,
            fee_paid      : v12,
            icon_byte_len : v6,
        };
        0x2::event::emit<TokenLaunched>(v13);
    }

    public fun read_warning() : vector<u8> {
        b"DARBITEX SUI TOKEN FACTORY is an immutable, permissionless 1B-fixed-supply coin minter on Sui mainnet. After this package is sealed via package::make_immutable, no upgrade path exists; bugs are real. Audit this code yourself before launching a token. KNOWN PROPERTIES: (1) Every successful launch atomically locks four dimensions of the resulting coin in one transaction: SUPPLY (TreasuryCap consumed via make_supply_burn_only - 1_000_000_000 * 10^9 units forever, BurnOnly state, mint impossible), METADATA (MetadataCap consumed via delete_metadata_cap - name, description, icon_url permanently immutable), CALLER'S OTW PACKAGE (UpgradeCap consumed via package::make_immutable - caller's published OTW package becomes cryptographically immutable in the same tx), and FACTORY NAMESPACE (symbol bytes registered in this factory's symbol Table, no removal path). Symbol and decimals are additionally locked since the OTW init transaction (no setter exists in coin_registry framework). The caller's UpgradeCap is required to control the same package that defines T (verified via package::upgrade_package == type_name::defining_id<T>); this means the caller MUST NOT have upgraded their OTW package between OTW init publish and factory::launch, since UpgradeCap.package after upgrade no longer matches T's defining package. Standard frontend wizard flow publishes OTW + immediately launches in the same wallet session; intermediate upgrades cause E_UPGRADE_CAP_MISMATCH abort. (2) Symbol uniqueness is enforced within this factory's namespace only. The same byte-symbol may exist in raw new_currency_with_otw publishes outside this factory or in other Sui factories. Frontend wizards should pre-check symbol_taken before user spends Tx1 gas. (3) Tier fee in D (Darbitex stablecoin, mainnet pkg 0x898d83f0e128eb2024e435bc9da116d78f47c631e74096e505f5c86f8910b0d7, sealed immutable, 8 decimals): 1-char symbol = 1000 D, 2 = 100 D, 3 = 10 D, 4 = 1 D, 5+ = 0.1 D. Exact match enforced; underpay and overpay both abort. The entire fee Coin<D> is routed through D::donate_to_sp as an agnostic Stability Pool donation. The fee joins D Registry sp_pool balance but does NOT increment D's total_sp counter, so it does not dilute SP-keyed depositor rewards. The fee is permanently locked in D's SP and gradually burns via future D liquidations as part of the absorbed-debt math. No admin path can extract the fee from D's SP. Factory holds zero Coin<D> balance at any point; pure pass-through. (4) Icon URL must start with the byte prefix data:image/ (RFC 2397 data URI scheme). HTTPS, IPFS, Arweave, and other off-chain URIs are rejected. This guarantees every launched token has a permanent on-chain icon that cannot rot via off-chain hosting failure or pin expiry. SECURITY NOTE: data:image/svg+xml URIs are accepted under this prefix; SVG documents can embed <script> elements that may execute in wallets which inline-render token icons rather than opaque-rasterize them. Wallets choosing to inline-render SVG icons accept this attack surface. End-users and wallet implementations should treat SVG token icons as untrusted user content. (5) No deny-list, no freeze authority, no revoke authority. Factory does not call coin_registry::make_regulated, so DenyCapV2<T> is never created for any launched token. Launched coins cannot be frozen or denylisted by any party. (6) Decimals are locked at 9 (Sui native standard). Tokens with any other decimal value are rejected at launch entry. (7) Symbol byte range is 0x21 to 0x7E inclusive (printable ASCII excluding space). Multi-byte UTF-8 symbols are rejected by Sui framework's is_ascii_printable check at OTW init plus factory's stricter byte loop. Symbol comparison is case-sensitive: PEPE and pepe are distinct keys. (8) Pre-mint guard: caller's TreasuryCap must report total_supply == 0 at launch entry. Combined with TreasuryCap consumption via make_supply_burn_only inside launch, this guarantees exactly 1_000_000_000 * 10^9 units exist post-launch, all transferred to the caller. (9) Self-burn is permissionless: any holder of Coin<T> can call coin_registry::burn(currency, coin) directly against the shared Currency<T> object. Supply state is BurnOnly forever; supply can only decrease, never increase. (10) Once this factory is sealed via factory::seal (consuming OriginCap + factory's own UpgradeCap atomically; the UpgradeCap must control THIS factory package, verified via E_BAD_UPGRADE_CAP), no new tokens can be launched, but every previously-launched token remains fully functional. Tokens are fully decoupled from factory state at runtime; factory sealing does not affect them. (11) Launched tokens depend ONLY on Sui framework primitives sui::coin and sui::coin_registry for transfer, balance, and burn operations. They have zero runtime dependency on factory state or D state post-launch. Token operational availability is decoupled from both factory and D. (12) Factory itself uses no oracle. The launched token is a pure transferable bearer asset with no oracle dependency. D's internal Pyth oracle dependency (used by D's CDP path, NOT by donate_to_sp) does not affect factory's launch path; donate_to_sp is oracle-free. (13) Validation order in launch: all read-only checks (sealed flag, decimals, symbol bytes + uniqueness, name/desc/icon length + prefix + UTF-8 well-formedness, fee exact match, pre-mint supply == 0, UpgradeCap-package-binding) execute BEFORE any state mutation. State mutations follow strictly in order: package::make_immutable on caller's UpgradeCap, D::donate_to_sp on fee, symbol Table.add, metadata writes via MetadataCap, MetadataCap deletion, supply mint to caller, make_supply_burn_only consuming TreasuryCap. Sui transaction atomicity guarantees full rollback of all mutations and events on any abort, so no partial-commit window exists; failed launches preserve all caller assets including the fee, the UpgradeCap, the TreasuryCap, and the MetadataCap."
    }

    public fun seal(arg0: OriginCap, arg1: &mut FactoryRegistry, arg2: 0x2::package::UpgradeCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.sealed, 11);
        assert!(0x2::package::upgrade_package(&arg2) == 0x2::object::id_from_address(0x1::type_name::defining_id<OriginCap>()), 17);
        let OriginCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::package::make_immutable(arg2);
        arg1.sealed = true;
        let v1 = FactorySealed{caller: 0x2::tx_context::sender(arg3)};
        0x2::event::emit<FactorySealed>(v1);
    }

    public fun symbol_owner(arg0: &FactoryRegistry, arg1: vector<u8>) : 0x1::option::Option<0x1::type_name::TypeName> {
        if (0x2::table::contains<vector<u8>, 0x1::type_name::TypeName>(&arg0.symbols, arg1)) {
            0x1::option::some<0x1::type_name::TypeName>(*0x2::table::borrow<vector<u8>, 0x1::type_name::TypeName>(&arg0.symbols, arg1))
        } else {
            0x1::option::none<0x1::type_name::TypeName>()
        }
    }

    public fun symbol_taken(arg0: &FactoryRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, 0x1::type_name::TypeName>(&arg0.symbols, arg1)
    }

    public fun tokens_launched(arg0: &FactoryRegistry) : u64 {
        arg0.tokens_launched
    }

    // decompiled from Move bytecode v7
}

