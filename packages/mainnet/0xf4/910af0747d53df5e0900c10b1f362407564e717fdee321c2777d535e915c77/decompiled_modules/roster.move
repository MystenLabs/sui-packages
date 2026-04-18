module 0x2c1d63b3b314f9b6e96c33e9a3bca4faaa79a69a5729e5d2e8ac09d70e1052fa::roster {
    struct IdentitySet has copy, drop {
        name: 0x1::string::String,
        sui_address: address,
        chain_count: u64,
        dwallet_count: u64,
    }

    struct Roster has key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct IdentityRecord has copy, drop, store {
        name: 0x1::string::String,
        sui_address: address,
        chains: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        dwallet_caps: vector<address>,
        updated_ms: u64,
        walrus_blob_id: 0x1::string::String,
        seal_nonce: vector<u8>,
        verified: bool,
    }

    struct EnsHashKey has copy, drop, store {
        hash: vector<u8>,
    }

    struct CfHistoryKey has copy, drop, store {
        addr: address,
    }

    struct CfHistory has drop, store {
        blobs: vector<0x1::string::String>,
        updated_ms: u64,
    }

    struct PublicChainsKey has copy, drop, store {
        addr: address,
    }

    struct PublicChains has drop, store {
        visible: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        updated_ms: u64,
    }

    struct PublicChainsSet has copy, drop {
        sui_address: address,
        chain_count: u64,
    }

    struct PublicChainsCleared has copy, drop {
        sui_address: address,
    }

    struct GuestKey has copy, drop, store {
        parent_hash: vector<u8>,
        label: vector<u8>,
    }

    struct Guest has drop, store {
        parent_sui_address: address,
        target: 0x1::string::String,
        chain: 0x1::string::String,
        expires_ms: u64,
        delegate: 0x1::option::Option<address>,
    }

    struct GuestBound has copy, drop {
        parent_hash: vector<u8>,
        label: vector<u8>,
        target: 0x1::string::String,
        chain: 0x1::string::String,
        expires_ms: u64,
        has_delegate: bool,
    }

    struct GuestRevoked has copy, drop {
        parent_hash: vector<u8>,
        label: vector<u8>,
        revoker: address,
    }

    struct GuestReaped has copy, drop {
        parent_hash: vector<u8>,
        label: vector<u8>,
        reaper: address,
    }

    struct GuestStealthKey has copy, drop, store {
        parent_hash: vector<u8>,
        label: vector<u8>,
    }

    struct GuestStealth has drop, store {
        parent_sui_address: address,
        hot_addr: 0x1::string::String,
        chain: 0x1::string::String,
        sealed_cold_dest: vector<u8>,
        expires_ms: u64,
        sweep_delegate: address,
    }

    struct GuestStealthBound has copy, drop {
        parent_hash: vector<u8>,
        label: vector<u8>,
        hot_addr: 0x1::string::String,
        chain: 0x1::string::String,
        expires_ms: u64,
        sweep_delegate: address,
    }

    struct GuestStealthRevoked has copy, drop {
        parent_hash: vector<u8>,
        label: vector<u8>,
        revoker: address,
    }

    struct GuestStealthReaped has copy, drop {
        parent_hash: vector<u8>,
        label: vector<u8>,
        reaper: address,
    }

    struct StealthMetaKey has copy, drop, store {
        addr: address,
    }

    struct StealthMeta has drop, store {
        ika_dwallet_id: 0x2::object::ID,
        view_pubkeys: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
        updated_ms: u64,
    }

    struct StealthMetaSet has copy, drop {
        addr: address,
        ika_dwallet_id: 0x2::object::ID,
        chains: vector<0x1::string::String>,
        updated_ms: u64,
    }

    struct StealthMetaCleared has copy, drop {
        addr: address,
    }

    public fun append_cf_history(arg0: &mut Roster, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 0);
        let v1 = CfHistoryKey{addr: v0};
        if (0x2::dynamic_field::exists_<CfHistoryKey>(&arg0.id, v1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<CfHistoryKey, CfHistory>(&mut arg0.id, v1);
            0x1::vector::push_back<0x1::string::String>(&mut v2.blobs, arg1);
            v2.updated_ms = 0x2::clock::timestamp_ms(arg2);
        } else {
            let v3 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v3, arg1);
            let v4 = CfHistory{
                blobs      : v3,
                updated_ms : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::dynamic_field::add<CfHistoryKey, CfHistory>(&mut arg0.id, v1, v4);
        };
    }

    fun assert_parent_owner(arg0: &Roster, arg1: vector<u8>, arg2: address) : address {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            let v0 = 0x2::dynamic_field::borrow<vector<u8>, IdentityRecord>(&arg0.id, arg1);
            assert!(v0.sui_address == arg2, 0);
            return v0.sui_address
        };
        let v1 = EnsHashKey{hash: arg1};
        assert!(0x2::dynamic_field::exists_<EnsHashKey>(&arg0.id, v1), 9);
        let v2 = 0x2::dynamic_field::borrow<EnsHashKey, IdentityRecord>(&arg0.id, v1);
        assert!(v2.sui_address == arg2, 0);
        v2.sui_address
    }

    entry fun bind_guest(arg0: &mut Roster, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(arg5 > 0 && arg5 <= 15552000000, 12);
        let v0 = 0x2::clock::timestamp_ms(arg7) + arg5;
        let v1 = GuestKey{
            parent_hash : arg1,
            label       : arg2,
        };
        if (0x2::dynamic_field::exists_<GuestKey>(&arg0.id, v1)) {
            0x2::dynamic_field::remove<GuestKey, Guest>(&mut arg0.id, v1);
        };
        let v2 = Guest{
            parent_sui_address : assert_parent_owner(arg0, arg1, 0x2::tx_context::sender(arg8)),
            target             : arg3,
            chain              : arg4,
            expires_ms         : v0,
            delegate           : arg6,
        };
        0x2::dynamic_field::add<GuestKey, Guest>(&mut arg0.id, v1, v2);
        let v3 = GuestBound{
            parent_hash  : arg1,
            label        : arg2,
            target       : arg3,
            chain        : arg4,
            expires_ms   : v0,
            has_delegate : 0x1::option::is_some<address>(&arg6),
        };
        0x2::event::emit<GuestBound>(v3);
    }

    entry fun bind_guest_stealth(arg0: &mut Roster, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let v0 = GuestStealthKey{
            parent_hash : arg1,
            label       : arg2,
        };
        if (0x2::dynamic_field::exists_<GuestStealthKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<GuestStealthKey, GuestStealth>(&mut arg0.id, v0);
        };
        let v1 = 0x2::clock::timestamp_ms(arg8) + arg6;
        let v2 = GuestStealth{
            parent_sui_address : assert_parent_owner(arg0, arg1, 0x2::tx_context::sender(arg9)),
            hot_addr           : arg3,
            chain              : arg4,
            sealed_cold_dest   : arg5,
            expires_ms         : v1,
            sweep_delegate     : arg7,
        };
        0x2::dynamic_field::add<GuestStealthKey, GuestStealth>(&mut arg0.id, v0, v2);
        let v3 = 0x2::dynamic_field::borrow<GuestStealthKey, GuestStealth>(&arg0.id, v0);
        let v4 = GuestStealthBound{
            parent_hash    : arg1,
            label          : arg2,
            hot_addr       : v3.hot_addr,
            chain          : v3.chain,
            expires_ms     : v1,
            sweep_delegate : arg7,
        };
        0x2::event::emit<GuestStealthBound>(v4);
    }

    fun build_bind_inner_message(arg0: &0x1::string::String, arg1: address, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"SUIAMI bind ");
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, b" owner ");
        let v1 = 0x2::address::to_string(arg1);
        0x1::vector::append<u8>(&mut v0, b"0x");
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v1));
        0x1::vector::append<u8>(&mut v0, b" at ");
        0x1::vector::append<u8>(&mut v0, u64_to_ascii_decimal(arg2));
        v0
    }

    public fun cf_history(arg0: &Roster, arg1: address) : &vector<0x1::string::String> {
        let v0 = CfHistoryKey{addr: arg1};
        &0x2::dynamic_field::borrow<CfHistoryKey, CfHistory>(&arg0.id, v0).blobs
    }

    public fun cf_history_updated_ms(arg0: &Roster, arg1: address) : u64 {
        let v0 = CfHistoryKey{addr: arg1};
        0x2::dynamic_field::borrow<CfHistoryKey, CfHistory>(&arg0.id, v0).updated_ms
    }

    entry fun clear_public_chains(arg0: &mut Roster, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = PublicChainsKey{addr: v0};
        if (0x2::dynamic_field::exists_<PublicChainsKey>(&arg0.id, v1)) {
            0x2::dynamic_field::remove<PublicChainsKey, PublicChains>(&mut arg0.id, v1);
            let v2 = PublicChainsCleared{sui_address: v0};
            0x2::event::emit<PublicChainsCleared>(v2);
        };
    }

    entry fun clear_stealth_meta(arg0: &mut Roster, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = StealthMetaKey{addr: v0};
        if (0x2::dynamic_field::exists_<StealthMetaKey>(&arg0.id, v1)) {
            0x2::dynamic_field::remove<StealthMetaKey, StealthMeta>(&mut arg0.id, v1);
            let v2 = StealthMetaCleared{addr: v0};
            0x2::event::emit<StealthMetaCleared>(v2);
        };
    }

    public fun count(arg0: &Roster) : u64 {
        arg0.count
    }

    fun eip191_wrap(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, x"19457468657265756d205369676e6564204d6573736167653a0a");
        0x1::vector::append<u8>(&mut v0, u64_to_ascii_decimal((0x1::vector::length<u8>(arg0) as u64)));
        0x1::vector::append<u8>(&mut v0, *arg0);
        v0
    }

    fun eth_hex_string_to_bytes(arg0: &0x1::string::String) : vector<u8> {
        let v0 = *0x1::string::as_bytes(arg0);
        let v1 = if (0x1::vector::length<u8>(&v0) >= 2) {
            if (*0x1::vector::borrow<u8>(&v0, 0) == 48) {
                *0x1::vector::borrow<u8>(&v0, 1) == 120 || *0x1::vector::borrow<u8>(&v0, 1) == 88
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            let v2 = 0x1::vector::empty<u8>();
            let v3 = 2;
            while (v3 < 0x1::vector::length<u8>(&v0)) {
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, v3));
                v3 = v3 + 1;
            };
            v0 = v2;
        };
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&v0)) {
            let v6 = *0x1::vector::borrow<u8>(&v0, v5);
            let v7 = if (v6 >= 65 && v6 <= 70) {
                v6 + 32
            } else {
                v6
            };
            0x1::vector::push_back<u8>(&mut v4, v7);
            v5 = v5 + 1;
        };
        0x2::hex::decode(v4)
    }

    public fun guest_chain(arg0: &Roster, arg1: vector<u8>, arg2: vector<u8>) : 0x1::string::String {
        let v0 = GuestKey{
            parent_hash : arg1,
            label       : arg2,
        };
        0x2::dynamic_field::borrow<GuestKey, Guest>(&arg0.id, v0).chain
    }

    public fun guest_expires_ms(arg0: &Roster, arg1: vector<u8>, arg2: vector<u8>) : u64 {
        let v0 = GuestKey{
            parent_hash : arg1,
            label       : arg2,
        };
        0x2::dynamic_field::borrow<GuestKey, Guest>(&arg0.id, v0).expires_ms
    }

    public fun guest_stealth_chain(arg0: &Roster, arg1: vector<u8>, arg2: vector<u8>) : 0x1::string::String {
        let v0 = GuestStealthKey{
            parent_hash : arg1,
            label       : arg2,
        };
        assert!(0x2::dynamic_field::exists_<GuestStealthKey>(&arg0.id, v0), 10);
        0x2::dynamic_field::borrow<GuestStealthKey, GuestStealth>(&arg0.id, v0).chain
    }

    public fun guest_stealth_expires_ms(arg0: &Roster, arg1: vector<u8>, arg2: vector<u8>) : u64 {
        let v0 = GuestStealthKey{
            parent_hash : arg1,
            label       : arg2,
        };
        assert!(0x2::dynamic_field::exists_<GuestStealthKey>(&arg0.id, v0), 10);
        0x2::dynamic_field::borrow<GuestStealthKey, GuestStealth>(&arg0.id, v0).expires_ms
    }

    public fun guest_stealth_hot_addr(arg0: &Roster, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock) : 0x1::string::String {
        let v0 = GuestStealthKey{
            parent_hash : arg1,
            label       : arg2,
        };
        assert!(0x2::dynamic_field::exists_<GuestStealthKey>(&arg0.id, v0), 10);
        let v1 = 0x2::dynamic_field::borrow<GuestStealthKey, GuestStealth>(&arg0.id, v0);
        assert!(0x2::clock::timestamp_ms(arg3) < v1.expires_ms, 10);
        v1.hot_addr
    }

    public fun guest_stealth_sweep_delegate(arg0: &Roster, arg1: vector<u8>, arg2: vector<u8>) : address {
        let v0 = GuestStealthKey{
            parent_hash : arg1,
            label       : arg2,
        };
        assert!(0x2::dynamic_field::exists_<GuestStealthKey>(&arg0.id, v0), 10);
        0x2::dynamic_field::borrow<GuestStealthKey, GuestStealth>(&arg0.id, v0).sweep_delegate
    }

    public fun has_address(arg0: &Roster, arg1: address) : bool {
        0x2::dynamic_field::exists_<address>(&arg0.id, arg1)
    }

    public fun has_cf_history(arg0: &Roster, arg1: address) : bool {
        let v0 = CfHistoryKey{addr: arg1};
        0x2::dynamic_field::exists_<CfHistoryKey>(&arg0.id, v0)
    }

    public fun has_chain(arg0: &Roster, arg1: 0x1::string::String) : bool {
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg1)
    }

    public fun has_ens_name(arg0: &Roster, arg1: vector<u8>) : bool {
        let v0 = EnsHashKey{hash: arg1};
        0x2::dynamic_field::exists_<EnsHashKey>(&arg0.id, v0)
    }

    public fun has_guest(arg0: &Roster, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = GuestKey{
            parent_hash : arg1,
            label       : arg2,
        };
        0x2::dynamic_field::exists_<GuestKey>(&arg0.id, v0)
    }

    public fun has_guest_stealth(arg0: &Roster, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = GuestStealthKey{
            parent_hash : arg1,
            label       : arg2,
        };
        0x2::dynamic_field::exists_<GuestStealthKey>(&arg0.id, v0)
    }

    public fun has_name(arg0: &Roster, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)
    }

    public fun has_public_chains(arg0: &Roster, arg1: address) : bool {
        let v0 = PublicChainsKey{addr: arg1};
        0x2::dynamic_field::exists_<PublicChainsKey>(&arg0.id, v0)
    }

    public fun has_stealth_meta(arg0: &Roster, arg1: address) : bool {
        let v0 = StealthMetaKey{addr: arg1};
        0x2::dynamic_field::exists_<StealthMetaKey>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Roster{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::share_object<Roster>(v0);
    }

    public fun lookup_by_address(arg0: &Roster, arg1: address) : &IdentityRecord {
        0x2::dynamic_field::borrow<address, IdentityRecord>(&arg0.id, arg1)
    }

    public fun lookup_by_chain(arg0: &Roster, arg1: 0x1::string::String) : &IdentityRecord {
        0x2::dynamic_field::borrow<0x1::string::String, IdentityRecord>(&arg0.id, arg1)
    }

    public fun lookup_by_ens(arg0: &Roster, arg1: vector<u8>) : &IdentityRecord {
        let v0 = EnsHashKey{hash: arg1};
        0x2::dynamic_field::borrow<EnsHashKey, IdentityRecord>(&arg0.id, v0)
    }

    public fun lookup_by_name(arg0: &Roster, arg1: vector<u8>) : &IdentityRecord {
        0x2::dynamic_field::borrow<vector<u8>, IdentityRecord>(&arg0.id, arg1)
    }

    public fun lookup_guest_target(arg0: &Roster, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock) : 0x1::option::Option<0x1::string::String> {
        let v0 = GuestKey{
            parent_hash : arg1,
            label       : arg2,
        };
        if (!0x2::dynamic_field::exists_<GuestKey>(&arg0.id, v0)) {
            return 0x1::option::none<0x1::string::String>()
        };
        let v1 = 0x2::dynamic_field::borrow<GuestKey, Guest>(&arg0.id, v0);
        if (0x2::clock::timestamp_ms(arg3) >= v1.expires_ms) {
            return 0x1::option::none<0x1::string::String>()
        };
        0x1::option::some<0x1::string::String>(v1.target)
    }

    fun pubkey_to_eth_address(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x2::ecdsa_k1::decompress_pubkey(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 1;
        while (v2 < 65) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        let v3 = 0x2::hash::keccak256(&v1);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 12;
        while (v5 < 32) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v3, v5));
            v5 = v5 + 1;
        };
        v4
    }

    public fun public_chains_contains(arg0: &Roster, arg1: address, arg2: &0x1::string::String) : bool {
        let v0 = PublicChainsKey{addr: arg1};
        if (!0x2::dynamic_field::exists_<PublicChainsKey>(&arg0.id, v0)) {
            return false
        };
        0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&0x2::dynamic_field::borrow<PublicChainsKey, PublicChains>(&arg0.id, v0).visible, arg2)
    }

    public fun public_chains_visible(arg0: &Roster, arg1: address) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = PublicChainsKey{addr: arg1};
        &0x2::dynamic_field::borrow<PublicChainsKey, PublicChains>(&arg0.id, v0).visible
    }

    entry fun reap_guest(arg0: &mut Roster, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = GuestKey{
            parent_hash : arg1,
            label       : arg2,
        };
        assert!(0x2::dynamic_field::exists_<GuestKey>(&arg0.id, v0), 10);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x2::dynamic_field::borrow<GuestKey, Guest>(&arg0.id, v0).expires_ms, 11);
        0x2::dynamic_field::remove<GuestKey, Guest>(&mut arg0.id, v0);
        let v1 = GuestReaped{
            parent_hash : arg1,
            label       : arg2,
            reaper      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<GuestReaped>(v1);
    }

    entry fun reap_guest_stealth(arg0: &mut Roster, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = GuestStealthKey{
            parent_hash : arg1,
            label       : arg2,
        };
        assert!(0x2::dynamic_field::exists_<GuestStealthKey>(&arg0.id, v0), 10);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x2::dynamic_field::borrow<GuestStealthKey, GuestStealth>(&arg0.id, v0).expires_ms, 10);
        0x2::dynamic_field::remove<GuestStealthKey, GuestStealth>(&mut arg0.id, v0);
        let v1 = GuestStealthReaped{
            parent_hash : arg1,
            label       : arg2,
            reaper      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<GuestStealthReaped>(v1);
    }

    public fun record_chains(arg0: &IdentityRecord) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.chains
    }

    public fun record_dwallet_caps(arg0: &IdentityRecord) : &vector<address> {
        &arg0.dwallet_caps
    }

    public fun record_name(arg0: &IdentityRecord) : &0x1::string::String {
        &arg0.name
    }

    public fun record_seal_nonce(arg0: &IdentityRecord) : &vector<u8> {
        &arg0.seal_nonce
    }

    public fun record_sui_address(arg0: &IdentityRecord) : address {
        arg0.sui_address
    }

    public fun record_updated_ms(arg0: &IdentityRecord) : u64 {
        arg0.updated_ms
    }

    public fun record_verified(arg0: &IdentityRecord) : bool {
        arg0.verified
    }

    public fun record_walrus_blob_id(arg0: &IdentityRecord) : &0x1::string::String {
        &arg0.walrus_blob_id
    }

    entry fun revoke_ens_identity(arg0: &mut Roster, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = EnsHashKey{hash: arg1};
        assert!(0x2::dynamic_field::exists_<EnsHashKey>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_field::remove<EnsHashKey, IdentityRecord>(&mut arg0.id, v0);
        assert!(v1.sui_address == 0x2::tx_context::sender(arg2), 0);
    }

    entry fun revoke_guest(arg0: &mut Roster, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = GuestKey{
            parent_hash : arg1,
            label       : arg2,
        };
        assert!(0x2::dynamic_field::exists_<GuestKey>(&arg0.id, v1), 10);
        let v2 = 0x2::dynamic_field::borrow<GuestKey, Guest>(&arg0.id, v1);
        let v3 = 0x1::option::is_some<address>(&v2.delegate) && *0x1::option::borrow<address>(&v2.delegate) == v0;
        assert!(v2.parent_sui_address == v0 || v3, 13);
        0x2::dynamic_field::remove<GuestKey, Guest>(&mut arg0.id, v1);
        let v4 = GuestRevoked{
            parent_hash : arg1,
            label       : arg2,
            revoker     : v0,
        };
        0x2::event::emit<GuestRevoked>(v4);
    }

    entry fun revoke_guest_stealth(arg0: &mut Roster, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = GuestStealthKey{
            parent_hash : arg1,
            label       : arg2,
        };
        assert!(0x2::dynamic_field::exists_<GuestStealthKey>(&arg0.id, v1), 10);
        let v2 = 0x2::dynamic_field::borrow<GuestStealthKey, GuestStealth>(&arg0.id, v1);
        assert!(v2.parent_sui_address == v0 || v2.sweep_delegate == v0, 0);
        0x2::dynamic_field::remove<GuestStealthKey, GuestStealth>(&mut arg0.id, v1);
        let v3 = GuestStealthRevoked{
            parent_hash : arg1,
            label       : arg2,
            revoker     : v0,
        };
        0x2::event::emit<GuestStealthRevoked>(v3);
    }

    public fun revoke_identity(arg0: &mut Roster, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 0);
        let v1 = 0x2::dynamic_field::remove<address, IdentityRecord>(&mut arg0.id, v0);
        assert!(v1.sui_address == v0, 0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<vector<u8>, IdentityRecord>(&mut arg0.id, arg1);
        };
        let v2 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(&v1.chains);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::string::String>(&v2, v3);
            0x1::string::append_utf8(&mut v4, b":");
            0x1::string::append(&mut v4, *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v1.chains, &v4));
            if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v4)) {
                0x2::dynamic_field::remove<0x1::string::String, IdentityRecord>(&mut arg0.id, v4);
            };
            v3 = v3 + 1;
        };
        let v5 = CfHistoryKey{addr: v0};
        if (0x2::dynamic_field::exists_<CfHistoryKey>(&arg0.id, v5)) {
            0x2::dynamic_field::remove<CfHistoryKey, CfHistory>(&mut arg0.id, v5);
        };
        arg0.count = arg0.count - 1;
    }

    fun rewrite_indexes(arg0: &mut 0x2::object::UID, arg1: &IdentityRecord, arg2: vector<u8>) {
        if (0x2::dynamic_field::exists_<vector<u8>>(arg0, arg2)) {
            0x2::dynamic_field::remove<vector<u8>, IdentityRecord>(arg0, arg2);
        };
        0x2::dynamic_field::add<vector<u8>, IdentityRecord>(arg0, arg2, *arg1);
        let v0 = arg1.sui_address;
        if (0x2::dynamic_field::exists_<address>(arg0, v0)) {
            0x2::dynamic_field::remove<address, IdentityRecord>(arg0, v0);
        };
        0x2::dynamic_field::add<address, IdentityRecord>(arg0, v0, *arg1);
        let v1 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(&arg1.chains);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::string::String>(&v1, v2);
            0x1::string::append_utf8(&mut v3, b":");
            0x1::string::append(&mut v3, *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg1.chains, &v3));
            if (0x2::dynamic_field::exists_<0x1::string::String>(arg0, v3)) {
                0x2::dynamic_field::remove<0x1::string::String, IdentityRecord>(arg0, v3);
            };
            0x2::dynamic_field::add<0x1::string::String, IdentityRecord>(arg0, v3, *arg1);
            v2 = v2 + 1;
        };
    }

    entry fun seal_approve_guest_stealth(arg0: &Roster, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = GuestStealthKey{
            parent_hash : arg1,
            label       : arg2,
        };
        assert!(0x2::dynamic_field::exists_<GuestStealthKey>(&arg0.id, v0), 10);
        let v1 = 0x2::dynamic_field::borrow<GuestStealthKey, GuestStealth>(&arg0.id, v0);
        assert!(v1.sweep_delegate == 0x2::tx_context::sender(arg4), 0);
        assert!(0x2::clock::timestamp_ms(arg3) < v1.expires_ms, 10);
    }

    public fun set_dwallet_caps(arg0: &mut Roster, arg1: vector<u8>, arg2: vector<address>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 0);
        let v1 = 0x2::dynamic_field::borrow<address, IdentityRecord>(&arg0.id, v0);
        assert!(v1.sui_address == v0, 0);
        let v2 = *v1;
        v2.dwallet_caps = arg2;
        v2.verified = !0x1::vector::is_empty<address>(&v2.dwallet_caps);
        v2.updated_ms = 0x2::clock::timestamp_ms(arg3);
        let v3 = &mut arg0.id;
        rewrite_indexes(v3, &v2, arg1);
    }

    entry fun set_ens_identity(arg0: &mut Roster, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 0);
        let v1 = *0x2::dynamic_field::borrow<address, IdentityRecord>(&arg0.id, v0);
        assert!(v1.sui_address == v0, 0);
        let v2 = EnsHashKey{hash: arg2};
        assert!(!0x2::dynamic_field::exists_<EnsHashKey>(&arg0.id, v2), 2);
        v1.updated_ms = 0x2::clock::timestamp_ms(arg4);
        0x2::dynamic_field::add<EnsHashKey, IdentityRecord>(&mut arg0.id, v2, v1);
        let v3 = IdentitySet{
            name          : arg1,
            sui_address   : v0,
            chain_count   : 0x2::vec_map::length<0x1::string::String, 0x1::string::String>(&v1.chains),
            dwallet_count : 0x1::vector::length<address>(&v1.dwallet_caps),
        };
        0x2::event::emit<IdentitySet>(v3);
    }

    entry fun set_ens_identity_verified(arg0: &mut Roster, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 0);
        let v1 = *0x2::dynamic_field::borrow<address, IdentityRecord>(&arg0.id, v0);
        assert!(v1.sui_address == v0, 0);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = if (arg4 > v2) {
            arg4 - v2
        } else {
            v2 - arg4
        };
        assert!(v3 <= 600000, 7);
        assert!(0x1::vector::length<u8>(&arg3) == 65, 6);
        let v4 = 0x1::string::utf8(b"eth");
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.chains, &v4), 4);
        let v5 = *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v1.chains, &v4);
        let v6 = build_bind_inner_message(&arg1, v0, arg4);
        let v7 = eip191_wrap(&v6);
        let v8 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg3, &v7, 0);
        assert!(pubkey_to_eth_address(&v8) == eth_hex_string_to_bytes(&v5), 5);
        let v9 = EnsHashKey{hash: arg2};
        assert!(!0x2::dynamic_field::exists_<EnsHashKey>(&arg0.id, v9), 2);
        v1.updated_ms = 0x2::clock::timestamp_ms(arg5);
        0x2::dynamic_field::add<EnsHashKey, IdentityRecord>(&mut arg0.id, v9, v1);
        let v10 = IdentitySet{
            name          : arg1,
            sui_address   : v0,
            chain_count   : 0x2::vec_map::length<0x1::string::String, 0x1::string::String>(&v1.chains),
            dwallet_count : 0x1::vector::length<address>(&v1.dwallet_caps),
        };
        0x2::event::emit<IdentitySet>(v10);
    }

    entry fun set_identity(arg0: &mut Roster, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<address>, arg6: 0x1::string::String, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg3);
        assert!(v1 > 0 && v1 == 0x1::vector::length<0x1::string::String>(&arg4), 1);
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v3 = 0;
        while (v3 < v1) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, *0x1::vector::borrow<0x1::string::String>(&arg3, v3), *0x1::vector::borrow<0x1::string::String>(&arg4, v3));
            v3 = v3 + 1;
        };
        let v4 = IdentityRecord{
            name           : arg1,
            sui_address    : v0,
            chains         : v2,
            dwallet_caps   : arg5,
            updated_ms     : 0x2::clock::timestamp_ms(arg8),
            walrus_blob_id : arg6,
            seal_nonce     : arg7,
            verified       : !0x1::vector::is_empty<address>(&arg5),
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg2)) {
            0x2::dynamic_field::remove<vector<u8>, IdentityRecord>(&mut arg0.id, arg2);
        } else {
            arg0.count = arg0.count + 1;
        };
        0x2::dynamic_field::add<vector<u8>, IdentityRecord>(&mut arg0.id, arg2, v4);
        if (0x2::dynamic_field::exists_<address>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<address, IdentityRecord>(&mut arg0.id, v0);
        };
        0x2::dynamic_field::add<address, IdentityRecord>(&mut arg0.id, v0, v4);
        let v5 = 0;
        while (v5 < v1) {
            let v6 = *0x1::vector::borrow<0x1::string::String>(&arg3, v5);
            0x1::string::append_utf8(&mut v6, b":");
            0x1::string::append(&mut v6, *0x1::vector::borrow<0x1::string::String>(&arg4, v5));
            if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v6)) {
                0x2::dynamic_field::remove<0x1::string::String, IdentityRecord>(&mut arg0.id, v6);
            };
            0x2::dynamic_field::add<0x1::string::String, IdentityRecord>(&mut arg0.id, v6, v4);
            v5 = v5 + 1;
        };
        let v7 = IdentitySet{
            name          : arg1,
            sui_address   : v0,
            chain_count   : v1,
            dwallet_count : 0x1::vector::length<address>(&arg5),
        };
        0x2::event::emit<IdentitySet>(v7);
    }

    entry fun set_public_chains(arg0: &mut Roster, arg1: vector<0x1::string::String>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 9);
        let v1 = 0x2::dynamic_field::borrow<address, IdentityRecord>(&arg0.id, v0);
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v3 = 0;
        let v4 = 0x1::vector::length<0x1::string::String>(&arg1);
        while (v3 < v4) {
            let v5 = *0x1::vector::borrow<0x1::string::String>(&arg1, v3);
            assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.chains, &v5), 8);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, v5, *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v1.chains, &v5));
            v3 = v3 + 1;
        };
        let v6 = PublicChainsKey{addr: v0};
        if (0x2::dynamic_field::exists_<PublicChainsKey>(&arg0.id, v6)) {
            0x2::dynamic_field::remove<PublicChainsKey, PublicChains>(&mut arg0.id, v6);
        };
        let v7 = PublicChains{
            visible    : v2,
            updated_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::dynamic_field::add<PublicChainsKey, PublicChains>(&mut arg0.id, v6, v7);
        let v8 = PublicChainsSet{
            sui_address : v0,
            chain_count : v4,
        };
        0x2::event::emit<PublicChainsSet>(v8);
    }

    entry fun set_stealth_meta(arg0: &mut Roster, arg1: 0x2::object::ID, arg2: vector<0x1::string::String>, arg3: vector<vector<u8>>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 9);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v1 == 0x1::vector::length<vector<u8>>(&arg3), 1);
        let v2 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
        let v3 = 0;
        while (v3 < v1) {
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v2, *0x1::vector::borrow<0x1::string::String>(&arg2, v3), *0x1::vector::borrow<vector<u8>>(&arg3, v3));
            v3 = v3 + 1;
        };
        let v4 = StealthMetaKey{addr: v0};
        if (0x2::dynamic_field::exists_<StealthMetaKey>(&arg0.id, v4)) {
            0x2::dynamic_field::remove<StealthMetaKey, StealthMeta>(&mut arg0.id, v4);
        };
        let v5 = 0x2::clock::timestamp_ms(arg4);
        let v6 = StealthMeta{
            ika_dwallet_id : arg1,
            view_pubkeys   : v2,
            updated_ms     : v5,
        };
        0x2::dynamic_field::add<StealthMetaKey, StealthMeta>(&mut arg0.id, v4, v6);
        let v7 = StealthMetaSet{
            addr           : v0,
            ika_dwallet_id : arg1,
            chains         : arg2,
            updated_ms     : v5,
        };
        0x2::event::emit<StealthMetaSet>(v7);
    }

    public fun set_walrus_blob(arg0: &mut Roster, arg1: vector<u8>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 0);
        let v1 = 0x2::dynamic_field::borrow<address, IdentityRecord>(&arg0.id, v0);
        assert!(v1.sui_address == v0, 0);
        let v2 = *v1;
        v2.walrus_blob_id = arg2;
        v2.seal_nonce = arg3;
        v2.updated_ms = 0x2::clock::timestamp_ms(arg4);
        let v3 = &mut arg0.id;
        rewrite_indexes(v3, &v2, arg1);
    }

    public fun stealth_meta_dwallet_id(arg0: &Roster, arg1: address) : 0x2::object::ID {
        let v0 = StealthMetaKey{addr: arg1};
        0x2::dynamic_field::borrow<StealthMetaKey, StealthMeta>(&arg0.id, v0).ika_dwallet_id
    }

    public fun stealth_meta_has_chain(arg0: &Roster, arg1: address, arg2: &0x1::string::String) : bool {
        let v0 = StealthMetaKey{addr: arg1};
        if (!0x2::dynamic_field::exists_<StealthMetaKey>(&arg0.id, v0)) {
            return false
        };
        0x2::vec_map::contains<0x1::string::String, vector<u8>>(&0x2::dynamic_field::borrow<StealthMetaKey, StealthMeta>(&arg0.id, v0).view_pubkeys, arg2)
    }

    public fun stealth_meta_updated_ms(arg0: &Roster, arg1: address) : u64 {
        let v0 = StealthMetaKey{addr: arg1};
        0x2::dynamic_field::borrow<StealthMetaKey, StealthMeta>(&arg0.id, v0).updated_ms
    }

    public fun stealth_meta_view_pubkey(arg0: &Roster, arg1: address, arg2: &0x1::string::String) : vector<u8> {
        let v0 = StealthMetaKey{addr: arg1};
        assert!(0x2::dynamic_field::exists_<StealthMetaKey>(&arg0.id, v0), 9);
        let v1 = 0x2::dynamic_field::borrow<StealthMetaKey, StealthMeta>(&arg0.id, v0);
        assert!(0x2::vec_map::contains<0x1::string::String, vector<u8>>(&v1.view_pubkeys, arg2), 8);
        *0x2::vec_map::get<0x1::string::String, vector<u8>>(&v1.view_pubkeys, arg2)
    }

    public fun stealth_meta_view_pubkeys(arg0: &Roster, arg1: address) : &0x2::vec_map::VecMap<0x1::string::String, vector<u8>> {
        let v0 = StealthMetaKey{addr: arg1};
        &0x2::dynamic_field::borrow<StealthMetaKey, StealthMeta>(&arg0.id, v0).view_pubkeys
    }

    fun u64_to_ascii_decimal(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, 48 + ((arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v7
}

