module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::adapters_custody {
    struct ForeignCustodyBinding has key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        bound_owner: address,
        chain_tag: 0x1::string::String,
        dwallet_cap_id: 0x2::object::ID,
        dwallet_address: 0x1::string::String,
        to_primary: 0x1::string::String,
        min_sweep_micros: u64,
        bounty_bps: u64,
        max_bounty_micros: u64,
        nonce: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct ForeignCustodyBound has copy, drop {
        binding_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        chain_tag: 0x1::string::String,
        dwallet_cap_id: 0x2::object::ID,
        dwallet_address: 0x1::string::String,
        to_primary: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ForeignCustodyRebound has copy, drop {
        binding_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
        chain_tag: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ForeignSweepAuthorized has copy, drop {
        binding_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        chain_tag: 0x1::string::String,
        dwallet_cap_id: 0x2::object::ID,
        to_primary: 0x1::string::String,
        tx_payload_hash: vector<u8>,
        amount_micros: u64,
        bounty_micros: u64,
        to_primary_micros: u64,
        keeper: address,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct ForeignSignAuthorized has copy, drop {
        binding_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        chain_tag: 0x1::string::String,
        dwallet_cap_id: 0x2::object::ID,
        destination: 0x1::string::String,
        tx_payload_hash: vector<u8>,
        owner: address,
        nonce: u64,
        timestamp_ms: u64,
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 704);
    }

    fun assert_ref(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 704);
        assert!(0x1::vector::length<u8>(arg0) <= 512, 705);
    }

    public fun authorize_foreign_sign(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut ForeignCustodyBinding, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, v0);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 702);
        assert_ref(&arg2);
        assert_hash(&arg3);
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v1 = ForeignSignAuthorized{
            binding_id      : 0x2::object::uid_to_inner(&arg1.id),
            character_id    : arg1.character_id,
            chain_tag       : arg1.chain_tag,
            dwallet_cap_id  : arg1.dwallet_cap_id,
            destination     : 0x1::string::utf8(arg2),
            tx_payload_hash : arg3,
            owner           : v0,
            nonce           : arg1.nonce,
            timestamp_ms    : arg1.updated_at_ms,
        };
        0x2::event::emit<ForeignSignAuthorized>(v1);
    }

    public fun authorize_foreign_sweep(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut ForeignCustodyBinding, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(!0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::is_paused(arg0), 710);
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 702);
        assert!(arg1.bound_owner == 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::owner(arg0), 703);
        assert_hash(&arg3);
        assert!(arg4 > 0, 708);
        assert!(arg4 >= arg1.min_sweep_micros, 706);
        assert!(0x1::string::utf8(arg2) == arg1.to_primary, 701);
        let v0 = (((arg4 as u128) * (arg1.bounty_bps as u128) / (10000 as u128)) as u64);
        let v1 = if (v0 < arg1.max_bounty_micros) {
            v0
        } else {
            arg1.max_bounty_micros
        };
        assert!(v1 < arg4, 707);
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v2 = ForeignSweepAuthorized{
            binding_id        : 0x2::object::uid_to_inner(&arg1.id),
            character_id      : arg1.character_id,
            chain_tag         : arg1.chain_tag,
            dwallet_cap_id    : arg1.dwallet_cap_id,
            to_primary        : arg1.to_primary,
            tx_payload_hash   : arg3,
            amount_micros     : arg4,
            bounty_micros     : v1,
            to_primary_micros : arg4 - v1,
            keeper            : 0x2::tx_context::sender(arg6),
            nonce             : arg1.nonce,
            timestamp_ms      : arg1.updated_at_ms,
        };
        0x2::event::emit<ForeignSweepAuthorized>(v2);
    }

    public fun bind_dwallet_to_owner(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut ForeignCustodyBinding, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, v0);
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 702);
        assert_ref(&arg2);
        arg1.bound_owner = v0;
        arg1.to_primary = 0x1::string::utf8(arg2);
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        arg1.nonce = arg1.nonce + 1;
        let v1 = ForeignCustodyRebound{
            binding_id     : 0x2::object::uid_to_inner(&arg1.id),
            character_id   : arg1.character_id,
            previous_owner : arg1.bound_owner,
            new_owner      : v0,
            chain_tag      : arg1.chain_tag,
            timestamp_ms   : arg1.updated_at_ms,
        };
        0x2::event::emit<ForeignCustodyRebound>(v1);
    }

    public fun binding_bounty_bps(arg0: &ForeignCustodyBinding) : u64 {
        arg0.bounty_bps
    }

    public fun binding_chain_tag(arg0: &ForeignCustodyBinding) : 0x1::string::String {
        arg0.chain_tag
    }

    public fun binding_character_id(arg0: &ForeignCustodyBinding) : 0x2::object::ID {
        arg0.character_id
    }

    public fun binding_dwallet_cap_id(arg0: &ForeignCustodyBinding) : 0x2::object::ID {
        arg0.dwallet_cap_id
    }

    public fun binding_max_bounty_micros(arg0: &ForeignCustodyBinding) : u64 {
        arg0.max_bounty_micros
    }

    public fun binding_min_sweep_micros(arg0: &ForeignCustodyBinding) : u64 {
        arg0.min_sweep_micros
    }

    public fun binding_nonce(arg0: &ForeignCustodyBinding) : u64 {
        arg0.nonce
    }

    public fun binding_owner(arg0: &ForeignCustodyBinding) : address {
        arg0.bound_owner
    }

    public fun binding_to_primary(arg0: &ForeignCustodyBinding) : 0x1::string::String {
        arg0.to_primary
    }

    public fun create_foreign_binding(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, v0);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_ref(&arg1);
        assert_ref(&arg3);
        assert_ref(&arg4);
        assert!(arg6 <= 1000, 709);
        assert!(arg5 >= 1, 706);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = ForeignCustodyBinding{
            id                : 0x2::object::new(arg9),
            character_id      : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            bound_owner       : v0,
            chain_tag         : 0x1::string::utf8(arg1),
            dwallet_cap_id    : arg2,
            dwallet_address   : 0x1::string::utf8(arg3),
            to_primary        : 0x1::string::utf8(arg4),
            min_sweep_micros  : arg5,
            bounty_bps        : arg6,
            max_bounty_micros : arg7,
            nonce             : 0,
            created_at_ms     : v1,
            updated_at_ms     : v1,
        };
        let v3 = ForeignCustodyBound{
            binding_id      : 0x2::object::uid_to_inner(&v2.id),
            character_id    : v2.character_id,
            owner           : v0,
            chain_tag       : v2.chain_tag,
            dwallet_cap_id  : arg2,
            dwallet_address : v2.dwallet_address,
            to_primary      : v2.to_primary,
            timestamp_ms    : v1,
        };
        0x2::event::emit<ForeignCustodyBound>(v3);
        0x2::transfer::share_object<ForeignCustodyBinding>(v2);
    }

    // decompiled from Move bytecode v7
}

