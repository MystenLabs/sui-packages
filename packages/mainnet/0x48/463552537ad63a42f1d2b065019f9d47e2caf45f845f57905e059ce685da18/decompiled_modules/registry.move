module 0x48463552537ad63a42f1d2b065019f9d47e2caf45f845f57905e059ce685da18::registry {
    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct QuiltRegistered has copy, drop {
        vault_id: 0x2::object::ID,
        quilt_id: 0x1::string::String,
        blob_id: 0x1::string::String,
        memory_count: u64,
        expires_epoch: u64,
    }

    struct QuiltRenewed has copy, drop {
        vault_id: 0x2::object::ID,
        quilt_id: 0x1::string::String,
        old_expires: u64,
        new_expires: u64,
    }

    struct AllRenewed has copy, drop {
        vault_id: 0x2::object::ID,
        quilts_renewed: u64,
        new_expires_epoch: u64,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        owner: address,
        quilts: 0x2::table::Table<0x1::string::String, QuiltInfo>,
        quilt_ids: vector<0x1::string::String>,
        total_memories: u64,
        total_quilts: u64,
        created_at: u64,
        name: 0x1::string::String,
        encrypted: bool,
    }

    struct QuiltInfo has copy, drop, store {
        blob_id: 0x1::string::String,
        memory_count: u64,
        expires_epoch: u64,
        created_at: u64,
        encrypted: bool,
        seal_id: 0x1::string::String,
    }

    struct NetherRegistry has key {
        id: 0x2::object::UID,
        total_vaults: u64,
        total_quilts: u64,
        total_memories: u64,
    }

    public entry fun create_vault(arg0: &mut NetherRegistry, arg1: vector<u8>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id             : 0x2::object::new(arg4),
            owner          : 0x2::tx_context::sender(arg4),
            quilts         : 0x2::table::new<0x1::string::String, QuiltInfo>(arg4),
            quilt_ids      : 0x1::vector::empty<0x1::string::String>(),
            total_memories : 0,
            total_quilts   : 0,
            created_at     : 0x2::clock::timestamp_ms(arg3),
            name           : 0x1::string::utf8(arg1),
            encrypted      : arg2,
        };
        arg0.total_vaults = arg0.total_vaults + 1;
        let v1 = VaultCreated{
            vault_id : 0x2::object::id<Vault>(&v0),
            owner    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::transfer<Vault>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun get_expiring_count(arg0: &Vault, arg1: u64, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0.quilt_ids)) {
            let v2 = 0x2::table::borrow<0x1::string::String, QuiltInfo>(&arg0.quilts, *0x1::vector::borrow<0x1::string::String>(&arg0.quilt_ids, v1));
            if (v2.expires_epoch > arg1 && v2.expires_epoch <= arg1 + arg2) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_quilt(arg0: &Vault, arg1: 0x1::string::String) : &QuiltInfo {
        0x2::table::borrow<0x1::string::String, QuiltInfo>(&arg0.quilts, arg1)
    }

    public fun get_quilt_ids(arg0: &Vault) : &vector<0x1::string::String> {
        &arg0.quilt_ids
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NetherRegistry{
            id             : 0x2::object::new(arg0),
            total_vaults   : 0,
            total_quilts   : 0,
            total_memories : 0,
        };
        0x2::transfer::share_object<NetherRegistry>(v0);
    }

    public entry fun register_quilt(arg0: &mut Vault, arg1: &mut NetherRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: bool, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg9), 2);
        let v0 = 0x1::string::utf8(arg2);
        let v1 = QuiltInfo{
            blob_id       : 0x1::string::utf8(arg3),
            memory_count  : arg4,
            expires_epoch : arg5,
            created_at    : 0x2::clock::timestamp_ms(arg8),
            encrypted     : arg6,
            seal_id       : 0x1::string::utf8(arg7),
        };
        0x2::table::add<0x1::string::String, QuiltInfo>(&mut arg0.quilts, v0, v1);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.quilt_ids, v0);
        arg0.total_quilts = arg0.total_quilts + 1;
        arg0.total_memories = arg0.total_memories + arg4;
        arg1.total_quilts = arg1.total_quilts + 1;
        arg1.total_memories = arg1.total_memories + arg4;
        let v2 = QuiltRegistered{
            vault_id      : 0x2::object::id<Vault>(arg0),
            quilt_id      : v0,
            blob_id       : 0x1::string::utf8(arg3),
            memory_count  : arg4,
            expires_epoch : arg5,
        };
        0x2::event::emit<QuiltRegistered>(v2);
    }

    public entry fun renew_all(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        let v0 = arg2 + arg1;
        let v1 = 0;
        let v2 = 0x1::vector::length<0x1::string::String>(&arg0.quilt_ids);
        while (v1 < v2) {
            0x2::table::borrow_mut<0x1::string::String, QuiltInfo>(&mut arg0.quilts, *0x1::vector::borrow<0x1::string::String>(&arg0.quilt_ids, v1)).expires_epoch = v0;
            v1 = v1 + 1;
        };
        let v3 = AllRenewed{
            vault_id          : 0x2::object::id<Vault>(arg0),
            quilts_renewed    : v2,
            new_expires_epoch : v0,
        };
        0x2::event::emit<AllRenewed>(v3);
    }

    public entry fun renew_quilt(arg0: &mut Vault, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, QuiltInfo>(&arg0.quilts, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, QuiltInfo>(&mut arg0.quilts, v0);
        v1.expires_epoch = arg2;
        let v2 = QuiltRenewed{
            vault_id    : 0x2::object::id<Vault>(arg0),
            quilt_id    : v0,
            old_expires : v1.expires_epoch,
            new_expires : arg2,
        };
        0x2::event::emit<QuiltRenewed>(v2);
    }

    public fun vault_stats(arg0: &Vault) : (u64, u64, u64) {
        (arg0.total_quilts, arg0.total_memories, arg0.created_at)
    }

    // decompiled from Move bytecode v6
}

