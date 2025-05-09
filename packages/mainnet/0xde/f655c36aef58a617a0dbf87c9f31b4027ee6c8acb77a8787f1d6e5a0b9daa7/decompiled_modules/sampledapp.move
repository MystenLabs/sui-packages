module 0xdef655c36aef58a617a0dbf87c9f31b4027ee6c8acb77a8787f1d6e5a0b9daa7::sampledapp {
    struct SAMPLEDAPP has drop {
        dummy_field: bool,
    }

    struct DappState has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct Params has drop {
        type_args: vector<0x1::string::String>,
        args: vector<0x1::string::String>,
    }

    public fun get_dapp_address(arg0: &DappState) : 0x1::string::String {
        0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::utils::get_package_address(&arg0.publisher, 0x2::object::uid_to_inner(&arg0.id))
    }

    entry fun get_recv_message_args(arg0: &DappState, arg1: vector<u8>) : Params {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::utils::id_to_hex_string(&v1));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"connection_id"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"src_chain_id"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"src_address"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"conn_sn"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"payload"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"signatures"));
        Params{
            type_args : 0x1::vector::empty<0x1::string::String>(),
            args      : v0,
        }
    }

    fun init(arg0: SAMPLEDAPP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DappState{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<SAMPLEDAPP>(arg0, arg1),
        };
        0x2::transfer::public_share_object<DappState>(v0);
    }

    entry fun recv_message(arg0: &DappState, arg1: &mut 0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::State, arg2: u256, arg3: vector<u8>, arg4: u256, arg5: vector<u8>, arg6: vector<vector<u8>>) {
        0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::verify_message(arg1, 0x2::object::uid_to_inner(&arg0.id), &arg0.publisher, arg2, arg3, arg4, arg5, arg6);
        0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::send_message(arg1, 0x2::object::uid_to_inner(&arg0.id), &arg0.publisher, arg2, arg3, b"msg received");
    }

    entry fun send_message(arg0: &DappState, arg1: &mut 0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::State, arg2: u256, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::send_message(arg1, 0x2::object::uid_to_inner(&arg0.id), &arg0.publisher, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

