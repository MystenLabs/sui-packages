module 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::cluster_connection {
    struct Receipt has copy, drop, store {
        src_nid: 0x1::string::String,
        conn_sn: u128,
    }

    struct ConnectionState has store {
        conn_sn: u128,
        relayer: address,
        receipts: 0x2::table::Table<Receipt, bool>,
    }

    struct Message has copy, drop {
        to: 0x1::string::String,
        conn_sn: u128,
        msg: vector<u8>,
    }

    public(friend) fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : ConnectionState {
        ConnectionState{
            conn_sn  : 0,
            relayer  : arg0,
            receipts : 0x2::table::new<Receipt, bool>(arg1),
        }
    }

    fun get_next_conn_sn(arg0: &mut ConnectionState) : u128 {
        let v0 = arg0.conn_sn + 1;
        arg0.conn_sn = v0;
        v0
    }

    public fun get_receipt(arg0: &ConnectionState, arg1: 0x1::string::String, arg2: u128) : bool {
        let v0 = Receipt{
            src_nid : arg1,
            conn_sn : arg2,
        };
        0x2::table::contains<Receipt, bool>(&arg0.receipts, v0)
    }

    public fun get_relayer(arg0: &ConnectionState) : address {
        arg0.relayer
    }

    public(friend) fun receive_message(arg0: &mut ConnectionState, arg1: 0x1::string::String, arg2: u128, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) : 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::OrderMessage {
        assert!(arg0.relayer == 0x2::tx_context::sender(arg4), 9223372225833336831);
        let v0 = Receipt{
            src_nid : arg1,
            conn_sn : arg2,
        };
        assert!(!0x2::table::contains<Receipt, bool>(&arg0.receipts, v0), 9223372234423271423);
        0x2::table::add<Receipt, bool>(&mut arg0.receipts, v0, true);
        0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::decode(&arg3)
    }

    public(friend) fun send_message(arg0: &mut ConnectionState, arg1: 0x1::string::String, arg2: vector<u8>) {
        let v0 = Message{
            to      : arg1,
            conn_sn : get_next_conn_sn(arg0),
            msg     : arg2,
        };
        0x2::event::emit<Message>(v0);
    }

    public(friend) fun set_relayer(arg0: &mut ConnectionState, arg1: address) {
        arg0.relayer = arg1;
    }

    // decompiled from Move bytecode v6
}

