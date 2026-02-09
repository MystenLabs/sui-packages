module 0xc3dc70c7ca20eaf2e1c52826cf5b9fb2712e34a1d6f3de5f4dfb727c32d62c36::pawtato_admin {
    struct PAWTATO_ADMIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BridgeWithdrawCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFTUpgradeCap has store, key {
        id: 0x2::object::UID,
    }

    struct BridgePauseCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_bridge_pause_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgePauseCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BridgePauseCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_bridge_withdraw_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeWithdrawCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BridgeWithdrawCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_nft_upgrade_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTUpgradeCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<NFTUpgradeCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: PAWTATO_ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

