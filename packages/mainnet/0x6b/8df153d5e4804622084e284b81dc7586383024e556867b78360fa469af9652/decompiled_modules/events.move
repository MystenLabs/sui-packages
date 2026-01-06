module 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::events {
    struct Minted<phantom T0> has copy, drop {
        amount: u64,
        sender: address,
        recipient: address,
    }

    struct Burned<phantom T0> has copy, drop {
        amount: u64,
        sender: address,
    }

    struct WrappedEvent<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        recipient: address,
        sender: address,
    }

    struct UnwrappedEvent<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        sender: address,
    }

    struct AddedToBlocklistEvent<phantom T0, phantom T1> has copy, drop {
        blocked_address: address,
        sender: address,
    }

    struct RemovedFromBlocklistEvent<phantom T0, phantom T1> has copy, drop {
        unblocked_address: address,
        sender: address,
    }

    struct StablecoinRegisteredEvent<phantom T0, phantom T1> has copy, drop {
        sender: address,
    }

    struct StablecoinUnregisteredEvent<phantom T0, phantom T1> has copy, drop {
        sender: address,
    }

    struct MintRecipientAddedEvent<phantom T0, phantom T1> has copy, drop {
        recipient: address,
        sender: address,
    }

    struct MintRecipientRemovedEvent<phantom T0, phantom T1> has copy, drop {
        recipient: address,
        sender: address,
    }

    struct NewVersionEvent<phantom T0> has copy, drop {
        version: u16,
        sender: address,
    }

    struct PauseEvent<phantom T0, phantom T1> has copy, drop {
        paused: bool,
        sender: address,
    }

    public(friend) fun emit_added_to_blocklist_event<T0, T1>(arg0: address, arg1: address) {
        let v0 = AddedToBlocklistEvent<T0, T1>{
            blocked_address : arg0,
            sender          : arg1,
        };
        0x2::event::emit<AddedToBlocklistEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_burned_event<T0>(arg0: u64, arg1: address) {
        let v0 = Burned<T0>{
            amount : arg0,
            sender : arg1,
        };
        0x2::event::emit<Burned<T0>>(v0);
    }

    public(friend) fun emit_mint_recipient_added_event<T0, T1>(arg0: address, arg1: address) {
        let v0 = MintRecipientAddedEvent<T0, T1>{
            recipient : arg0,
            sender    : arg1,
        };
        0x2::event::emit<MintRecipientAddedEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_mint_recipient_removed_event<T0, T1>(arg0: address, arg1: address) {
        let v0 = MintRecipientRemovedEvent<T0, T1>{
            recipient : arg0,
            sender    : arg1,
        };
        0x2::event::emit<MintRecipientRemovedEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_minted_event<T0>(arg0: u64, arg1: address, arg2: address) {
        let v0 = Minted<T0>{
            amount    : arg0,
            sender    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<Minted<T0>>(v0);
    }

    public(friend) fun emit_new_version_event<T0>(arg0: u16, arg1: address) {
        let v0 = NewVersionEvent<T0>{
            version : arg0,
            sender  : arg1,
        };
        0x2::event::emit<NewVersionEvent<T0>>(v0);
    }

    public(friend) fun emit_pause_event<T0, T1>(arg0: address, arg1: bool) {
        let v0 = PauseEvent<T0, T1>{
            paused : arg1,
            sender : arg0,
        };
        0x2::event::emit<PauseEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_removed_from_blocklist_event<T0, T1>(arg0: address, arg1: address) {
        let v0 = RemovedFromBlocklistEvent<T0, T1>{
            unblocked_address : arg0,
            sender            : arg1,
        };
        0x2::event::emit<RemovedFromBlocklistEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_stablecoin_registered_event<T0, T1>(arg0: address) {
        let v0 = StablecoinRegisteredEvent<T0, T1>{sender: arg0};
        0x2::event::emit<StablecoinRegisteredEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_stablecoin_unregistered_event<T0, T1>(arg0: address) {
        let v0 = StablecoinUnregisteredEvent<T0, T1>{sender: arg0};
        0x2::event::emit<StablecoinUnregisteredEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_unwrapped_event<T0, T1>(arg0: u64, arg1: address) {
        let v0 = UnwrappedEvent<T0, T1>{
            amount : arg0,
            sender : arg1,
        };
        0x2::event::emit<UnwrappedEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_wrapped_event<T0, T1>(arg0: u64, arg1: address, arg2: address) {
        let v0 = WrappedEvent<T0, T1>{
            amount    : arg0,
            recipient : arg1,
            sender    : arg2,
        };
        0x2::event::emit<WrappedEvent<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

