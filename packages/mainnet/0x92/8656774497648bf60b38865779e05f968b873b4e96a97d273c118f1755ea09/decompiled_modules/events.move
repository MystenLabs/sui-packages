module 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events {
    struct MintedEggsEventMetadata {
        amount: u32,
    }

    struct MintedEggs has copy, drop {
        amount: u32,
    }

    struct AddedToWhitelist has copy, drop {
        added_address: address,
    }

    struct RemovedFromWhitelist has copy, drop {
        removed_address: address,
    }

    struct CompletedWhitelistPurchase has copy, drop {
        buyer: address,
    }

    struct CompletedPublicSalePurchase has copy, drop {
        buyer: address,
    }

    public(friend) fun add_minted_amount(arg0: &mut MintedEggsEventMetadata, arg1: u32) {
        arg0.amount = arg0.amount + arg1;
    }

    public(friend) fun begin_mint() : MintedEggsEventMetadata {
        MintedEggsEventMetadata{amount: 0}
    }

    public(friend) fun emit_added_to_whitelist(arg0: address) {
        let v0 = AddedToWhitelist{added_address: arg0};
        0x2::event::emit<AddedToWhitelist>(v0);
    }

    public(friend) fun emit_completed_public_sale_purchase(arg0: address) {
        let v0 = CompletedPublicSalePurchase{buyer: arg0};
        0x2::event::emit<CompletedPublicSalePurchase>(v0);
    }

    public(friend) fun emit_completed_whitelist_purchase(arg0: address) {
        let v0 = CompletedWhitelistPurchase{buyer: arg0};
        0x2::event::emit<CompletedWhitelistPurchase>(v0);
    }

    public(friend) fun emit_minted_eggs(arg0: MintedEggsEventMetadata) {
        let MintedEggsEventMetadata { amount: v0 } = arg0;
        let v1 = MintedEggs{amount: v0};
        0x2::event::emit<MintedEggs>(v1);
    }

    public(friend) fun emit_removed_from_whitelist(arg0: address) {
        let v0 = RemovedFromWhitelist{removed_address: arg0};
        0x2::event::emit<RemovedFromWhitelist>(v0);
    }

    // decompiled from Move bytecode v6
}

