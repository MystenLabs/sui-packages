module 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::events {
    struct SignersRotated has copy, drop {
        epoch: u64,
        signers_hash: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32,
        signers: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::WeightedSigners,
    }

    struct ChannelCreated has copy, drop {
        id: address,
    }

    struct ChannelDestroyed has copy, drop {
        id: address,
    }

    struct ContractCall has copy, drop {
        source_id: address,
        destination_chain: 0x1::ascii::String,
        destination_address: 0x1::ascii::String,
        payload: vector<u8>,
        payload_hash: address,
    }

    struct MessageApproved has copy, drop {
        message: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message::Message,
    }

    struct MessageExecuted has copy, drop {
        message: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message::Message,
    }

    public(friend) fun channel_created(arg0: address) {
        let v0 = ChannelCreated{id: arg0};
        0x2::event::emit<ChannelCreated>(v0);
    }

    public(friend) fun channel_destroyed(arg0: address) {
        let v0 = ChannelDestroyed{id: arg0};
        0x2::event::emit<ChannelDestroyed>(v0);
    }

    public(friend) fun contract_call(arg0: address, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: address) {
        let v0 = ContractCall{
            source_id           : arg0,
            destination_chain   : arg1,
            destination_address : arg2,
            payload             : arg3,
            payload_hash        : arg4,
        };
        0x2::event::emit<ContractCall>(v0);
    }

    public(friend) fun message_approved(arg0: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message::Message) {
        let v0 = MessageApproved{message: arg0};
        0x2::event::emit<MessageApproved>(v0);
    }

    public(friend) fun message_executed(arg0: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message::Message) {
        let v0 = MessageExecuted{message: arg0};
        0x2::event::emit<MessageExecuted>(v0);
    }

    public(friend) fun signers_rotated(arg0: u64, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32, arg2: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::WeightedSigners) {
        let v0 = SignersRotated{
            epoch        : arg0,
            signers_hash : arg1,
            signers      : arg2,
        };
        0x2::event::emit<SignersRotated>(v0);
    }

    // decompiled from Move bytecode v6
}

