module 0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct CreateGasPoolEventV1 has copy, drop {
        gas_pool_id: 0x2::object::ID,
        owner: address,
    }

    struct JoinGasPoolEventV1 has copy, drop {
        gas_pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct SplitGasPoolEventV1 has copy, drop {
        gas_pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct SponsorEventV1 has copy, drop {
        gas_pool_id: 0x2::object::ID,
        storage_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct AuthorizeGasPoolAddressEventV1 has copy, drop {
        gas_pool_id: 0x2::object::ID,
        authorized_address: address,
    }

    struct DeauthorizeGasPoolAddressEventV1 has copy, drop {
        gas_pool_id: 0x2::object::ID,
        deauthorized_address: address,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_authorize_gas_pool_address_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = AuthorizeGasPoolAddressEventV1{
            gas_pool_id        : arg0,
            authorized_address : arg1,
        };
        emit<AuthorizeGasPoolAddressEventV1>(v0);
    }

    public(friend) fun emit_create_gas_pool_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = CreateGasPoolEventV1{
            gas_pool_id : arg0,
            owner       : arg1,
        };
        emit<CreateGasPoolEventV1>(v0);
    }

    public(friend) fun emit_deauthorize_gas_pool_address_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = DeauthorizeGasPoolAddressEventV1{
            gas_pool_id          : arg0,
            deauthorized_address : arg1,
        };
        emit<DeauthorizeGasPoolAddressEventV1>(v0);
    }

    public(friend) fun emit_join_gas_pool_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = JoinGasPoolEventV1{
            gas_pool_id : arg0,
            amount      : arg1,
        };
        emit<JoinGasPoolEventV1>(v0);
    }

    public(friend) fun emit_split_gas_pool_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = SplitGasPoolEventV1{
            gas_pool_id : arg0,
            amount      : arg1,
        };
        emit<SplitGasPoolEventV1>(v0);
    }

    public(friend) fun emit_sponsor_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = SponsorEventV1{
            gas_pool_id : arg0,
            storage_id  : arg1,
            recipient   : arg2,
            amount      : arg3,
        };
        emit<SponsorEventV1>(v0);
    }

    // decompiled from Move bytecode v6
}

