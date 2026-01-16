module 0x4efe032cc4fc2b20766759f002ca6738e58919379a7dc3dc6b8969988d9fa55e::dummy_receiver {
    struct DUMMY_RECEIVER has drop {
        dummy_field: bool,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        receiver_address: address,
    }

    struct ReceivedMessage has copy, drop {
        message_id: vector<u8>,
        source_chain_selector: u64,
        sender: vector<u8>,
        data: vector<u8>,
        dest_token_transfer_length: u64,
        dest_token_amounts: vector<TokenAmount>,
    }

    struct CCIPReceiverState has key {
        id: 0x2::object::UID,
        counter: u64,
        message_id: vector<u8>,
        source_chain_selector: u64,
        sender: vector<u8>,
        data: vector<u8>,
        message_receiver: address,
        token_receiver: address,
        dest_token_transfer_length: u64,
        dest_token_amounts: vector<TokenAmount>,
    }

    struct DummyReceiverProof has drop {
        dummy_field: bool,
    }

    struct PublisherKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TokenAmount has copy, drop, store {
        token: address,
        amount: u256,
    }

    public fun register_receiver(arg0: &OwnerCap, arg1: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef) {
        let v0 = PublisherKey{dummy_field: false};
        let v1 = DummyReceiverProof{dummy_field: false};
        let v2 = DummyReceiverProof{dummy_field: false};
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::receiver_registry::register_receiver<DummyReceiverProof>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::publisher_wrapper::create<DummyReceiverProof>(0x2::dynamic_field::borrow<PublisherKey, 0x2::package::Publisher>(&arg0.id, v0), v1), v2);
    }

    public fun ccip_receive(arg0: vector<u8>, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg2: 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiMessage, arg3: &0x2::clock::Clock, arg4: &mut CCIPReceiverState) {
        let v0 = DummyReceiverProof{dummy_field: false};
        let (v1, v2, v3, v4, v5, v6, v7) = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::offramp_state_helper::consume_any2sui_message<DummyReceiverProof>(arg1, arg2, v0);
        let v8 = v7;
        assert!(v1 == arg0, 0);
        arg4.counter = arg4.counter + 1;
        arg4.message_id = v1;
        arg4.source_chain_selector = v2;
        arg4.sender = v3;
        arg4.data = v4;
        arg4.message_receiver = v5;
        arg4.token_receiver = v6;
        arg4.dest_token_transfer_length = (0x1::vector::length<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiTokenAmount>(&v8) as u64);
        arg4.dest_token_amounts = 0x1::vector::empty<TokenAmount>();
        let v9 = 0;
        while (v9 < arg4.dest_token_transfer_length) {
            let (v10, v11) = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::get_token_and_amount(0x1::vector::borrow<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::client::Any2SuiTokenAmount>(&v8, v9));
            let v12 = TokenAmount{
                token  : v10,
                amount : v11,
            };
            0x1::vector::push_back<TokenAmount>(&mut arg4.dest_token_amounts, v12);
            v9 = v9 + 1;
        };
        assert!(v4 != b"FAIL", 1);
        let v13 = ReceivedMessage{
            message_id                 : v1,
            source_chain_selector      : v2,
            sender                     : v3,
            data                       : v4,
            dest_token_transfer_length : arg4.dest_token_transfer_length,
            dest_token_amounts         : arg4.dest_token_amounts,
        };
        0x2::event::emit<ReceivedMessage>(v13);
    }

    public fun get_counter(arg0: &CCIPReceiverState) : u64 {
        arg0.counter
    }

    public fun get_dest_token_amounts(arg0: &CCIPReceiverState) : vector<TokenAmount> {
        arg0.dest_token_amounts
    }

    public fun get_token_amount_amount(arg0: &TokenAmount) : u256 {
        arg0.amount
    }

    public fun get_token_amount_token(arg0: &TokenAmount) : address {
        arg0.token
    }

    public fun get_token_receiver(arg0: &CCIPReceiverState) : address {
        arg0.token_receiver
    }

    fun init(arg0: DUMMY_RECEIVER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CCIPReceiverState{
            id                         : 0x2::object::new(arg1),
            counter                    : 0,
            message_id                 : b"",
            source_chain_selector      : 0,
            sender                     : b"",
            data                       : b"",
            message_receiver           : @0x0,
            token_receiver             : @0x0,
            dest_token_transfer_length : 0,
            dest_token_amounts         : 0x1::vector::empty<TokenAmount>(),
        };
        let v1 = OwnerCap{
            id               : 0x2::object::new(arg1),
            receiver_address : 0x2::object::id_to_address(0x2::object::borrow_id<CCIPReceiverState>(&v0)),
        };
        let v2 = PublisherKey{dummy_field: false};
        0x2::dynamic_field::add<PublisherKey, 0x2::package::Publisher>(&mut v1.id, v2, 0x2::package::claim<DUMMY_RECEIVER>(arg0, arg1));
        0x2::transfer::share_object<CCIPReceiverState>(v0);
        0x2::transfer::transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun receive_and_send_coin<T0>(arg0: &mut CCIPReceiverState, arg1: &OwnerCap, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg2), arg3);
    }

    public fun receive_and_send_coin_no_owner_cap<T0>(arg0: &mut CCIPReceiverState, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1), arg2);
    }

    public fun receive_coin<T0>(arg0: &mut CCIPReceiverState, arg1: &OwnerCap, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg2)
    }

    public fun receive_coin_no_owner_cap<T0>(arg0: &mut CCIPReceiverState, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1)
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"DummyReceiver 1.6.0")
    }

    // decompiled from Move bytecode v6
}

