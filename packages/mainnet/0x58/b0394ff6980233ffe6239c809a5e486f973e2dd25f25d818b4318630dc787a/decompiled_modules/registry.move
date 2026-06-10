module 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::registry {
    struct ProtocolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
        initialized: bool,
        vault_count: u64,
        paused: bool,
        protocol_fee_recipient: address,
        protocol_fee_bps: u64,
        min_seed_deposit_usdc: u64,
    }

    public(friend) fun increment_vault_count(arg0: &mut VaultRegistry) : u64 {
        arg0.vault_count = arg0.vault_count + 1;
        arg0.vault_count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{
            id                     : 0x2::object::new(arg0),
            initialized            : true,
            vault_count            : 0,
            paused                 : false,
            protocol_fee_recipient : 0x2::tx_context::sender(arg0),
            protocol_fee_bps       : 0,
            min_seed_deposit_usdc  : 0,
        };
        0x2::transfer::share_object<VaultRegistry>(v0);
        let v1 = ProtocolAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ProtocolAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun is_paused(arg0: &VaultRegistry) : bool {
        arg0.paused
    }

    public(friend) fun min_seed_deposit_usdc(arg0: &VaultRegistry) : u64 {
        arg0.min_seed_deposit_usdc
    }

    public(friend) fun protocol_fee_bps(arg0: &VaultRegistry) : u64 {
        arg0.protocol_fee_bps
    }

    public(friend) fun protocol_fee_recipient(arg0: &VaultRegistry) : address {
        arg0.protocol_fee_recipient
    }

    public entry fun set_registry_paused(arg0: &ProtocolAdminCap, arg1: &mut VaultRegistry, arg2: bool, arg3: &0x2::clock::Clock) {
        arg1.paused = arg2;
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::emit_registry_pause(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::new_registry_pause(arg2, 0x2::clock::timestamp_ms(arg3)));
    }

    public entry fun update_min_seed(arg0: &ProtocolAdminCap, arg1: &mut VaultRegistry, arg2: u64, arg3: &0x2::clock::Clock) {
        arg1.min_seed_deposit_usdc = arg2;
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::emit_min_seed_updated(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::new_min_seed_updated(arg2, 0x2::clock::timestamp_ms(arg3)));
    }

    public entry fun update_protocol_fee(arg0: &ProtocolAdminCap, arg1: &mut VaultRegistry, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg3 <= 10000, 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::errors::invalid_fee_bps());
        arg1.protocol_fee_recipient = arg2;
        arg1.protocol_fee_bps = arg3;
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::emit_protocol_fee_updated(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::new_protocol_fee_updated(arg2, arg3, 0x2::clock::timestamp_ms(arg4)));
    }

    public(friend) fun vault_count(arg0: &VaultRegistry) : u64 {
        arg0.vault_count
    }

    // decompiled from Move bytecode v7
}

