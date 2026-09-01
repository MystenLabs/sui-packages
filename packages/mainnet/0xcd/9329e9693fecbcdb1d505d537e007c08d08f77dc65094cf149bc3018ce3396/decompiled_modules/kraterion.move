module 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::kraterion {
    struct KraterionBucket has key {
        id: 0x2::object::UID,
        owner: address,
        name: vector<u8>,
        encryption_mode: u8,
        api_decryption_addresses: vector<address>,
        created_epoch: u64,
    }

    public fun id(arg0: &KraterionBucket) : &0x2::object::UID {
        &arg0.id
    }

    public fun api_addresses(arg0: &KraterionBucket) : &vector<address> {
        &arg0.api_decryption_addresses
    }

    public(friend) fun assert_caller_authorized_for_bucket(arg0: &KraterionBucket, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner || 0x1::vector::contains<address>(&arg0.api_decryption_addresses, &v0), 1);
    }

    fun assert_known_mode(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 2);
    }

    public fun create_and_share_bucket(arg0: vector<u8>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert_known_mode(arg1);
        let v0 = new_bucket(arg0, arg1, arg2);
        0x2::transfer::share_object<KraterionBucket>(v0);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_bucket_created(0x2::object::id<KraterionBucket>(&v0), v0.owner, v0.name, v0.encryption_mode);
    }

    public fun create_grant_and_share_bucket(arg0: vector<u8>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert_known_mode(arg2);
        let v0 = new_bucket(arg0, arg2, arg3);
        0x1::vector::push_back<address>(&mut v0.api_decryption_addresses, arg1);
        let v1 = 0x2::object::id<KraterionBucket>(&v0);
        let v2 = v0.owner;
        0x2::transfer::share_object<KraterionBucket>(v0);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_bucket_created(v1, v2, v0.name, v0.encryption_mode);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_api_access_granted(v1, v2, arg1);
    }

    public fun encryption_mode(arg0: &KraterionBucket) : u8 {
        arg0.encryption_mode
    }

    public fun encryption_mode_private() : u8 {
        0
    }

    public fun encryption_mode_public() : u8 {
        1
    }

    public fun grant_api_access(arg0: &mut KraterionBucket, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        if (!0x1::vector::contains<address>(&arg0.api_decryption_addresses, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.api_decryption_addresses, arg1);
        };
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_api_access_granted(0x2::object::id<KraterionBucket>(arg0), arg0.owner, arg1);
    }

    public fun name(arg0: &KraterionBucket) : &vector<u8> {
        &arg0.name
    }

    fun new_bucket(arg0: vector<u8>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : KraterionBucket {
        KraterionBucket{
            id                       : 0x2::object::new(arg2),
            owner                    : 0x2::tx_context::sender(arg2),
            name                     : arg0,
            encryption_mode          : arg1,
            api_decryption_addresses : 0x1::vector::empty<address>(),
            created_epoch            : 0x2::tx_context::epoch(arg2),
        }
    }

    public fun owner(arg0: &KraterionBucket) : address {
        arg0.owner
    }

    public fun revoke_all_api_access(arg0: &mut KraterionBucket, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        arg0.api_decryption_addresses = 0x1::vector::empty<address>();
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_api_access_revoked(0x2::object::id<KraterionBucket>(arg0), arg0.owner);
    }

    public fun set_bucket_visibility(arg0: &mut KraterionBucket, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert_known_mode(arg1);
        if (arg0.encryption_mode != arg1) {
            arg0.encryption_mode = arg1;
            0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_bucket_visibility_changed(0x2::object::id<KraterionBucket>(arg0), arg0.owner, arg0.encryption_mode, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

