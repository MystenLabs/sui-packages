module 0x5a6582f37d9830f872b4d17611bddffd04510c3cf6f1f84ebb7f489851fea15b::whale_extra {
    struct ParentTrap has store, key {
        id: 0x2::object::UID,
    }

    struct DecoyFrozen has store, key {
        id: 0x2::object::UID,
        held: 0x2::balance::Balance<0x2::sui::SUI>,
        labeled_for: address,
    }

    struct DecoyDelivery has copy, drop {
        to: address,
        amount: u64,
    }

    struct ImmutableParentTrap has store, key {
        id: 0x2::object::UID,
        labeled_for: address,
    }

    struct AttackerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        held: 0x2::balance::Balance<0x2::sui::SUI>,
        labeled_for: address,
    }

    struct ClaimTicket {
        parent_id: address,
        amount: u64,
    }

    public entry fun burn_gas(arg0: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < arg0) {
            let v2 = v1 ^ v0 * 7919;
            v1 = v2 + 1;
            v0 = v0 + 1;
        };
    }

    public entry fun create_frozen_parent_then_park(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ImmutableParentTrap{
            id          : 0x2::object::new(arg2),
            labeled_for : arg1,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::object::id_address<ImmutableParentTrap>(&v0));
        0x2::transfer::public_freeze_object<ImmutableParentTrap>(v0);
    }

    public entry fun create_parent_then_park(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ParentTrap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::object::id_address<ParentTrap>(&v0));
        0x2::transfer::public_transfer<ParentTrap>(v0, arg1);
    }

    public fun decoy_held_value(arg0: &DecoyFrozen) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.held)
    }

    public fun decoy_labeled_for(arg0: &DecoyFrozen) : address {
        arg0.labeled_for
    }

    public fun extract_from_vault(arg0: Vault, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ClaimTicket, address) {
        let Vault {
            id          : v0,
            held        : v1,
            labeled_for : v2,
        } = arg0;
        let v3 = v1;
        let v4 = v0;
        0x2::object::delete(v4);
        let v5 = ClaimTicket{
            parent_id : 0x2::object::uid_to_address(&v4),
            amount    : 0x2::balance::value<0x2::sui::SUI>(&v3),
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(v3, arg1), v5, v2)
    }

    public entry fun freeze_decoy_labeled_to(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DecoyFrozen{
            id          : 0x2::object::new(arg2),
            held        : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            labeled_for : arg1,
        };
        let v1 = DecoyDelivery{
            to     : arg1,
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
        };
        0x2::event::emit<DecoyDelivery>(v1);
        0x2::transfer::public_freeze_object<DecoyFrozen>(v0);
    }

    public fun immutable_parent_labeled_for(arg0: &ImmutableParentTrap) : address {
        arg0.labeled_for
    }

    public entry fun mint_attacker_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AttackerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AttackerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun redeem_ticket(arg0: &AttackerCap, arg1: ClaimTicket) : (address, u64) {
        let ClaimTicket {
            parent_id : v0,
            amount    : v1,
        } = arg1;
        (v0, v1)
    }

    public entry fun vault_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id          : 0x2::object::new(arg2),
            held        : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            labeled_for : arg1,
        };
        0x2::transfer::public_transfer<Vault>(v0, arg1);
    }

    public fun vault_labeled_for(arg0: &Vault) : address {
        arg0.labeled_for
    }

    public fun vault_value(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.held)
    }

    // decompiled from Move bytecode v7
}

