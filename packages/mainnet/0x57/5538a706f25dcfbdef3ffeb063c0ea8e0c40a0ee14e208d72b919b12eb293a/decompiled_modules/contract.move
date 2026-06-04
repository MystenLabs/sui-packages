module 0x575538a706f25dcfbdef3ffeb063c0ea8e0c40a0ee14e208d72b919b12eb293a::contract {
    struct SignKaroContract has key {
        id: 0x2::object::UID,
        blob_id: 0x1::string::String,
        doc_hash: 0x1::string::String,
        title: 0x1::string::String,
        initiator: address,
        counterparty: address,
        initiator_signed: bool,
        counterparty_signed: bool,
        initiator_signed_at: 0x1::option::Option<u64>,
        counterparty_signed_at: 0x1::option::Option<u64>,
        created_at: u64,
        status: u8,
    }

    struct ContractCreated has copy, drop {
        contract_id: 0x2::object::ID,
        initiator: address,
        counterparty: address,
        blob_id: 0x1::string::String,
    }

    struct ContractSigned has copy, drop {
        contract_id: 0x2::object::ID,
        signer: address,
        status: u8,
    }

    public fun create_contract(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = SignKaroContract{
            id                     : 0x2::object::new(arg5),
            blob_id                : arg0,
            doc_hash               : arg1,
            title                  : arg2,
            initiator              : v0,
            counterparty           : arg3,
            initiator_signed       : true,
            counterparty_signed    : false,
            initiator_signed_at    : 0x1::option::some<u64>(v1),
            counterparty_signed_at : 0x1::option::none<u64>(),
            created_at             : v1,
            status                 : 1,
        };
        let v3 = ContractCreated{
            contract_id  : 0x2::object::id<SignKaroContract>(&v2),
            initiator    : v0,
            counterparty : arg3,
            blob_id      : v2.blob_id,
        };
        0x2::event::emit<ContractCreated>(v3);
        0x2::transfer::share_object<SignKaroContract>(v2);
    }

    public fun get_contract_state(arg0: &SignKaroContract) : (0x1::string::String, 0x1::string::String, 0x1::string::String, address, address, bool, bool, u8) {
        (arg0.blob_id, arg0.doc_hash, arg0.title, arg0.initiator, arg0.counterparty, arg0.initiator_signed, arg0.counterparty_signed, arg0.status)
    }

    public fun has_signed(arg0: &SignKaroContract, arg1: address) : bool {
        arg1 == arg0.initiator && arg0.initiator_signed || arg1 == arg0.counterparty && arg0.counterparty_signed
    }

    public fun sign_contract(arg0: &mut SignKaroContract, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.counterparty, 1);
        assert!(!arg0.counterparty_signed, 2);
        arg0.counterparty_signed = true;
        arg0.counterparty_signed_at = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1));
        arg0.status = 2;
        let v1 = ContractSigned{
            contract_id : 0x2::object::id<SignKaroContract>(arg0),
            signer      : v0,
            status      : arg0.status,
        };
        0x2::event::emit<ContractSigned>(v1);
    }

    // decompiled from Move bytecode v7
}

